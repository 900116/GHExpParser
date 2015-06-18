//
//  ExpParser.h
//  ExpParser
//
//  Created by ZhaoGuangHui on 15/6/18.
//  Copyright (c) 2015年 ZhaoGuangHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GHStack : NSObject
-(void)push:(id)obj;
-(id)pop;
-(BOOL)isEmpty;
@end

@interface GHExpParser : NSObject
+(NSNumber *)parserExp:(NSString *)exp;
@end
