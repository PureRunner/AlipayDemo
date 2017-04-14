//
//  YTContactsFootView.h
//  eyutong
//
//  Created by apple on 2017/4/6.
//  Copyright © 2017年 Zhengzhou Yutong Bus Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTMsgListController.h"
#import "YTContacterController.h"


@class YTContacterController;
@class YTMsgListController;

@interface YTContactsFootView : UIView


@property (nonatomic ,strong) YTMsgListController *messageVC;
@property (nonatomic ,strong) YTContacterController *contacterVC;


- (id)initWithFrame:(CGRect)frame controller:(UIViewController*)vc;

- (void)selectContactsIndex:(NSInteger)index updateBlock:(void(^)(BOOL isFull))update;

@end
