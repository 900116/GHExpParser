//
//  GHSingal.h
//  ExpParser
//
//  Created by ZhaoGuangHui on 15/6/17.
//  Copyright (c) 2015年 ZhaoGuangHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ExpParser.h"

/*
    符号类：
 */
@interface GHSingal : NSObject
@property(nonatomic,assign) NSInteger level;
@property(nonatomic,assign) BOOL needJudge;
@property(nonatomic,assign) BOOL judgeBeginOrEnd;
@property(nonatomic,assign) NSInteger judeLevel;

+(GHSingal*)SignalWithChar:(char)ch;
+(GHSingal*)SignalWithString:(NSString *)str;
-(CGFloat)calculate:(GHStack *)stack;
@end
