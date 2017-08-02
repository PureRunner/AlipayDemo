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
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = NO;



}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
