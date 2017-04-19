//
//  YTContacterController.m
//  AlipayDemo
//
//  Created by apple on 2017/4/13.
//  Copyright © 2017年 YT. All rights reserved.
//

#import "YTContacterController.h"

@interface YTContacterController () <UITableViewDelegate,UITableViewDataSource> {
}



@property (nonatomic ,strong) NSMutableArray *dataArray;


@end

@implementation YTContacterController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [self.tableView removeObserver:self forKeyPath:@"contentSize"];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.tableView];
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *headerRefresh = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        static NSInteger page = 0;
        if (page < 20) {
            for (int i = 0; i < 1; i ++) {
                [weakSelf.dataArray addObject:@"00000"];
            }
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView reloadData];
            page ++;
            
        });
    }];
    self.tableView.mj_header = headerRefresh;
}

#pragma mark - KVC-contentSize

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{

    if ([[change objectForKey:NSKeyValueChangeKindKey] integerValue] != 1)
        return;

    if ([object isEqual:self.tableView] && [keyPath isEqualToString:@"contentSize"]) {
        CGSize newSize = [[change objectForKey:NSKeyValueChangeNewKey] CGSizeValue];
        CGSize oldSize = [[change objectForKey:NSKeyValueChangeOldKey] CGSizeValue];
        NSLog(@"-- new:%f --old: %f:",newSize.height,oldSize.height);
        
        if (CGSizeEqualToSize(oldSize, newSize)) return;
        if (self.delegate && [self.delegate respondsToSelector:@selector(childTableViewContentSizeChanged:)]) {
            [self.delegate childTableViewContentSizeChanged:newSize];
        }
    }
    
}



#pragma mark - UITableViewDelegate && UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@--%@",self.dataArray[indexPath.row],[NSNumber numberWithInteger:indexPath.row]];
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.f;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    CGPoint point = scrollView.contentOffset;
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollWillBeginDecelerating:)]) {
        [self.delegate scrollWillBeginDecelerating:point];
    }
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGFloat y = scrollView.contentOffset.y;
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollDidEndDragging:willDecelerate:)]) {
        [self.delegate scrollDidEndDragging:y willDecelerate:decelerate];
    }
   
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollDidScroll:)]) {
        [self.delegate scrollDidScroll:y];
    }
    
}




#pragma mark - UI

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];

    self.tableView.frame = self.view.bounds;

}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray  = [NSMutableArray arrayWithCapacity:2];
        for (int i = 1; i < 5; i ++) {
            [_dataArray addObject:@"00000"];
        }
    }
    return _dataArray;
                       
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.tableFooterView = [[UIView alloc] init];

//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

@end
