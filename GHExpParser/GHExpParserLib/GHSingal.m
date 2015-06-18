//
//  GHSingal.m
//  ExpParser
//
//  Created by ZhaoGuangHui on 15/6/17.
//  Copyright (c) 2015年 ZhaoGuangHui. All rights reserved.
//

#import "GHSingal.h"
#pragma mark - 基本运算
@interface _GHSingalAdd : GHSingal
@end

@implementation _GHSingalAdd
-(id)init
{
    self = [super init];
    if (self) {
        self.level = 5;
        self.needJudge = NO;
        self.judeLevel = self.level;
    }
    return self;
}

-(CGFloat)calculate:(GHStack *)stack
{
    NSNumber *value2 = [stack pop];
    NSNumber *value = [stack pop];
    return [value doubleValue] + [value2 doubleValue];
}
@end

@interface _GHSingalSub : GHSingal
@end

@implementation _GHSingalSub
-(id)init
{
    self = [super init];
    if (self) {
        self.level = 5;
        self.needJudge = NO;
        self.judeLevel = self.level;
    }
    return self;
}

-(CGFloat)calculate:(GHStack *)stack
{
    NSNumber *value2 = [stack pop];
    NSNumber *value = [stack pop];
    return [value doubleValue] - [value2 doubleValue];
}
@end

@interface _GHSingalMul : GHSingal
@end

@implementation _GHSingalMul
-(id)init
{
    self = [super init];
    if (self) {
        self.level = 6;
        self.needJudge = NO;
        self.judeLevel = self.level;
    }
    return self;
}


-(CGFloat)calculate:(GHStack *)stack
{
    NSNumber *value2 = [stack pop];
    NSNumber *value = [stack pop];
    return [value doubleValue] * [value2 doubleValue];
}
@end

@interface _GHSingalDiv : GHSingal
@end

@implementation _GHSingalDiv
-(id)init
{
    self = [super init];
    if (self) {
        self.level = 6;
        self.needJudge = NO;
        self.judeLevel = self.level;
    }
    return self;
}

-(CGFloat)calculate:(GHStack *)stack
{
    NSNumber *value2 = [stack pop];
    NSNumber *value = [stack pop];
    return [value doubleValue] / [value2 doubleValue];
}
@end

#pragma mark - 其他符号
@interface _GHSingalPercent : GHSingal
@end

@implementation _GHSingalPercent
-(id)init
{
    self = [super init];
    if (self) {
        self.level = 6;
        self.needJudge = NO;
        self.judeLevel = self.level;
    }
    return self;
}

-(CGFloat)calculate:(GHStack *)stack
{
    NSNumber *value2 = [stack pop];
    NSNumber *value = [stack pop];
    return [value intValue] % [value2 intValue];
}
@end

@interface _GHSingalPower : GHSingal
@end

@implementation _GHSingalPower
-(id)init
{
    self = [super init];
    if (self) {
        self.level = 7;
        self.needJudge = NO;
        self.judeLevel = self.level;
    }
    return self;
}

-(CGFloat)calculate:(GHStack *)stack
{
    NSNumber *value2 = [stack pop];
    NSNumber *value = [stack pop];
    return  pow([value doubleValue], [value2 doubleValue]);
}
@end

#pragma mark - 括号
@interface _GHSingalLittleLeft : GHSingal
@end

@implementation _GHSingalLittleLeft
-(id)init
{
    self = [super init];
    if (self) {
        self.level = 11;
        self.needJudge = YES;
        self.judgeBeginOrEnd = YES;
    }
    return self;
}
@end


@interface _GHSingalLittleRight : GHSingal
@end

@implementation _GHSingalLittleRight
-(id)init
{
    self = [super init];
    if (self) {
        self.level = 11;
        self.needJudge = YES;
        self.judgeBeginOrEnd = NO;
    }
    return self;
}
@end




@interface _GHSingalMiddelLeft : GHSingal
@end

@implementation _GHSingalMiddelLeft
-(id)init
{
    self = [super init];
    if (self) {
        self.level = 10;
        self.needJudge = YES;
        self.judgeBeginOrEnd = YES;
    }
    return self;
}
@end


@interface _GHSingalMiddelRight : GHSingal
@end

@implementation _GHSingalMiddelRight
-(id)init
{
    self = [super init];
    if (self) {
        self.level = 10;
        self.needJudge = YES;
        self.judgeBeginOrEnd = NO;
    }
    return self;
}
@end


@interface _GHSingalLargeLeft : GHSingal
@end

@implementation _GHSingalLargeLeft
-(id)init
{
    self = [super init];
    if (self) {
        self.level = 9;
        self.needJudge = YES;
        self.judgeBeginOrEnd = YES;
    }
    return self;
}
@end


@interface _GHSingalLargeRight : GHSingal
@end

@implementation _GHSingalLargeRight
-(id)init
{
    self = [super init];
    if (self) {
        self.level = 9;
        self.needJudge = YES;
        self.judgeBeginOrEnd = NO;
    }
    return self;
}
@end

#pragma mark - 函数
@interface _GHSingalSin : GHSingal
@end

@implementation _GHSingalSin
-(id)init
{
    self = [super init];
    if (self) {
        self.level = 7;
        self.needJudge = NO;
        self.judeLevel = self.level;
    }
    return self;
}

