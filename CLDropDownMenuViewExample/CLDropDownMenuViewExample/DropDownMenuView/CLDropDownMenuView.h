//
//  CLDropDownMenuView.h
//  DropDownMenuView
//
//  Created by hezhijingwei on 2017/7/20.
//  Copyright © 2017年 秦传龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLDropDownMenuValue.h"
#import "CLDropDownMenuDelegate.h"
#import "CLDropDownMenuInfo.h"
#import "CLDropDownMenuConfig.h"




@class CLDropDownMenuView;


/*
 
图层分解:
    self(CLDropDownMenuView) --> 遮罩层UIView(黑色背景：bgMaskView) --> 因为缩放位置是中心所以添加了tempView临时视图大小是子视图bgImageView的四倍 --> UIImageView(下拉菜单的背景图：bgImageView 在父视图的第二象限) --> UItableView(表格视图：tableView) -->UITableViewCell(点击的单元格)
 
项目类分析:
    CLDropDownMenuView：下拉菜单视图类
    CLDropDownMenuValue：一些枚举
    CLDropDownMenuDelegate:代理回调
    CLDropDownMenuInfo:  每个单元格的信息
 */



@interface CLDropDownMenuView : UIView


@property (nonatomic, strong) UIImage *bgImage; // 背景图片


@property (nonatomic, weak) id<CLDropDownMenuDelegate> delegate;// delegate



@property (nonatomic, strong) NSArray<CLDropDownMenuInfo *> *itemList; //设置菜单数据



@property (nonatomic, strong) CLDropDownMenuConfig *menuConfig;  // 配置用户信息


@property (nonatomic, assign, readonly) BOOL isShow;  // 是否显示


+ (instancetype)dropDownMenuView;


- (void)addDropDownMenuToView:(UIView *)view;  // 添加视图到某个视图上

- (void)dismissDropDownMenuView; //关闭下拉菜单  一般情况不用调用


- (void)reloadData; // 刷新数据


@end
