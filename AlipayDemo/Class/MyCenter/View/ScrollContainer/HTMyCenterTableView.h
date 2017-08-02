//
//  HTTableView.h
//  AlipayDemo
//
//  Created by shuai pan on 2017/8/2.
//  Copyright © 2017年 foreveross. All rights reserved.
//

#import "HTBaseTableView.h"

@interface HTMyCenterTableView : HTBaseTableView

@property (nonatomic ,assign) NSString *identifier;

@property (nonatomic ,strong) NSMutableArray *dataArray;

@property (nonatomic ,assign) id <HTScrollProtocol> delegate;

@end
