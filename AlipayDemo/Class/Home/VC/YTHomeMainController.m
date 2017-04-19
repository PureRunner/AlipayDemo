//
//  ViewController.m
//  ScrollView
//
//  Created by apple on 2017/4/10.
//  Copyright © 2017年 YT. All rights reserved.
//


#import "YTHomeMainController.h"
#import "YTHomeHeaderView.h"
//#import "YTLoadingView.h"


CGFloat const  headerView_h = 110.f;

@interface YTHomeMainController () <UIScrollViewDelegate> {
    CGFloat maxOffset ;
    CGSize lastTableContentSize;
    BOOL isLayout;
    CGFloat lastOffset ;

}

@property  (nonatomic ,strong) UIView *navBarBackgroundView;

@end


@implementation YTHomeMainController


#pragma mark - Public Method

- (id)init {
    self = [super init];
    if (self) {
        isLayout = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isLayout = YES;

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.navBarBackgroundView];
    [self.view addSubview:self.lastNavBarView];
    [self.view addSubview:self.firstNavBarView];

    [self.scrollView addSubview:self.headerView];
    [self.scrollView addSubview:self.tableView];
//    [self.scrollView addSubview:self.loadingView];
    [self.scrollView bringSubviewToFront:self.headerView];
    
    maxOffset = headerView_h - line_h;
    self.firstNavBarView.alpha = 1.f;
    
    WEAKSELF
//应用选择回调
    [self.lastNavBarView setSelectAppModels:^(id lastNavBarView, NSInteger selectIndex) {
        if ([weakSelf respondsToSelector:@selector(whereToSelectAppModels:selectIndex:)]) {
            [weakSelf whereToSelectAppModels:lastNavBarView selectIndex:selectIndex];
        }
        
    }];
    [self.headerView setSelectAppModels:^(id headerView, NSInteger selectIndex){
        if ([weakSelf respondsToSelector:@selector(whereToSelectAppModels:selectIndex:)]) {
            [weakSelf whereToSelectAppModels:headerView selectIndex:selectIndex];
        }
    }];
    
    [self.lastNavBarView setShowPopMenuBar:^(UIButton *addButton){
        if ([weakSelf respondsToSelector:@selector(clickAddPopMenuBar:)]) {
            [weakSelf clickAddPopMenuBar:addButton];
        }
    }];
    [self.firstNavBarView setShowPopMenuBar:^(UIButton *addButton){
        if ([weakSelf respondsToSelector:@selector(clickAddPopMenuBar:)]) {
            [weakSelf clickAddPopMenuBar:addButton];
        }
    }];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [self.tableView removeObserver:self forKeyPath:@"contentSize"];
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([[change objectForKey:NSKeyValueChangeKindKey] integerValue] != 1)
        return;
        
    if ([object isEqual:self.tableView] && [keyPath isEqualToString:@"contentSize"]) {
        CGSize newSize = [[change objectForKey:NSKeyValueChangeNewKey] CGSizeValue];
        CGSize oldSize = [[change objectForKey:NSKeyValueChangeOldKey] CGSizeValue];
//        NSLog(@"-- new:%f --old: %f:",newSize.height,oldSize.height);
        if (CGSizeEqualToSize(oldSize, newSize)) return;
        CGSize size = self.tableView.contentSize;
        CGFloat table_h = CGRectGetHeight(self.tableView.frame) + maxOffset;
        size = size.height > table_h ? size:CGSizeMake(CGRectGetWidth(self.tableView.frame), table_h);
        size.height = size.height + headerView_h ;
        self.scrollView.contentSize = size;
        CGRect rect = self.tableView.frame;
        rect.size.height = size.height;
        self.tableView.frame = rect;
        
    }
}


#pragma mark - Private Method

