//
//  CLDropDownMenuDelegate.h
//  DropDownMenuView
//
//  Created by hezhijingwei on 2017/7/20.
//  Copyright © 2017年 秦传龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CLDropDownMenuView,UITableViewCell;
@protocol CLDropDownMenuDelegate <NSObject>


@required;

/* 点击了哪一行*/
- (void)dropDownMenuView:(CLDropDownMenuView *)dropDownMenuView didSelectIndex:(NSInteger)index;


@optional;
/* 视图将要显示 */
- (void)dropDownMenuViewWillShow:(CLDropDownMenuView *)dropDownMenuView;

/* 视图将要消失 */
- (void)dropDownMenuViewWillDismiss:(CLDropDownMenuView *)dropDownMenuView;

/* 视图已经显示 */
- (void)dropDownMenuViewDidShow:(CLDropDownMenuView *)dropDownMenuView;

/* 视图已经消失 */
- (void)dropDownMenuViewDidDismiss:(CLDropDownMenuView *)dropDownMenuView;


// 1.1.2  增加自定义item 
- (UITableViewCell *)dropDownMenuView:(CLDropDownMenuView *)dropDownMenuView cellForIndex:(NSInteger)index;

@end
