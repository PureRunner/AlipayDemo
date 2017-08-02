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

@property (nonatomic ,strong) NSMutableArray *childTables;

@property (nonatomic ,assign) BOOL childOffsetZero;


/**
   根据selectIndex切换内容
 */

@property (nonatomic ,assign) NSInteger selectIndex;

@property (nonatomic ,strong) NSDictionary *contentDictionary;


/**
 获取Container容器

 @param frame 容器frame
 @param header HeaderView
 @return 容器
 */
- (id)initWithFrame:(CGRect)frame withHeader:(UIView *)header;


- (void)loadContainer:(NSDictionary *)content withChildProtocol:(id<HTScrollProtocol>)delegate;

- (void)reloadChildTablesData:(NSDictionary *)content ;

@end
