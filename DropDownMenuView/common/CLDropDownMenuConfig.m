//
//  CLDropDownMenuConfig.m
//  DropDownMenuView
//
//  Created by hezhijingwei on 2017/7/21.
//  Copyright © 2017年 秦传龙. All rights reserved.
//

#import "CLDropDownMenuConfig.h"

@implementation CLDropDownMenuConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.rightMarign = 15;
        self.topMarign = 64;
        self.dropDownType = CLDropDownTypeAll;
        self.viewWidth = 150.0f;
        self.limitMaxCount = 5;
        self.bounces = NO;
        self.itemHeight = 50.0f;
        self.textFont = [UIFont systemFontOfSize:14];
        self.textColor = [UIColor colorWithWhite:0.25 alpha:1];
        self.disableTextFont = [UIFont systemFontOfSize:14];
        self.disableTextColor = [UIColor colorWithWhite:0.88 alpha:1];
        self.pointedHeight = 9.0f;
        self.disableItemSelected = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.cornerRadius = 5.0f;
    }
    return self;
}



// 重写set方法 限制属性值设置规范
- (void)setItemHeight:(CGFloat)itemHeight {
    
    if (itemHeight <= 35) {
        
        _itemHeight = 35;
        
    } else {
        
        _itemHeight = itemHeight;
        
    }
}


- (void)setViewWidth:(CGFloat)viewWidth {
    
    if (viewWidth <= 60) {
        _viewWidth = 60;
    } else {
        
        _viewWidth = viewWidth;
    }
    
}


- (void)setLimitMaxCount:(NSInteger)limitMaxCount {
    
    if (limitMaxCount <=0 || limitMaxCount >=10) {
        _limitMaxCount = 5;
    } else {
        _limitMaxCount = limitMaxCount;
    }
    
}


- (void)setPointedHeight:(CGFloat)pointedHeight {
    
    if (pointedHeight < 0) {
        _pointedHeight = 9.0f;
    } else {
        
        _pointedHeight = pointedHeight;
        
    }
    
}

@end
