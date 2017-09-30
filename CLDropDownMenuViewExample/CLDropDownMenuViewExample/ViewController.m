//
//  ViewController.m
//  CLDropDownMenuViewExample
//
//  Created by hezhijingwei on 2017/7/28.
//  Copyright © 2017年 秦传龙. All rights reserved.
//

#import "ViewController.h"
#import "CLDropDownMenuView.h"
#import "CLTestTableViewCell.h"



@interface ViewController ()<CLDropDownMenuDelegate>

@property (nonatomic, strong) CLDropDownMenuView *dropDownMenuView;
@property (nonatomic, strong) CLDropDownMenuConfig *menuConfig;
@property (nonatomic, strong) NSMutableArray *itemsList;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blueColor];
    /********模拟数据*********/
    self.itemsList = [NSMutableArray new];
    for (int i = 0; i < 4; i++) {
        
        CLDropDownMenuInfo *info1 = [[CLDropDownMenuInfo alloc] init];
        info1.title = @"我是不能用的";
        info1.imageName = @"CameraIcon";
        info1.disable = arc4random()%2;
        [self.itemsList addObject:info1];
        
    }
    
    
}

- (CLDropDownMenuView *)dropDownMenuView {
    
    if (!_dropDownMenuView) {
        _dropDownMenuView = [CLDropDownMenuView dropDownMenuView];
        _dropDownMenuView.delegate = self;
        _dropDownMenuView.menuConfig = self.menuConfig;
        _dropDownMenuView.itemList = self.itemsList;
//        [_dropDownMenuView registerNib:[UINib nibWithNibName:@"CLTestTableViewCell" bundle:nil] forCellReuseIdentifier:@"CLTestTableViewCell"];
        [_dropDownMenuView addDropDownMenuToView:[UIApplication sharedApplication].keyWindow];
    }
    return _dropDownMenuView;
}


- (CLDropDownMenuConfig *)menuConfig {
    
    if (!_menuConfig) {
        
        _menuConfig = [[CLDropDownMenuConfig alloc] init];
//        _menuConfig.rightMarign = 10;
//        _menuConfig.dropDownType = CLDropDownTypeAll;
//        _menuConfig.viewWidth = 150;
//        _menuConfig.itemHeight = 44;
//        _menuConfig.limitMaxCount = 5;
//        _menuConfig.pointedHeight = 15;
////        _menuConfig.cornerRadius = 15;
//        _menuConfig.backgroundColor = [UIColor redColor];
//        _menuConfig.disableItemSelected = YES;
    }
    return _menuConfig;
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    [self.dropDownMenuView reloadData];
    
}


#pragma mark --
#pragma mark --
#pragma mark --
#pragma mark --  CLDropDownMenuDelegate

- (void)dropDownMenuView:(CLDropDownMenuView *)dropDownMenuView didSelectIndex:(NSInteger)index {
    
    NSLog(@"我点击了第%ld行",index);
    
}

- (void)dropDownMenuViewDidDismiss:(CLDropDownMenuView *)dropDownMenuView {
    
    if (self.dropDownMenuView == dropDownMenuView) {
        NSLog(@"视图已经消失");
    }
    
}


/* 视图将要显示 */
- (void)dropDownMenuViewWillShow:(CLDropDownMenuView *)dropDownMenuView {
    if (self.dropDownMenuView == dropDownMenuView) {
        NSLog(@"视图将要显示");
    }
}

/* 视图将要消失 */
- (void)dropDownMenuViewWillDismiss:(CLDropDownMenuView *)dropDownMenuView {
    if (self.dropDownMenuView == dropDownMenuView) {
        NSLog(@"视图将要消失");
    }
}

/* 视图已经显示 */
- (void)dropDownMenuViewDidShow:(CLDropDownMenuView *)dropDownMenuView {
    if (self.dropDownMenuView == dropDownMenuView) {
        NSLog(@"视图已经显示");
    }
}



// 自定义cell样式
//- (UITableViewCell *)dropDownMenuView:(CLDropDownMenuView *)dropDownMenuView cellForIndex:(NSInteger)index {
//
//    CLTestTableViewCell *cell = [dropDownMenuView dequeueReusableCellWithIdentifier:@"CLTestTableViewCell"];
//
//    CLDropDownMenuInfo *info = self.itemsList[index];
//
//    cell.label.text = info.title;
//
//    return cell;
//
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
