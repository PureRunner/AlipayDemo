//
//  YTHomeController.m
//  AlipayDemo
//
//  Created by shuai pan on 2017/4/16.
//  Copyright © 2017年 YT. All rights reserved.
//

#import "HTHomeMainController.h"
#import "ViewController.h"

@interface HTHomeMainController () <UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong) NSMutableArray *dataArray;

@end

@implementation HTHomeMainController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

}


#pragma mark - YTHomeActionProtocol

- (void)refreshData:(BOOL)isRefresh {
    static NSInteger page = 0;
    if (!self.isRefreshing && isRefresh) {
        self.isRefreshing = isRefresh;
        if (page < 5) {
            for (int i = 0; i < 2; i ++) {
                [self.dataArray addObject:@"00000"];
            }
        }
        page ++;
    }
    else {
        return;
    }
}
- (void)endRefreshing:(BOOL)endRefresh {
    if (endRefresh) {
        self.isRefreshing = NO;
        [self.tableView reloadData];
    }
}
- (void)whereToSelectAppModels:(id)obj selectIndex:(NSInteger)index {
    NSLog(@"====== %ld",index);
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ViewController *vc = [ViewController new];
    

    [self.navigationController pushViewController:vc animated:YES];
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

@end
