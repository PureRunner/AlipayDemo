//
//  HTTableView.m
//  AlipayDemo
//
//  Created by shuai pan on 2017/8/2.
//  Copyright © 2017年 foreveross. All rights reserved.
//

#import "HTMyCenterTableView.h"

@interface HTMyCenterTableView  ()<UITableViewDelegate ,UITableViewDataSource>
@end


@implementation HTMyCenterTableView

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
    return 80.f;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.delegate scrollViewDidScroll:scrollView];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.delegate scrollViewWillBeginDragging:scrollView];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [self.delegate scrollViewDidEndDecelerating:scrollView];
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [self.delegate scrollViewDidEndDragging:scrollView willDecelerate:YES];
    }
}


- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray  = [NSMutableArray arrayWithCapacity:2];
    }
    return _dataArray;
}
- (NSString *)identifier {
    if (!_identifier) {
        return @"";
    }
    return _identifier;
}

@end
