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
#import "HTSetView.h"
#import "HTAssetsView.h"

#define header_H 200
@interface HTMyCenterController ()



@property (nonatomic ,strong) HTMyCenterHeader *headerView;
@property (nonatomic ,strong) HTContainerView *container;

@property (nonatomic ,strong) UIView *lineView;
@property (nonatomic ,strong) HTSetView *setView;
@property (nonatomic ,strong) HTAssetsView *assetsView;
@end

@implementation HTMyCenterController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"个人中心";
    //    self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.container];
    [self.view addSubview:self.headerView];

    self.container.frame = CGRectMake(0, 64, SCREEN_W, SCREEN_H - navBar_h - tabbar_h);
    self.headerView.frame = CGRectMake(0, navBar_h, SCREEN_W, header_H);
    NSArray *ary1 = @[@"assets",@"assets",
                      @"assets",@"assets",
                      @"assets",@"assets",
                      @"assets",@"assets",
                      @"assets",@"assets"];
    NSArray *ary2 = @[@"setting",@"setting",
                      @"setting",@"setting"];
    
    [self.container containerWithChildviews:@[self.assetsView,self.setView] content:@{@"HTAssetsView":ary1,@"HTSetView":ary2}];

    [self.headerView headerWithOptions:@[@"assets",@"setting"] ];
    

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectOption:) name:@"htContainerCurrentValue" object:nil];

}
#pragma mark - notification  Method

- (void)selectOption:(NSNotification *)notifi {
    NSInteger index = [notifi.object integerValue] - NormalValue;
    self.headerView.selectIndex = index;
    self.container.selectIndex = index;
    [self.assetsView.tableView setContentOffset:CGPointZero animated:NO];
    [self.setView.tableView setContentOffset:CGPointZero animated:NO];

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
- (HTSetView *)setView {
    if (!_setView) {
        _setView = [[HTSetView alloc] initWithFrame:CGRectZero];
        _setView.delegate = self;
    }
    return _setView;
}
- (HTAssetsView *)assetsView {
    if (!_assetsView) {
        _assetsView = [[HTAssetsView alloc] initWithFrame:CGRectZero];
        _assetsView.delegate = self;
    }
    return _assetsView;
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
