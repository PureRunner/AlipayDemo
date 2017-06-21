//
//  YTApplicationController.m
//  AlipayDemo
//
//  Created by shuai pan on 2017/4/16.
//  Copyright © 2017年 YT. All rights reserved.
//

#import "HTApplicationController.h"
#import "MyApplicationView.h"

@interface HTApplicationController () <MyApplicationViewDelegate>


@property (nonatomic ,assign) BOOL isEditing;
@property (nonatomic ,strong) MyApplicationView *app;

@end

@implementation HTApplicationController

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
    
    _app = [[MyApplicationView alloc] initWithFrame:CGRectMake(0.f, 100.f, SCREEN_W, 200)];
    _app.delegate = self; //委托代理
    [self.view addSubview:_app];
    
    
    
    UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 80.f, 80.f)];
    circle.center = CGPointMake(SCREEN_W/2, SCREEN_H/2+200);
    circle.backgroundColor = [UIColor hx_colorWithHexRGBAString:@"#8470FF" alpha:1.0f];
    circle.layer.cornerRadius = 40.f;
    circle.layer.masksToBounds = YES;
    [self.view addSubview:circle];
    


    
}

#pragma mark - MyApplicationViewDelegate
//代理方法的实现
- (void)applicationView:(MyApplicationView *)appView selectItemIndex:(NSInteger)index {
    NSLog(@"select index: %ld",index);

}




- (void)setBarItemAction:(UIBarButtonItem *)item{
    self.isEditing = !self.isEditing;
    item.title = self.isEditing ? @"完成":@"编辑";
    self.app.isEdited  = self.isEditing;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
