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


- (void)childTableViewContentSizeChanged:(CGSize)size;

- (void)scrollWillBeginDecelerating:(CGPoint)point;

- (void)scrollDidEndDragging:(CGFloat)offset willDecelerate:(BOOL)decelerate;

- (void)scrollDidScroll:(CGFloat)offset;





@end