-(CGFloat)calculate:(GHStack *)stack
{
    NSNumber *value = [stack pop];
    return sin([value doubleValue]);
}
@end


@interface _GHSingalCos : GHSingal
@end

@implementation _GHSingalCos
-(id)init
{
    self = [super init];
    if (self) {
        self.level = 7;
        self.needJudge = NO;
        self.judeLevel = self.level;
    }
    return self;
}

-(CGFloat)calculate:(GHStack *)stack
{
    NSNumber *value = [stack pop];
    return cos([value doubleValue]);
}
@end


@interface _GHSingalTan : GHSingal
@end

@implementation _GHSingalTan
-(id)init
{
    self = [super init];
    if (self) {
        self.level = 7;
        self.needJudge = NO;
        self.judeLevel = self.level;
    }
    return self;
}

-(CGFloat)calculate:(GHStack *)stack
{
    NSNumber *value = [stack pop];
    return tan([value doubleValue]);
}
@end



@interface _GHSingalCot : GHSingal
@end

@implementation _GHSingalCot
-(id)init
{
    self = [super init];
    if (self) {
        self.level = 7;
        self.needJudge = NO;
        self.judeLevel = self.level;
    }
    return self;
}

-(CGFloat)calculate:(GHStack *)stack
{
    NSNumber *value = [stack pop];
    return 1/tan([value doubleValue]);
}
@end

@interface _GHSingalSec : GHSingal
@end

@implementation _GHSingalSec
-(id)init
{
    self = [super init];
    if (self) {
        self.level = 7;
        self.needJudge = NO;
        self.judeLevel = self.level;
    }
    return self;
}

-(CGFloat)calculate:(GHStack *)stack
{
    NSNumber *value = [stack pop];
    return 1/cos([value doubleValue]);
}
@end

@interface _GHSingalCsc : GHSingal
@end

@implementation _GHSingalCsc
-(id)init
{
    self = [super init];
    if (self) {
        self.level = 7;
        self.needJudge = NO;
        self.judeLevel = self.level;
    }
    return self;
}

-(CGFloat)calculate:(GHStack *)stack
{
    NSNumber *value = [stack pop];
    return 1/sin([value doubleValue]);
}
@end

@interface _GHSingalSqrt : GHSingal
@end

@implementation _GHSingalSqrt
-(id)init
{
    self = [super init];
    if (self) {
        self.level = 7;
        self.needJudge = NO;
        self.judeLevel = self.level;
    }
    return self;
}

-(CGFloat)calculate:(GHStack *)stack
{
    NSNumber *value = [stack pop];
    return sqrt([value doubleValue]);
}
@end

@interface _GHSingalLog : GHSingal
@end

@implementation _GHSingalLog
-(id)init
{
    self = [super init];
    if (self) {
        self.level = 7;
        self.needJudge = NO;
        self.judeLevel = self.level;
    }
    return self;
}

-(CGFloat)calculate:(GHStack *)stack
{
    NSNumber *value = [stack pop];
    return log2([value doubleValue]);
}
@end

@interface _GHSingalLn : GHSingal
@end

@implementation _GHSingalLn
-(id)init
{
    self = [super init];
    if (self) {
        self.level = 7;
        self.needJudge = NO;
        self.judeLevel = self.level;
    }
    return self;
}

-(CGFloat)calculate:(GHStack *)stack
{
    NSNumber *value = [stack pop];
    return log([value doubleValue]);
}
@end


@implementation GHSingal
-(CGFloat)calculate:(GHStack *)stack
{
    return  0.0;
}

+(GHSingal *)SignalWithString:(NSString *)str
{
    if (str.length == 1) {
        return [self SignalWithChar:[str characterAtIndex:0]];
    }
    else
    {
        if ([str isEqualToString:@"sin"]) {
            return [_GHSingalSin new];
        }
        if ([str isEqualToString:@"cos"]) {
            return [_GHSingalCos new];
        }
        if ([str isEqualToString:@"tan"]) {
            return [_GHSingalTan new];
        }
        if ([str isEqualToString:@"cot"]) {
            return [_GHSingalCot new];
        }
        if ([str isEqualToString:@"sec"]) {
            return [_GHSingalTan new];
        }
        if ([str isEqualToString:@"csc"]) {
            return [_GHSingalCot new];
        }
        if ([str isEqualToString:@"sqrt"]) {
            return [_GHSingalSqrt new];
        }
        if ([str isEqualToString:@"log"]) {
            return [_GHSingalLog new];
        }
        if ([str isEqualToString:@"ln"]) {
            return [_GHSingalLn new];
        }
        return nil;
    }
}

+(GHSingal*)SignalWithChar:(char)ch
{
    switch (ch) {
        case '+':
            return [_GHSingalAdd new];
        case '-':
            return [_GHSingalSub new];
        case '*':
            return [_GHSingalMul new];
        case '/':
            return [_GHSingalDiv new];
        case '%':
            return [_GHSingalPercent new];
        case '^':
            return [_GHSingalPower new];
        case '(':
            return [_GHSingalLittleLeft new];
        case ')':
            return [_GHSingalLittleRight new];
        case '[':
            return [_GHSingalMiddelLeft new];
        case ']':
            return [_GHSingalMiddelRight new];
        case '{':
            return [_GHSingalLargeLeft new];
        case '}':
            return [_GHSingalLargeRight new];
        default:
            break;
    }
    return nil;
}
@end
