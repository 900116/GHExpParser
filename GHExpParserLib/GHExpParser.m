//
//  ExpParser.m
//  ExpParser
//
//  Created by ZhaoGuangHui on 15/6/18.
//  Copyright (c) 2015年 ZhaoGuangHui. All rights reserved.
//

#import "GHExpParser.h"
#import "GHSingal.h"

typedef NS_ENUM(int, GHReadMode)
{
    GHReadModeFunc,
    GHReadModeConstant,
    GHReadModeNumber,
    GHReadModeNone
};

@interface GHStack ()
@property(nonatomic,strong) NSMutableArray *arry;
@end

@implementation GHStack
-(id)init
{
    self = [super init];
    if (self) {
        self.arry = [NSMutableArray new];
    }
    return self;
}

-(void)push:(id)obj
{
    [_arry addObject:obj];
}

-(id)pop
{
    if (_arry.count == 0) {
        return nil;
    }
    id obj = _arry[_arry.count-1];
    [_arry removeObjectAtIndex:_arry.count-1];
    return obj;
}

-(id)top
{
    if (_arry.count == 0) {
        return nil;
    }
    return _arry[_arry.count-1];
}

-(NSInteger)size
{
    return _arry.count;
}

-(void)clear
{
    [_arry removeAllObjects];
}

-(BOOL)isEmpty
{
    return _arry.count == 0;
}
@end

@implementation GHExpParser
+(BOOL)supportCharacter:(char)ch
{
    char fucChars[] = {'s','n','c','o','t','a','q','r','l','g','i','p','e'};
    for (int i = 0; i < 13; ++i) {
        char t = fucChars[i];
        if (t == ch || t-32 == ch) {
            return YES;
        }
    }
    return NO;
}

+(void)dealWithBaseSignal:(GHStack *)stack fStack:(GHStack *)fStack signal:(GHSingal *)signal
{
    if (![stack isEmpty]) {
        do {
            GHSingal *p = [stack pop];
            if (signal.judeLevel > p.judeLevel) {
                [stack push:p];
                [stack push:signal];
                break;
            }
            else
            {
                [fStack push:p];
                if ([stack isEmpty]) {
                    [stack push:signal];
                    break;
                }
            }
            
        } while (![stack isEmpty]);
    }
    else
    {
        [stack push:signal];
    }
}

+(BOOL)isFucString:(NSString *)str
{
    NSArray *array = @[@"sin",@"cos",@"tan",@"cot",@"sec",@"csc",@"ln",@"log",@"sqrt"];
    return [array containsObject:str];
}

+(BOOL)isSignalCharacter:(char)ch
{
    char beigns[] = {'+','-','*','/','%','^'};
    for (int i = 0; i < 6; ++i) {
        char t = beigns[i];
        if (t == ch || t-32 == ch) {
            return YES;
        }
    }
    return NO;
}

+(BOOL)isLeft:(char)ch
{
    char beigns[] = {'(','[','{'};
    for (int i = 0; i < 3; ++i) {
        char t = beigns[i];
        if (t == ch || t-32 == ch) {
            return YES;
        }
    }
    return NO;
}

+(BOOL)isRight:(char)ch
{
    char beigns[] = {')',']','}'};
    for (int i = 0; i < 3; ++i) {
        char t = beigns[i];
        if (t == ch || t-32 == ch) {
            return YES;
        }
    }
    return NO;
}

+(BOOL)isNumber:(char)ch
{
    return ((ch <= '9' && ch >= '0') || ch == '.');
}

+(BOOL)isConstantBegin:(char)ch
{
    char fucChars[] = {'p','e'};
    for (int i = 0; i < 2; ++i) {
        char t = fucChars[i];
        if (t == ch || t-32 == ch) {
            return YES;
        }
    }
    return NO;
}

+(BOOL)isRightStr:(NSString *)exp
{
    BOOL signal = NO;
    GHStack *statck = [GHStack new];
    for (int i = 0; i < exp.length; ++i) {
        char ch = [exp characterAtIndex:i];
        if ([self isSignalCharacter:ch]) {
            if (signal) {
                return NO;
            }
            signal = YES;
        }
        else
        {
            signal = NO;
        }
        if ([self isLeft:ch]) {
            [statck push:@(ch)];
        }
        else if([self isRight:ch])
        {
            if ([statck size] == 0) {
                return NO;
            }
            [statck pop];
        }
    }
    if ([statck size] != 0) {
        return NO;
    }
    return YES;
}

