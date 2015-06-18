//
//  ViewController.m
//  GHExpParser
//
//  Created by YongCheHui on 15/6/18.
//  Copyright (c) 2015年 FengHuang. All rights reserved.
//

#import "ViewController.h"
#import "GHExpParser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
        support baseOperater: + - * / % ^
                              the '^' is cube
        support moreFuction: sin cos tan cot sec csc log ln sqrt
                              the 'log' baseNumber is 2
                              the 'ln' baseNumber is e
        support sepcConstant: pi e
        support brakets: () [] {}
     */
    NSLog(@"%@",[GHExpParser parserExp:@"3+(4*5)-2^2"]); // ok
    
    NSLog(@"%@",[GHExpParser parserExp:@"3+[(4*5)-2]-sin(PI/2)"]); // ok
    
    NSLog(@"%@",[GHExpParser parserExp:@"6%4"]); // ok
    
    NSLog(@"%@",[GHExpParser parserExp:@"(2+3*5"]); //error return nil
    
    NSLog(@"%@",[GHExpParser parserExp:@"3*4+2)"]); //error
    
    NSLog(@"%@",[GHExpParser parserExp:@"3*((4+2)"]); //error
   
    NSLog(@"%@",[GHExpParser parserExp:@"3*/4+2"]); //error
    
    NSLog(@"%@",[GHExpParser parserExp:@"3*x+2"]); //error not support alphabet
    
    NSLog(@"%@",[GHExpParser parserExp:@"3+sinPI/2"]);//  is equal  sinPi / 2   not   sin(Pi/2)
    
    NSLog(@"%@",[GHExpParser parserExp:@"3+sin(PI/2)"]);//  real sin(Pi/2)
   
    NSLog(@"%@",[GHExpParser parserExp:@"3+SInPi/2"]);// ignore capitalized or lowercase
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
