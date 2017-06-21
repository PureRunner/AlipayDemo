//
//  HTContainerView.h
//  TestPlatform
//
//  Created by shuai pan on 2017/5/26.
//  Copyright © 2017年 foreveross. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HTContainerView : UIView

@property (nonatomic ,strong) UIScrollView *scrollView;


/**
   根据selectIndex切换内容
 */

@property (nonatomic ,assign) NSInteger selectIndex;



/**
 获取Container容器

 @param frame 容器frame
 @param header HeaderView
 @return 容器
 */
- (id)initWithFrame:(CGRect)frame withHeader:(UIView *)header;

/**
 设置容器量

 @param childviews 容器视图
 @param dict 容器视图及数据 格式：@"HTBaseView":@[]
 */
- (void)containerWithChildviews:(NSArray *)childviews content:(NSDictionary *)dict ;
@end
