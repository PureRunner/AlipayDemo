//
//  YTApplicationController.m
//  AlipayDemo
//
//  Created by shuai pan on 2017/4/16.
//  Copyright © 2017年 YT. All rights reserved.
//

#import "YTApplicationController.h"

@interface YTApplicationController ()


@property (nonatomic ,assign) BOOL isEditing;
@end

@implementation YTApplicationController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.isEditing = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"应用";
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(setBarItemAction:)];
    [barItem setTintColor:[UIColor blackColor]];
    self.navigationItem.rightBarButtonItem = barItem;
    
}
- (void)setBarItemAction:(UIBarButtonItem *)item{
    self.isEditing = !self.isEditing;
    item.title = self.isEditing ? @"完成":@"编辑";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
