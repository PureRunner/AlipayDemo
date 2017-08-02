//
//  HTMyCenterController.m
//  AlipayDemo
//
//  Created by shuai pan on 2017/5/25.
//  Copyright © 2017年 foreveross. All rights reserved.
//

#import "HTMyCenterController.h"
#import "HTMyCenterHeader.h"

#import "HTContainerView.h"
#import "HTMyCenterTableView.h"

#define header_H 200
@interface HTMyCenterController ()



@property (nonatomic ,strong) HTMyCenterHeader *headerView;
@property (nonatomic ,strong) HTContainerView *container;

@property (nonatomic ,strong) UIView *lineView;


@end

@implementation HTMyCenterController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    self.automaticallyAdjustsScrollViewInsets = NO;
    //    self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.container];
    [self.view addSubview:self.headerView];

    self.container.frame = CGRectMake(0, 64, SCREEN_W, SCREEN_H - navBar_h - tabbar_h);
    self.headerView.frame = CGRectMake(0, navBar_h, SCREEN_W, header_H);
    [self.headerView headerWithOptions:@[@"排行榜",@"圈子",@"资产"]];
    NSArray *ary1 = @[@"AAAA",@"AAAA",
                      @"AAAA",@"AAAA",
                      @"AAAA",@"AAAA",
                      @"AAAA",@"AAAA",
                      @"AAAA",@"AAAA"];
    NSArray *ary2 = @[@"BBBB",@"BBBB",
                      @"BBBB",@"BBBB"];
    NSArray *ary3 = @[@"CCCC",@"CCCC",
                      @"CCCC",@"CCCC",@"CCCC"];
    
    [self.container loadContainer:@{@"aaaa":ary1,@"bbbb":ary2,@"cccc":ary3} withChildProtocol:self];

    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectOption:) name:@"htContainerCurrentValue" object:nil];

}
#pragma mark - notification  Method

- (void)selectOption:(NSNotification *)notifi {
    NSInteger index = [notifi.object integerValue] - NormalValue;
    self.headerView.selectIndex = index;
    self.container.selectIndex = index;
    self.container.childOffsetZero = YES;

}


#pragma mark - HTScrollProtocol

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y;
    CGRect frame = self.headerView.frame;
    CGFloat header_y = offset;
    frame.size.height = header_H;
    if ( offset > 0.f && offset < 160.f) {
        header_y = navBar_h - offset;
    }
    else if (offset > 160.f | offset == 160.f ) {
        header_y = navBar_h - 160.f;
    }
    else {
        header_y = navBar_h;
        frame.size.height = header_H - offset;
    }
    frame.origin.y= header_y;
    self.headerView.frame = frame;
//    NSLog(@"----: %f,=====: %f",offset,frame.origin.y);

}


- (HTContainerView *)container {
    if (!_container) {
        _container = [[HTContainerView alloc] initWithFrame:CGRectZero withHeader:self.headerView];
    }
    return _container;
}



- (HTMyCenterHeader *)headerView {
    if (!_headerView) {
        _headerView = [[HTMyCenterHeader alloc] initWithFrame:CGRectZero];
    }
    return _headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
