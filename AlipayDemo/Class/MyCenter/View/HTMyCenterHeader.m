//
//  HTMyCenterHeader.m
//  AlipayDemo
//
//  Created by shuai pan on 2017/5/26.
//  Copyright © 2017年 foreveross. All rights reserved.
//

#import "HTMyCenterHeader.h"

#define OPTION_H 40.f
@interface HTMyCenterHeader  ()


@property (nonatomic ,strong) UIView *optionView;

@property (nonatomic ,strong) NSMutableArray *swichArray;

@end

@implementation HTMyCenterHeader

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self ht_initializeControls];
        
    }
    return self;
}

#pragma mark - Public Method

- (void)headerWithOptions:(NSArray *)options {
    NSInteger index = 0;
    for (NSString *option in options) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:option forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(optionSelect:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.optionView addSubview:btn];
        [self.swichArray addObject:btn];
        btn.tag = index;
        index++;
    }
    self.selectIndex = 0;
    
}


- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    for (int i = 0; i<self.swichArray.count; i++) {
        UIButton *option = self.swichArray[i];
        if (i==_selectIndex) {
            [UIView animateWithDuration:0.2 animations:^{
                option.titleLabel.font = [UIFont systemFontOfSize:18.f];
                [option setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }];
        }
        else{
            [UIView animateWithDuration:0.2 animations:^{
                [option setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                option.titleLabel.font = [UIFont systemFontOfSize:14.f];
            }];
        }
    }
}

#pragma mark - Private Method

- (void)ht_initializeControls {
    self.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.optionView];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat self_w = CGRectGetWidth(self.frame);
    CGFloat self_h = CGRectGetHeight(self.frame);
    
    self.optionView.frame = CGRectMake(0.f, self_h-OPTION_H, self_w, OPTION_H);
    CGFloat btn_w = self_w/self.swichArray.count;
    CGFloat btn_h = CGRectGetHeight(self.optionView.frame);

    NSInteger index = 0;
    for (UIButton *btn in self.swichArray) {
        btn.frame = CGRectMake(index * btn_w, 5, btn_w, btn_h-5);
        index ++;
    }
    
}

- (void)optionSelect:(UIButton *)btn {
    if (self.selectIndex != btn.tag) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"htContainerCurrentValue" object:@(btn.tag+NormalValue)];
    }
    self.selectIndex = btn.tag;

}

#pragma mark - UI

- (UIView *)optionView {
    if (!_optionView) {
        _optionView = [[UIView alloc] initWithFrame:CGRectZero];
        _optionView.backgroundColor = [UIColor whiteColor];
        _optionView.layer.shadowOpacity = 0.3;
        _optionView.layer.shadowOffset = CGSizeMake(0, 2);
        _optionView.layer.shadowColor = [UIColor grayColor].CGColor;
    }
    return _optionView;
}

- (NSMutableArray *)swichArray {
    if (!_swichArray) {
        _swichArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _swichArray;
}


@end
