//
//  ViewController.m
//  AlipayDemo
//
//  Created by apple on 2017/4/13.
//  Copyright © 2017年 YT. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    UIView *viw = [[UIView alloc]initWithFrame:self.view.bounds];
    viw.backgroundColor = [UIColor grayColor];
    [self.view addSubview:viw ];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
