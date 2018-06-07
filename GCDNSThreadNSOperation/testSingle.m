//
//  testSingle.m
//  GCDNSThreadNSOperation
//
//  Created by ZYQ on 2018/6/5.
//  Copyright © 2018年 eilsel. All rights reserved.
//

#import "testSingle.h"

@implementation testSingle
+(instancetype)single
{
    static dispatch_once_t onceToken;
    static testSingle * ins = nil;
    dispatch_once(&onceToken, ^{
        NSLog(@"init");
        ins = [[testSingle alloc]init];
    });
    return ins;
    
    
}
@end
