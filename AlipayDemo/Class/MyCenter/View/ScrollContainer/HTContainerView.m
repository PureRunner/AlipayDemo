//
//  HTContainerView.m
//  TestPlatform
//
//  Created by shuai pan on 2017/5/26.
//  Copyright © 2017年 foreveross. All rights reserved.
//

#import "HTContainerView.h"
#import "HTMyCenterTableView.h"

#define marginTop 5.f

@interface HTContainerView ()<UIScrollViewDelegate>


@property (nonatomic ,strong) UIView *header;


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


- (void)loadContainer:(NSDictionary *)content withChildProtocol:(id<HTScrollProtocol>)delegate {
    if(content.allValues.count < 1) return;
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:[HTMyCenterTableView class]]) {
            [view removeFromSuperview];
        }
    }
    [content enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        HTMyCenterTableView *table = [[HTMyCenterTableView alloc] initWithFrame:CGRectZero];
        table.identifier = key? (NSString*)key :@"" ;
        [table.dataArray addObjectsFromArray:obj? (NSArray*)obj:@[]];
        table.delegate = delegate;
        [self.scrollView addSubview:table];
        [self.childTables addObject:table];
    }];
}

- (void)reloadChildTablesData:(NSDictionary *)content {
    for (HTMyCenterTableView *table in self.childTables) {
        NSArray *data = content[table.identifier];
        [table.dataArray removeAllObjects];
        [table.dataArray addObjectsFromArray:data?data:@[]];
        [table.tableView reloadData];
    }
}

- (void)setChildOffsetZero:(BOOL)childOffsetZero {
    _childOffsetZero = childOffsetZero;
    if (!_childOffsetZero) return;
    for (HTMyCenterTableView *table in self.childTables) {
        [table.tableView setContentOffset:CGPointZero animated:NO];
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
    self.scrollView.frame = CGRectMake(0.f, marginTop, self_w, self_h - marginTop);
    CGFloat scroll_w = CGRectGetWidth(self.scrollView.frame);
    CGFloat scroll_h = CGRectGetHeight(self.scrollView.frame);
    
    [self.scrollView setContentSize:CGSizeMake(scroll_w*self.childTables.count, scroll_h)];
    NSInteger index = 0;
    for (HTMyCenterTableView *table in self.childTables) {
        table.frame = CGRectMake(scroll_w * index, 0, scroll_w, scroll_h);
        table.tableHeaderSize = CGSizeMake(scroll_w, CGRectGetHeight(self.header.frame));
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
    }
    return _scrollView;
}
- (NSMutableArray *)childTables{
    if (!_childTables) {
        _childTables  = [NSMutableArray arrayWithCapacity:2];
    }
    return _childTables;
    
}
@end
