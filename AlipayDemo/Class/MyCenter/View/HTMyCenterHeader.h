//
//  HTMyCenterHeader.h
//  AlipayDemo
//
//  Created by shuai pan on 2017/5/26.
//  Copyright © 2017年 foreveross. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTMyCenterHeader : UIView




/**
  根据selectIndex切换标题卡
 */
@property (nonatomic ,assign) NSInteger selectIndex;


- (void)headerWithOptions:(NSArray *)options ;


@end
