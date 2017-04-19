//
//  YTHomeController.m
//  AlipayDemo
//
//  Created by shuai pan on 2017/4/16.
//  Copyright © 2017年 YT. All rights reserved.
//

#import "YTHomeController.h"

@interface YTHomeController () <UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong) NSMutableArray *dataArray;

@end

@implementation YTHomeController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    __weak typeof(self) weakSelf = self;
//    MJRefreshNormalHeader *headerRefresh = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        static NSInteger page = 0;
//        if (page < 3) {
//            for (int i = 0; i < 3; i ++) {
//                [weakSelf.dataArray addObject:@"00000"];
//            }
//        }
//        page ++;
//    }];
//    self.tableView.mj_header = headerRefresh;

}
- (void)refreshData:(BOOL)isRefresh {
    static NSInteger page = 0;
    if (!self.isRefreshing && isRefresh) {
        self.isRefreshing = isRefresh;
        if (page < 3) {
            for (int i = 0; i < 2; i ++) {
                [self.dataArray addObject:@"00000"];
            }
        }
        page ++;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.scrollView setContentOffset:CGPointZero animated:YES];
        });
    }
    else {
        return;
    }
}
- (void)endRefreshing:(BOOL)endRefresh {
    if (endRefresh) {
        self.isRefreshing = NO;
//        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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
    return 80.f;
}


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray  = [NSMutableArray arrayWithCapacity:2];
        for (int i = 1; i < 5; i ++) {
            [_dataArray addObject:@"00000"];
        }
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
