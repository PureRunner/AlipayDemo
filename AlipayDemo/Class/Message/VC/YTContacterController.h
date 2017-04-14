//
//  YTContacterController.h
//  AlipayDemo
//
//  Created by apple on 2017/4/13.
//  Copyright © 2017年 YT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTContactsUsersProtocol.h"

@interface YTContacterController : UIViewController <YTContactsUsersProtocol>

@property (nonatomic ,assign) id <YTContactsUsersProtocol> delegate;
@property (nonatomic ,strong) UITableView *tableView;


@end