- (void)touchShowAddMenu:(UIButton *)btn{
    [self clickAddPopMenuBar:btn];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
//    if (point.y < -70) {
//        if (!self.loadingView.refreshing) {
//            [self.loadingView beiginRefresh];
//            if ([self respondsToSelector:@selector(refreshData:)]) {
//                [self refreshData:self.loadingView.refreshing];
//            }
//        }
//    }
//    if (self.loadingView.refreshing) {
//        if (point.y < -maxOffset) {
//            point.y = -maxOffset;
//        }
//        [scrollView setContentOffset:point animated:YES];
//    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    lastOffset = y;
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat y = scrollView.contentOffset.y;
    if (y < 0) {
    }
    else if (y > 0 && (y < maxOffset || y == maxOffset)) {
        
        [self scrollViewContentOffset:scrollView];
    }
    else{

    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
//    self.loadingView.hidden = y < 0 ? NO : YES;
//    NSLog(@"aaaaa %f",y);
    if (y < 0 ) {
        CGRect rect = self.headerView.frame;
        rect.origin.y = y;
        self.headerView.frame = rect;
    }
    CGFloat alpha = (1 - y/maxOffset*2.5 ) > 0 ? (1 - y/maxOffset*2.5 ) : 0;
    self.headerView.headerAlpha = alpha;
//    NSLog(@"----111 :%f----: %f",y/maxOffset,alpha);
    if (alpha > 0.5) {
        float newAlpha =  alpha*2 - 1;
        self.firstNavBarView.alpha = newAlpha;
        self.lastNavBarView.alpha = 0;
    } else {
        float newAlpha =  alpha*2;
        self.firstNavBarView.alpha = 0;
        self.lastNavBarView.alpha = 1 - newAlpha;
    }

}
- (void)scrollViewContentOffset:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    NSLog(@"---:%f--last-:%f",y,lastOffset);

    if (lastOffset < y) {
        //上滑
        if (y > 20.f) {
             [scrollView setContentOffset:CGPointMake(0, maxOffset) animated:YES];
        }
        else{
            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
    else{
        if (y < maxOffset - 20){
            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else{
            [scrollView setContentOffset:CGPointMake(0, maxOffset) animated:YES];
        }
    }
}

#pragma mark - UI


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _tableView;
}


- (UIView *)navBarBackgroundView{
    if (!_navBarBackgroundView) {
        _navBarBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _navBarBackgroundView.backgroundColor = self.navBarColor;
    }
    return _navBarBackgroundView;
}
- (YTFirestNavBarView *)firstNavBarView {
    if (!_firstNavBarView) {
        _firstNavBarView = [[YTFirestNavBarView alloc] initWithFrame:CGRectZero];
        _firstNavBarView.backgroundColor = [UIColor clearColor];
        _firstNavBarView.alpha = 0.f;
        
    }
    return _firstNavBarView;
}
- (YTLastNavBarView *)lastNavBarView{
    if (!_lastNavBarView) {
        _lastNavBarView = [[YTLastNavBarView alloc] initWithFrame:CGRectZero];
        _lastNavBarView.backgroundColor = [UIColor clearColor];
        _lastNavBarView.alpha = 0.f;
    }
    return _lastNavBarView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(SCREEN_W, headerView_h);
        _scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(headerView_h, 0, 0, 0);
        _scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _scrollView;
}
- (YTHomeHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[YTHomeHeaderView alloc] initWithFrame:CGRectZero];
        _headerView.backgroundColor = self.navBarColor;
        _headerView.contentView.backgroundColor = self.navBarColor;
        _headerView.lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    }
    return _headerView;
}
//- (YTLoadingView *)loadingView {
//    if (_loadingView == nil) {
//        _loadingView = [[YTLoadingView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_W, 80.f)];
//    }
//    return _loadingView;
//}

- (UIColor *)navBarColor{
    if (!_navBarColor) {
        return [HXColor hx_colorWithHexRGBAString:@"#4876FF" alpha:1.f];
    }
    return _navBarColor;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (!isLayout) return;
    CGRect navRect = CGRectMake(0.f, 0.f, SCREEN_W, navBar_h);
    self.navBarBackgroundView.frame = navRect;
    self.lastNavBarView.frame = navRect;
    self.firstNavBarView.frame = navRect;
    
    CGFloat scroll_y = CGRectGetMaxY(self.navBarBackgroundView.frame);
    self.scrollView.frame = CGRectMake(0.f, scroll_y, SCREEN_W, SCREEN_H - navBar_h - tabbar_h);
    
    self.headerView.frame = CGRectMake(0.f, 0.f, SCREEN_W, headerView_h);
    
    CGFloat table_y = CGRectGetHeight(self.headerView.frame);
    CGFloat table_h = CGRectGetHeight(self.scrollView.frame) - CGRectGetHeight(self.headerView.frame);
    self.tableView.frame = CGRectMake(0, table_y, SCREEN_W, table_h);
//    self.loadingView.frame = CGRectMake(0, table_y - 80.f, SCREEN_W, 80.f);
    isLayout = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
