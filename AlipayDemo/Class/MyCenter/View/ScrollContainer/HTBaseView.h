//
//  HTBaseView.h
//  TestPlatform
//
//  Created by shuai pan on 2017/5/26.
//  Copyright © 2017年 foreveross. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTBaseView : UIView

@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,assign) CGSize tableHeaderSize;

@property (nonatomic ,strong) NSMutableArray *dataArray;


- (void)baseConfigurateInfo ;

@end
