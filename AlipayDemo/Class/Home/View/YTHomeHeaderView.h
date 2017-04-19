//
//  HeaderView.h
//  ScrollView
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 YT. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YTHomeHeaderView : UIView

//头部视图
@property (nonatomic ,strong) UIView *contentView;

//头部分割线
@property (nonatomic ,strong) UIView *lineView;

//头部视图透明度
@property (nonatomic ,assign) CGFloat headerAlpha;

//头部Item事件
@property (nonatomic ,copy) void(^selectAppModels)(id ,NSInteger);

//头部数据
@property (nonatomic ,strong) NSMutableArray *bigApps;



@end


@interface YTFirestNavBarView : UIView

//搜索框
@property (nonatomic, strong) UITextField *searchBox;

//上层导航右侧点击事件
@property (nonatomic ,copy) void(^showPopMenuBar)(UIButton *);

@end


@interface YTLastNavBarView : UIView

//底层导航数据
@property (nonatomic ,strong) NSMutableArray *samllApps;

//底层导航点击事件
@property (nonatomic ,copy) void(^selectAppModels)(id ,NSInteger);

//底层导航右侧点击事件
@property (nonatomic ,copy) void(^showPopMenuBar)(UIButton *);


@end
