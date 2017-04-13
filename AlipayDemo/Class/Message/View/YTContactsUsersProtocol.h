//
//  YTContactsUsersProtocol.h
//  eyutong
//
//  Created by apple on 2017/4/5.
//  Copyright © 2017年 Zhengzhou Yutong Bus Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YTContactsUsersProtocol <NSObject>


@optional
- (void)scrollDidEndDragging:(CGFloat)offset decelerate:(BOOL)decelerate;

- (void)scrollDidScrollOffset:(CGFloat)offset;

- (void)scrollWillBeginDragging:(CGFloat)offset;

- (void)scrollDidEndDecelerating:(CGFloat)offset;

@end
