//
//  MyApplicationView.m
//  AlipayDemo
//
//  Created by shuai pan on 2017/4/16.
//  Copyright © 2017年 YT. All rights reserved.
//

#import "MyApplicationView.h"
#define BRANDTAG 100000

@interface MyApplicationView ()

@property (nonatomic ,strong) NSMutableArray *items;
@end
@implementation MyApplicationView


- (void)setIsEdited:(BOOL)isEdited {
    _isEdited = isEdited;
    for (ItemButton *item in self.items) {
        item.numBrandHidden = !_isEdited ;
    }
}
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        for (UIButton *btn in self.items) {
            [self addSubview:btn];
        }
        self.backgroundColor  =[UIColor orangeColor];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat self_w = CGRectGetWidth(self.frame);
    CGFloat self_h = CGRectGetHeight(self.frame);
    CGFloat item_l = 10.f;
    CGFloat item_w = (self_w - item_l*5)/4;
    CGFloat item_h  = (self_h - item_l*3)/2;
    for (int i = 0; i < self.items.count ; i ++) {
        UIButton *btn = self.items[i];
        if (i<4) {
            btn.frame = CGRectMake(item_l*(i+1)+item_w*i, item_l, item_w, item_h);
        }else {
            int j = i-4;
            btn.frame = CGRectMake(item_l*(j+1)+item_w*j, item_l*2+item_h, item_w, item_h);
        }
    }

}
- (void)itemClickAction:(UIButton *)btn{
    //委托调用，可选安全判断
    if (self.delegate && [self.delegate respondsToSelector:@selector(applicationView:selectItemIndex:)]) {
        [self.delegate applicationView:self selectItemIndex:btn.tag];
    }
}


- (NSMutableArray *)items {
    if (!_items) {
        _items = [NSMutableArray arrayWithCapacity:2];
        for (int i = 0; i < 8 ; i ++) {
            ItemButton *btn = [ItemButton buttonWithType:UIButtonTypeSystem];
            //[btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor lightGrayColor]];
            [btn addTarget:self action:@selector(itemClickAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i ;
            [_items addObject:btn];
        }
    }
    return _items;
}

@end


@interface ItemButton ()


@property (nonatomic ,strong) UIButton *numBrand;

@end

@implementation ItemButton

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.numBrand];
    }
    return self;
}
- (void)setNumBrandHidden:(BOOL)numBrandHidden {
    _numBrandHidden = numBrandHidden;
    self.numBrand.hidden = _numBrandHidden;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat self_w = CGRectGetWidth(self.frame);
    
    self.numBrand.frame = CGRectMake(self_w - 18.f, 0.f, 18.f, 18.f);
}
- (UIButton *)numBrand {
    if (!_numBrand) {
        _numBrand = [UIButton buttonWithType:UIButtonTypeSystem];
        [_numBrand setBackgroundImage:[UIImage imageNamed:@"edit_norml"] forState:UIControlStateNormal];
       // _numBrand.userInteractionEnabled = YES;
        _numBrand.tag = BRANDTAG ;
        _numBrand.hidden = YES;
    }
    return _numBrand;
}
@end












