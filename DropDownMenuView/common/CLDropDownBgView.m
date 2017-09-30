//
//  CLDropDownBgView.m
//  CLDropDownMenuViewExample
//
//  Created by hezhijingwei on 2017/9/30.
//  Copyright © 2017年 秦传龙. All rights reserved.
//

#import "CLDropDownBgView.h"
#import "CLDropDownMenuConfig.h"


@interface CLDropDownBgView()


@property (nonatomic, strong) UIView *pointView;

@property (nonatomic, strong) UIView *bgView;


@end


@implementation CLDropDownBgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.pointView];
        [self addSubview:self.bgView];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.pointView];
        [self addSubview:self.bgView];
    }
    return self;
}



- (UIView *)pointView {
    
    if (!_pointView) {
        _pointView = [[UIView alloc] init];
        _pointView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _pointView;
}

- (UIView *)bgView {
    
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
    }
    return _bgView;
    
}

- (void)setMenuConfig:(CLDropDownMenuConfig *)menuConfig {
    _menuConfig = menuConfig;
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pointView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pointView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-self.menuConfig.cornerRadius-5]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pointView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.menuConfig.pointedHeight*2]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.pointView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:self.menuConfig.pointedHeight]];
    
    
    self.pointView.backgroundColor = self.menuConfig.backgroundColor;
    UIBezierPath *path = [UIBezierPath bezierPath];

    [path moveToPoint:CGPointMake(self.menuConfig.pointedHeight, 0)];
    [path addLineToPoint:CGPointMake(self.menuConfig.pointedHeight*2, self.menuConfig.pointedHeight)];
    [path addLineToPoint:CGPointMake(0, self.menuConfig.pointedHeight)];
    [path closePath];


    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.pointView.bounds;
    layer.path = path.CGPath;
    self.pointView.layer.mask = layer;
    
    
    
    
    self.bgView.frame = CGRectMake(0, self.menuConfig.pointedHeight, self.frame.size.width, self.frame.size.height-self.menuConfig.pointedHeight);
    self.bgView.layer.masksToBounds = YES;
    self.bgView.backgroundColor = self.menuConfig.backgroundColor;
    
    self.bgView.layer.cornerRadius = self.menuConfig.cornerRadius;

}



@end