+(NSNumber *)isEspecConstatntString:(NSString *)str
{
    NSArray *array = @[@"e",@"pi"];
    NSArray *value = @[@(M_E),@(M_PI)];
    NSInteger idx = [array indexOfObject:str];
    if (idx == NSNotFound) {
        return nil;
    }
    else
    {
        return value[idx];
    }
}

+(NSNumber *)parserExp:(NSString *)exp
{
    if (![self isRightStr:exp]) {
        NSLog(@"错误的表达式");
        return nil;
    }
    GHStack *stack = [GHStack new];
    GHStack *fStack = [GHStack new];
    NSMutableString *numberString = [NSMutableString new];
    NSMutableString *fucString = [NSMutableString new];
    NSMutableString *costantString = [NSMutableString new];
    GHReadMode mode = GHReadModeNone;
    for (int i = 0; i < exp.length; ++i) {
        //如果是函数（ex：sin，cos，sec）
        if ([self isFucString:fucString]) {
            GHSingal* signal = [GHSingal SignalWithString:fucString];
            [self dealWithBaseSignal:stack fStack:fStack signal:signal];
            fucString = [NSMutableString new];
            mode = GHReadModeNone;
        }
        //如果可能是特殊常数 （ex：pi，e）
        NSNumber *number = [self isEspecConstatntString:costantString];
        if (number) {
            [fStack push:number];
            costantString = [NSMutableString new];
            mode = GHReadModeNone;
        }
        
        char ch = [exp characterAtIndex:i];
        //数字
        if ([self isNumber:ch]) {
            [numberString appendFormat:@"%c",ch];
            mode = GHReadModeNumber;
        }
        //空格
        else if (ch == ' ')
        {
            continue;
        }
        else //不是数字
        {
            if (numberString.length > 0) {
                [fStack push:@(numberString.doubleValue)];
                numberString = [NSMutableString new];
            }
            //左括号
            if ([self isLeft:ch])
            {
                GHSingal *signal = [GHSingal SignalWithChar:ch];
                [stack push:signal];
                mode = GHReadModeNone;
            }
            //右括号
            else if ([self isRight:ch])
            {
                GHSingal *signal = [GHSingal SignalWithChar:ch];
                while (![stack isEmpty]) {
                    GHSingal *sig = [stack pop];
                    if (sig.judgeBeginOrEnd == YES && sig.level == signal.level) {
                        break;
                    }
                    else
                    {
                        [fStack push:sig];
                    }
                }
                mode = GHReadModeNone;
            }
            //支持的运算符
            else if ([self isSignalCharacter:ch])
            {
                GHSingal *signal = [GHSingal SignalWithChar:ch];
                [self dealWithBaseSignal:stack fStack:fStack signal:signal];
                mode = GHReadModeNone;
            }
            //支持的字母
            else if ([self supportCharacter:ch])
            {
                if (mode==GHReadModeNone || mode== GHReadModeNumber) {
                    if ([self isConstantBegin:ch]) {
                        [costantString appendFormat:@"%c",ch<97?ch+32:ch];
                        mode = GHReadModeConstant;
                    }
                    else
                    {
                        [fucString appendFormat:@"%c",ch<97?ch+32:ch];
                        mode = GHReadModeFunc;
                    }
                }
                else
                {
                    if (mode == GHReadModeFunc) {
                        [fucString appendFormat:@"%c",ch<97?ch+32:ch];
                    }
                    else
                    {
                        [costantString appendFormat:@"%c",ch<97?ch+32:ch];
                    }
                }
            }
            else
            {
                return nil;
            }
        }
        
    }
    if (numberString.length > 0) {
        [fStack push:@([numberString doubleValue])];
    }
    while (![stack isEmpty]) {
        GHSingal *t = [stack pop];
        [fStack push:t];
    }
    
    while (![fStack isEmpty]) {
        [stack push:[fStack pop]];
    }
    //数字栈
    GHStack *nStack = [GHStack new];
    while (![stack isEmpty]) {
        id value = [stack pop];
        if ([value isKindOfClass:[NSNumber class]]) {
            [nStack push:value];
        }
        else
        {
            GHSingal* sig = value;
            [nStack push:@([sig calculate:nStack])];
        }
    }
    return [nStack pop];
}
@end
