//
//  YTMessageController.m
//  AlipayDemo
//
//  Created by apple on 2017/4/13.
//  Copyright © 2017年 YT. All rights reserved.
//

#import "YTMessageController.h"
#import "AlipayHeader.h"
#import "YTContactsFootView.h"

CGFloat const line_h = 10.f;
CGFloat const section_h = 45.f;


@interface YTMessageController ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong) NSMutableArray *swichButtonArray;

@property (nonatomic ,strong) UIView *headerView;
@property (nonatomic ,strong) UIView *lineView;

@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) YTContactsFootView *footView;



@end

@implementation YTMessageController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    [self.view addSubview:self.tableView];
    [self.headerView addSubview:self.lineView];

    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footView;
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    CGSize size = self.tableView.contentSize;
    size.height = size.height + headerView_h - line_h;
    self.tableView.contentSize = size;

}
- (void)switchMessageList:(UIButton *)swichButton {
    __weak YTMessageController *weafSelf = self;
    for (UIButton *btn in self.swichButtonArray) {
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        if ([btn isEqual:swichButton]) {
            btn.titleLabel.font = [UIFont systemFontOfSize:20.f];
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            [weafSelf.footView selectContactsIndex:swichButton.tag-10 updateBlock:^(BOOL isFull) {
                
            }];
        }
        
    }
    

}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"22222--%@",[NSNumber numberWithInteger:indexPath.row]];

    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section_h;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat section_w = CGRectGetWidth(tableView.frame);

    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,section_w , section_h)];
    sectionView.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor clearColor]];
        btn.frame = CGRectMake((section_w/2)*i, (section_h - 30.f)/2, section_w/2, 30.f);
        NSString *title = i==0? @"消息":@"联系人";
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.f];

        btn.tag = i + 10;
        [sectionView addSubview:btn];
        [btn addTarget:self action:@selector(switchMessageList:) forControlEvents:UIControlEventTouchUpInside];
        [self.swichButtonArray addObject:btn];
    }
    [self switchMessageList:(UIButton*)self.swichButtonArray[0]];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0.f,section_h-1.f , section_w, 1.f)];
    line.backgroundColor = [UIColor lightGrayColor];
    [sectionView addSubview:line];
    return sectionView;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    CGFloat self_w = CGRectGetWidth(self.view.frame);
    CGFloat self_h = CGRectGetHeight(self.view.frame);
    self.tableView.frame = CGRectMake(0.f, navBar_h, self_w, self_h - navBar_h - tabbar_h);
    self.headerView.frame = CGRectMake(0.f, 0.f, CGRectGetWidth(self.tableView.frame), headerView_h);

    self.lineView.frame  =CGRectMake(0.f, CGRectGetMaxY(self.headerView.frame)-line_h, CGRectGetWidth(self.headerView.frame), line_h);
    CGFloat foot_h = CGRectGetHeight(self.tableView.frame) - CGRectGetHeight(self.headerView.frame) - section_h;

    self.footView.frame = CGRectMake(0.f, 0.f, self_w, foot_h);
    
}


- (YTContactsFootView *)footView{
    if (!_footView) {
        _footView  =[[YTContactsFootView alloc] initWithFrame:CGRectZero controller:self];
    }
    return _footView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;

    }
    return _tableView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectZero];
        _headerView.backgroundColor = [UIColor orangeColor];
    }
    return _headerView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _lineView;
}
- (NSMutableArray *)swichButtonArray{
    if (!_swichButtonArray) {
        _swichButtonArray = [NSMutableArray arrayWithCapacity:2 ];
    }
    return _swichButtonArray;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
