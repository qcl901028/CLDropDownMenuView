//
//  CLDropDownMenuConfig.h
//  DropDownMenuView
//
//  Created by hezhijingwei on 2017/7/21.
//  Copyright © 2017年 秦传龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLDropDownMenuValue.h"
#import "CLDropDownMenuDelegate.h"
#import <UIKit/UIKit.h>



@interface CLDropDownMenuConfig : NSObject


@property (nonatomic, assign) CGFloat rightMarign;  // 注意这个位置是相对于 - (void)addDropDownMenuToView:(UIView *)view要添加视图的右边距 默认是 15


@property (nonatomic, assign) CGFloat topMarign;   // 同上  上边距  默认是64；


@property (nonatomic, assign) CLDropDownType dropDownType;  // 默认的是显示文字和图片


@property (nonatomic, assign) CGFloat viewWidth;  // 默认是150.00 最小宽度是60.0f


@property (nonatomic, assign) NSInteger limitMaxCount;  // 最多显示多少行  默认是5行 如果设置的值<=0 或者 >= 10 那么就是默认值


@property (nonatomic, assign) BOOL bounces;  // 默认是 NO. 能否拖动 


@property (nonatomic, assign) CGFloat itemHeight;  // 每个单元格的高度 默认是50；最小高度35（避免图片不能正常显示）；


@property (nonatomic, strong) UIFont *textFont;  // 文字大小  默认14号系统字体


@property (nonatomic, strong) UIColor *textColor; // 文字颜色 默认0.25白色字体


@property (nonatomic, strong) UIColor *backgroundColor;   // 背景颜色 默认是白色


@property (nonatomic, strong) UIFont *disableTextFont;  // 不可用的文字大小  默认14号系统字体


@property (nonatomic, strong) UIColor *disableTextColor;  //不可以文字颜色  默认0.88白色字体


@property (nonatomic, assign) CGFloat pointedHeight;     // 背景图片尖的高度  默认是9.0f  根据自己图片尺寸进行调整


@property (nonatomic, assign) BOOL disableItemSelected;  // 不可用的状态是否可以被点击  默认是不可以

@property (nonatomic, assign) CGFloat cornerRadius;   // 圆角半径  默认是5.f;


@end
