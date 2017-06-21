//
//  HTContainerView.m
//  TestPlatform
//
//  Created by shuai pan on 2017/5/26.
//  Copyright © 2017年 foreveross. All rights reserved.
//

#import "HTContainerView.h"
#import "HTBaseView.h"



@interface HTContainerView ()<UIScrollViewDelegate>


@property (nonatomic ,strong) UIView *header;
@property (nonatomic ,strong) NSArray *childViews;

@end

@implementation HTContainerView

- (id)initWithFrame:(CGRect)frame withHeader:(UIView *)header {
    self = [super initWithFrame:frame];
    if (self) {
        self.header = header;
        [self ht_initializeControls];
    }
    return self;
}
//加载内容
- (void)containerWithChildviews:(NSArray *)childviews content:(NSDictionary *)dict {
    if (childviews.count <1) return;
    self.childViews = childviews;
    
    NSArray *subviews = self.scrollView.subviews;
    //数据重置
    BOOL scrollViewExistsSubview = subviews.count>0 ? YES : NO;

    for (HTBaseView *childview in self.childViews) {
        if (scrollViewExistsSubview) {
            for (HTBaseView *subview in subviews) {
                if ([subview isEqual:childview]) {
                    [subview removeFromSuperview];
                }
            }
        }
        [self.scrollView addSubview:childview];

        NSArray *data = dict[NSStringFromClass([childview class])];
        if (data.count > 0) {
            [childview.dataArray removeAllObjects];
            [childview.dataArray addObjectsFromArray:data];
        }
        [childview.tableView reloadData];
    }

}
// 切换内容
- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    CGFloat offset = CGRectGetWidth(self.scrollView.frame)*_selectIndex;
    
    [self.scrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
    
}

#pragma mark - Private Method

- (void)ht_initializeControls {
    [self addSubview:self.scrollView];    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat self_w = CGRectGetWidth(self.frame);
    CGFloat self_h = CGRectGetHeight(self.frame);
    self.scrollView.frame = CGRectMake(0.f, 0, self_w, self_h);
    CGFloat scroll_w = CGRectGetWidth(self.scrollView.frame);
    CGFloat scroll_h = CGRectGetHeight(self.scrollView.frame);
    
    [self.scrollView setContentSize:CGSizeMake(scroll_w*self.childViews.count, scroll_h)];
    NSInteger index = 0;
    for (HTBaseView *childview in self.childViews) {
        childview.frame = CGRectMake(scroll_w * index, 0, scroll_w, scroll_h);
        childview.tableHeaderSize = CGSizeMake(scroll_w, CGRectGetHeight(self.header.frame));
        index ++;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger currentValue = offset/CGRectGetWidth(scrollView.frame);
    if (self.selectIndex != currentValue) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"htContainerCurrentValue" object:@(currentValue+NormalValue)];
    }
    self.selectIndex = currentValue;
}


#pragma mark - UI

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        [_scrollView setContentOffset:CGPointZero animated:YES];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.backgroundColor  =[UIColor blueColor];
    }
    return _scrollView;
}

@end
