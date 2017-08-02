//
//  HTSetView.m
//  AlipayDemo
//
//  Created by shuai pan on 2017/5/25.
//  Copyright © 2017年 foreveross. All rights reserved.
//

#import "HTSetView.h"


@interface HTSetView () <UITableViewDelegate ,UITableViewDataSource>


@end
@implementation HTSetView


- (void)baseConfigurateInfo {
    [super baseConfigurateInfo];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
    return 60.f;
}





//#pragma mark - data
//- (NSMutableArray *)dataArray{
//    if (!_dataArray) {
//        _dataArray  = [NSMutableArray arrayWithCapacity:2];
//        for (int i = 1; i < 12; i ++) {
//            [_dataArray addObject:@"00000"];
//        }
//    }
//    return _dataArray;
//    
//}


@end
