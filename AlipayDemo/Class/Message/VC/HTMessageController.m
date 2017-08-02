//
//  YTMessageController.m
//  AlipayDemo
//
//  Created by apple on 2017/4/13.
//  Copyright © 2017年 YT. All rights reserved.
//

#import "HTMessageController.h"


@interface HTMessageController () <UITableViewDelegate,UITableViewDataSource> {
    CGFloat lastOfset;
}

@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (assign, nonatomic) BOOL hiddenStatus;



@end

@implementation HTMessageController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
