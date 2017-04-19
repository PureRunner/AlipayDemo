//
//  YTHomeActionProtocol.h
//  eyutong
//
//  Created by apple on 2017/4/12.
//  Copyright © 2017年 Zhengzhou Yutong Bus Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YTHomeActionProtocol <NSObject>

@optional

/**
 * 下拉刷新
 */
- (void)refreshData:(BOOL)isRefresh;

- (void)clickAddPopMenuBar:(UIButton *)addButton;

/**
 * navBar点击事件
 * @param obj 点击来源
 * @param index 点击索引
 */
- (void)whereToSelectAppModels:(id)obj selectIndex:(NSInteger)index;

@end
