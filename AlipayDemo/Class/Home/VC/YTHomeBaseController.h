//
//  ViewController.h
//  ScrollView
//
//  Created by apple on 2017/4/10.
//  Copyright © 2017年 YT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTHomeActionProtocol.h"

//@class YTLoadingView;
@class YTHomeHeaderView;
@class YTLastNavBarView;
@class YTFirestNavBarView;




@interface YTHomeBaseController :UIViewController  <YTHomeActionProtocol>


@property (nonatomic ,assign) BOOL isRefreshing;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) UIScrollView *scrollView;

//上层导航
@property (nonatomic ,strong) YTFirestNavBarView *firstNavBarView;

//下层导航
@property (nonatomic ,strong) YTLastNavBarView *lastNavBarView;

//头部视图
@property  (nonatomic ,strong) YTHomeHeaderView *headerView;

//刷新视图
//@property (nonatomic, strong) YTLoadingView *loadingView;

////搜索框
//@property (nonatomic, strong) UITextField *searchBox;


//导航背景色
@property (nonatomic ,strong) UIColor *navBarColor;




@end

