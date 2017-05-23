//
//  HttpManager.m
//  AlipayDemo
//
//  Created by shuai pan on 2017/4/20.
//  Copyright © 2017年 YT. All rights reserved.
//

#import "HttpManager.h"

@implementation HttpManager

//GCD
+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    static HttpManager *obj;
    
    dispatch_once(&onceToken, ^{
        obj = [[HttpManager alloc] init];
    });
    return obj;
}


@end
