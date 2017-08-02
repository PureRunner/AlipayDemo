
//
//  HeaderView.m
//  ScrollView
//
//  Created by apple on 2017/4/11.
//  Copyright © 2017年 YT. All rights reserved.
//

#import "YTHomeHeaderView.h"

#define HeaderItems @[@"home_scan",@"home_pay",@"home_xiu",@"home_card"]

@interface YTHomeHeaderView () {
    
}
@end


@implementation YTHomeHeaderView




- (void)setHeaderAlpha:(CGFloat)headerAlpha{
    _headerAlpha = headerAlpha;
    self.contentView.alpha = _headerAlpha;
    
}



- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.contentView];
        [self addSubview:self.lineView];

    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat self_w = CGRectGetWidth(self.frame);
    CGFloat self_h = CGRectGetHeight(self.frame);
    
    self.contentView.frame = CGRectMake(0.f, 0.f, self_w, self_h-10.f);
    self.lineView.frame = CGRectMake(0.f, CGRectGetMaxY(self.contentView.frame), self_w, 10.f);
    for ( int i = 0;i <self.bigApps.count; i++) {
        UIButton *bigbutton = self.bigApps[i];
        bigbutton.frame = CGRectMake((self_w/4)*i, 0.f, self_w/4, self_h);
    }
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor clearColor];
    }
    return _lineView;
}
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
        _contentView.backgroundColor = [UIColor clearColor];
        for (int i = 0; i<4; i++) {

            UIButton *bigbutton = [UIButton buttonWithType:UIButtonTypeCustom];
            bigbutton.tag = 1 + i;
            [bigbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [bigbutton.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [bigbutton.titleLabel setTextAlignment:NSTextAlignmentCenter];
            
            [bigbutton setImage: [UIImage imageNamed:HeaderItems[i]] forState:UIControlStateNormal];
            [bigbutton addTarget:self action:@selector(selectAppModel:) forControlEvents:UIControlEventTouchUpInside];
            [self.bigApps addObject:bigbutton];
            [_contentView addSubview:bigbutton];
        }
    }
    return _contentView;
}
- (void)selectAppModel:(UIButton *)btn{
    if (self.selectAppModels) {
        self.selectAppModels(self,btn.tag);
    }
}

- (NSMutableArray *)bigApps{
    if (!_bigApps) {
        _bigApps = [NSMutableArray arrayWithCapacity:2];
    }
    return _bigApps;
}

@end

@interface YTFirestNavBarView  ()


@property (nonatomic ,strong) UIView *leftView;
@property (nonatomic ,strong) UIImageView *imageView;
@property (nonatomic ,strong) UIButton *addBtn;
@property (nonatomic ,strong) UIButton *qrButton;


@end

@implementation YTFirestNavBarView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.leftView];
        [self addSubview:self.qrButton];
        [self.leftView addSubview:self.imageView];
        [self.leftView addSubview:self.searchBox];
        [self addSubview:self.addBtn];
    }
    return self;
}
- (void)touchShowAddMenu:(UIButton *)btn{
    if (self.showPopMenuBar) {
        self.showPopMenuBar(btn);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat self_w = CGRectGetWidth(self.frame);
    CGFloat search_y = 30.f;
    CGFloat search_h = 30.f;
    
    CGFloat qr_h = 25.f;
    CGFloat qr_y = (search_h - qr_h)/2 + search_y;
    self.qrButton.frame = CGRectMake(10.f, qr_y, qr_h, qr_h);
    self.addBtn.frame = CGRectMake(self_w - 40.f, qr_y, qr_h, qr_h);
    
    CGFloat left_w = CGRectGetMinX(self.addBtn.frame) - CGRectGetMaxX(self.qrButton.frame) - search_h;
    self.leftView.frame = CGRectMake(CGRectGetMaxX(self.qrButton.frame)+15.f, search_y, left_w, 30.f);
    
    CGFloat image_h = 20.f;
    CGFloat image_y = (CGRectGetHeight(self.leftView.frame) - image_h)/2;
    self.imageView.frame = CGRectMake(12.f, image_y, image_h, image_h);
    
    CGFloat search_w = CGRectGetWidth(self.leftView.frame) - CGRectGetMaxX(self.imageView.frame);
    self.searchBox.frame = CGRectMake(44.f, 3.f, search_w, CGRectGetHeight(self.leftView.frame) - 4.f);
    self.leftView.layer.masksToBounds = YES;
    self.leftView.layer.cornerRadius  =5.f;


}
- (UIButton *)qrButton {
    if (!_qrButton) {
        _qrButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_qrButton setBackgroundImage:[UIImage imageNamed:@"scan_mini"] forState:UIControlStateNormal];
    }
    return _qrButton;
}
- (UIView *)leftView {
    if (!_leftView) {
        _leftView = [[UIView alloc] initWithFrame:CGRectZero];
        _leftView.backgroundColor = [HXColor hx_colorWithHexRGBAString:@"#000000" alpha:0.3];
    }
    return _leftView;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 4, 20, 20)];
        _imageView.image = [UIImage imageNamed:@"search"];
    }
    return _imageView;
}
- (UITextField *)searchBox {
    if (!_searchBox) {
        _searchBox = [[UITextField alloc] initWithFrame:CGRectZero];
        //        _searchBox.delegate = self;
        _searchBox.returnKeyType = UIReturnKeySearch;
        _searchBox.borderStyle = UITextBorderStyleNone;
        _searchBox.backgroundColor = [UIColor clearColor];
        _searchBox.backgroundColor = [UIColor clearColor];
        _searchBox.textColor = [UIColor whiteColor];
        
        NSString *placeholaderString = @"搜索联系人";
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]initWithString:placeholaderString];
        [placeholder addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.f] range:NSMakeRange(0, placeholaderString.length)];
        [placeholder addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, placeholaderString.length)];
        _searchBox.attributedPlaceholder = placeholder;//流程、邮件、

    }
    return _searchBox;
}

- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"nav_add"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(touchShowAddMenu:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}



@end









@interface YTLastNavBarView ()


@property (nonatomic ,strong) UIButton *addBtn;
@end
@implementation YTLastNavBarView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.addBtn];
        for (int i = 0; i < 4; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 1 + i;
            [button addTarget:self action:@selector(selectAppModel:) forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundImage:[UIImage imageNamed:HeaderItems[i]] forState:UIControlStateNormal];
            [self.samllApps addObject:button];
            [self addSubview:button];
        }
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat self_w = CGRectGetWidth(self.frame);
    self.addBtn.frame = CGRectMake(self_w - 44, 30, 44, 28);
    for (int i = 0; i < 4; i++) {
        UIButton *samllBtn = self.samllApps[i];
        samllBtn.frame = CGRectMake(20.f + 54.f*i, 28.f, 28.f, 28.f);
    }
    
}


- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"nav_add"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(touchShowAddMenu:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
- (void)selectAppModel:(UIButton *)btn{
    if (self.selectAppModels) {
        self.selectAppModels(self,btn.tag);
    }
}
- (void)touchShowAddMenu:(UIButton *)btn{
    if (self.showPopMenuBar) {
        self.showPopMenuBar(btn);
    }
}

- (NSMutableArray *)samllApps{
    if (!_samllApps) {
        _samllApps = [NSMutableArray arrayWithCapacity:2];
    }
    return _samllApps;
}






@end
