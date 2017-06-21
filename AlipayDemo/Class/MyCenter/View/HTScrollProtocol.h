//
//  HTScrollProtocol.h
//  AlipayDemo
//
//  Created by shuai pan on 2017/5/26.
//  Copyright © 2017年 foreveross. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HTScrollProtocol <NSObject>

@optional

- (void)scrollViewDidScroll:(UIScrollView *)scrollView ;

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
@end
