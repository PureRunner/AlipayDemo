//
//  YTContactsFootView.m
//  eyutong
//
//  Created by apple on 2017/4/6.
//  Copyright © 2017年 Zhengzhou Yutong Bus Co.,Ltd. All rights reserved.
//

#import "YTContactsFootView.h"
#import "YTMsgListController.h"
#import "YTContacterController.h"


@interface YTContactsFootView  () {
    
}

@property (nonatomic ,strong) UIScrollView *scrollView;

@end
@implementation YTContactsFootView

- (id)initWithFrame:(CGRect)frame controller:(UIViewController*)vc{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.scrollView];
        
        [vc addChildViewController:self.messageVC];
        [self.scrollView addSubview:self.messageVC.view];
        
        [vc addChildViewController:self.contacterVC];
        [self.scrollView addSubview:self.contacterVC.view];
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat self_w = CGRectGetWidth(self.frame);
    CGFloat self_h = CGRectGetHeight(self.frame);
    self.scrollView.frame = CGRectMake(0.f, 0.f, self_w, self_h);
    self.scrollView.contentSize = CGSizeMake(self_w*2, self_h);
    self.messageVC.view.frame = CGRectMake(0.f, 0.f, self_w, self_h);
    self.contacterVC.view.frame = CGRectMake(self_w, 0.f, self_w, self_h);
    
    
}
- (void)selectContactsIndex:(NSInteger)index updateBlock:(void(^)(BOOL isFull))update{
    CGFloat self_w = CGRectGetWidth(self.frame);

    if (index == 0) {
       [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    }
    else if (index == 1){
        [self.scrollView setContentOffset:CGPointMake(self_w, 0) animated:YES];

    }
    update(YES);
    
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.backgroundColor  =[UIColor clearColor];
    }
    return _scrollView;
}
- (YTContacterController *)contacterVC{
    if (!_contacterVC) {
        _contacterVC = [[YTContacterController alloc] init];
        
    }
    return _contacterVC;
}
- (YTMsgListController *)messageVC{
    if (!_messageVC) {
        _messageVC = [[YTMsgListController alloc] init];
    }
    return _messageVC;
}

@end
