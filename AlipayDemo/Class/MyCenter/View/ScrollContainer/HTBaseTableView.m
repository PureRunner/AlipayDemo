//
//  HTBaseView.m
//  TestPlatform
//
//  Created by shuai pan on 2017/5/26.
//  Copyright © 2017年 foreveross. All rights reserved.
//

#import "HTBaseTableView.h"

@interface HTBaseTableView  ()

@end

@implementation HTBaseTableView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self ht_initializeControls];
        [self baseConfigurateInfo];
    }
    return self;
}
- (void)baseConfigurateInfo {
    
}

#pragma mark setter Method

- (void)setTableHeaderSize:(CGSize)tableHeaderSize {
    _tableHeaderSize = tableHeaderSize;
    self.tableView.tableHeaderView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    CGRect frame =  self.tableView.tableHeaderView.frame;
    frame.size = _tableHeaderSize;
    self.tableView.tableHeaderView.frame = frame;
}


#pragma mark Private Method

- (void)ht_initializeControls {
    [self addSubview:self.tableView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
    
}




#pragma mark - UI


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 5, 0, 5);
        _tableView.tag = 1000;
    }
    return _tableView;
}



@end
