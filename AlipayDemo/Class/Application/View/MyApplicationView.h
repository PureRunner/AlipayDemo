//
//  MyApplicationView.h
//  AlipayDemo
//
//  Created by shuai pan on 2017/4/16.
//  Copyright © 2017年 YT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyApplicationView;

// MyApplicationViewDelegate 声明
@protocol MyApplicationViewDelegate <NSObject>

@optional //可选
/**
 * item action事件
 */
- (void)applicationView:(MyApplicationView *)appView selectItemIndex:(NSInteger)index;

@end



@interface MyApplicationView : UIView

@property (nonatomic ,assign) id <MyApplicationViewDelegate> delegate;

@property (nonatomic ,assign) BOOL isEdited;

@end




@interface ItemButton : UIButton

@property (nonatomic ,assign) BOOL numBrandHidden;

@end
