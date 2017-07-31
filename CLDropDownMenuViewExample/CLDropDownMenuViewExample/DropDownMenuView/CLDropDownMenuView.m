//
//  CLDropDownMenuView.m
//  DropDownMenuView
//
//  Created by hezhijingwei on 2017/7/20.
//  Copyright © 2017年 秦传龙. All rights reserved.
//

#import "CLDropDownMenuView.h"
#import "CLDropDownMenuConfig.h"
#import "CLDropDownMenuAllCell.h"
#import "CLDropDownMenuOnlyTitleCell.h"


@interface CLDropDownMenuView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *bgMaskView;

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *tempView;


@property (nonatomic, strong) UIView *toView;

@end


@implementation CLDropDownMenuView

+ (instancetype)dropDownMenuView {

    CLDropDownMenuView *dropDownView = [[CLDropDownMenuView alloc] init];
    return dropDownView;
    
}


- (instancetype)init
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {

        UITapGestureRecognizer  *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandleClose)];
        [self.bgMaskView addGestureRecognizer:tapGesture];
        
        [self initProperty];
        [self setup];
        
    }
    return self;
}

- (void)showDropDownMenuView {
    
    if (self.isShow) {
        return;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(dropDownMenuViewWillShow:)]) {
        [_delegate dropDownMenuViewWillShow:self];
    }
    
    self.tempView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.bgMaskView.alpha = 0.15;
        self.tempView.transform = CGAffineTransformIdentity;
        
    }completion:^(BOOL finished) {
        
        _isShow = YES;
        
        if (finished) {
            
            if (_delegate && [_delegate respondsToSelector:@selector(dropDownMenuViewDidShow:)]) {
                [_delegate dropDownMenuViewDidShow:self];
            }
        }
    }];
}



- (void)addDropDownMenuToView:(UIView *)view {
    
    if (self.itemList.count == 0) {
        return;
    }
    
    [view addSubview:self];
    self.toView = view;
    [self showDropDownMenuView];
}


- (void)dismissDropDownMenuView {
    
    if (!self.isShow) {
        return;
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(dropDownMenuViewWillDismiss:)]) {
        [_delegate dropDownMenuViewWillDismiss:self];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.bgMaskView.alpha = 0.f;
        self.tempView.transform = CGAffineTransformMakeScale(0.01, 0.01);

    }completion:^(BOOL finished) {
        _isShow = NO;
        
        if (finished) {
            
            if (_delegate && [_delegate respondsToSelector:@selector(dropDownMenuViewDidDismiss:)]) {
                [_delegate dropDownMenuViewDidDismiss:self];
            }
            
        }
        
        [self removeAllSubViews];
        [self removeFromSuperview];
    }];
    
    
    
}


- (void)initProperty {
    
    CLDropDownMenuConfig *config = [CLDropDownMenuConfig new];
    self.menuConfig = config;
    
    
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"DropDownMenuView.bundle"];
    
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];

    self.bgImage = [UIImage imageNamed:@"bg_selss02" inBundle:bundle compatibleWithTraitCollection:nil];
    
    _isShow = NO;
    
}




- (void)removeAllSubViews {

    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.bgImageView removeFromSuperview];
    
}

- (void)reloadData {

    [self removeAllSubViews];
    [self setup];
    
    [self addDropDownMenuToView:self.toView];
    
}


- (UIView *)tempView {
    
    if (!_tempView) {
        _tempView = [[UIView alloc] init];
        _tempView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _tempView;
}



- (UIImageView *)bgImageView {

    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.translatesAutoresizingMaskIntoConstraints = NO;
        _bgImageView.userInteractionEnabled = YES;
        _bgImageView.layer.cornerRadius = 3;
        _bgImageView.layer.masksToBounds = YES;
        _bgImageView.contentMode = UIViewContentModeScaleToFill ;
    }
    return _bgImageView;
}


- (void)setup {
    
    [self addSubview:self.bgMaskView];
    [self addSubview:self.tempView];
    [self.tempView addSubview:self.bgImageView];
    [self.bgImageView addSubview:self.tableView];
    
    
    
      // 设置遮罩层视图的位置
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_bgMaskView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bgMaskView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_bgMaskView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bgMaskView)]];
    
    CGFloat bottom = CGRectGetHeight(self.frame)-[self viewHeight]-self.menuConfig.topMarign;
    if (bottom <=0) {
        bottom = 0;
    }
    
    CGFloat left = CGRectGetWidth(self.frame)-self.menuConfig.rightMarign-self.menuConfig.viewWidth;
    
    if (left <= 0) {
        left = 0;
    }
    
    
    NSString *tempView_V = [NSString stringWithFormat:@"V:[_tempView(%f)]-%f-|",[self viewHeight]*2,bottom];
    NSString *tempView_H = [NSString stringWithFormat:@"H:|-%f-[_tempView(%f)]",left,self.menuConfig.viewWidth*2];
    
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:tempView_V options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tempView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:tempView_H options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tempView)]];
    
    
    // 设置下拉菜单背景图片的位置
    [self setBgImageViewFrameWithwidth:self.menuConfig.viewWidth height:[self viewHeight]];
    
    
    // 设置tableView的位置
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    
    
    NSString *tableView_V = [NSString stringWithFormat:@"V:|-%f-[_tableView]|",self.menuConfig.pointedHeight];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:tableView_V options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    
}



- (void)setBgImageViewFrameWithwidth:(CGFloat)width height:(CGFloat)height {
    
    
    [self.tempView addConstraint:[NSLayoutConstraint constraintWithItem:self.bgImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.tempView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    
    
    [self.tempView addConstraint:[NSLayoutConstraint constraintWithItem:self.bgImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:height]];
    
    [self.tempView addConstraint:[NSLayoutConstraint constraintWithItem:self.bgImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.tempView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
    
    [self.tempView addConstraint:[NSLayoutConstraint constraintWithItem:self.bgImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:1 constant:width]];
    
}




- (CGFloat)viewHeight {
    
    CGFloat imageBgHeight = 0;
    
    
    if (self.itemList.count >= self.menuConfig.limitMaxCount) {
        
        imageBgHeight = self.menuConfig.limitMaxCount*self.menuConfig.itemHeight;
        
    } else {
        
        imageBgHeight = self.itemList.count*self.menuConfig.itemHeight;
        
    }
    
    return imageBgHeight+self.menuConfig.pointedHeight;
    
}



- (UIView *)bgMaskView {
    
    if (!_bgMaskView) {
        _bgMaskView = [[UIView alloc] init];
        _bgMaskView.backgroundColor = [UIColor blackColor];
        _bgMaskView.alpha = 0.2f;
        _bgMaskView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _bgMaskView;
}


- (UITableView *)tableView {
    
    if (!_tableView) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView = tableView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = self.menuConfig.bounces;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 44;
        _tableView.layer.cornerRadius = 3;
        _tableView.layer.masksToBounds = YES;
        

        NSBundle *CLDropDownMenuViewBundle = [NSBundle bundleForClass:[self class]];
        [[CLDropDownMenuViewBundle loadNibNamed:@"CLDropDownMenuAllCell" owner:self options:nil] lastObject];
        
        [_tableView registerNib:[UINib nibWithNibName:@"CLDropDownMenuAllCell" bundle:CLDropDownMenuViewBundle] forCellReuseIdentifier:@"CLDropDownMenuAllCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"CLDropDownMenuOnlyTitleCell" bundle:CLDropDownMenuViewBundle] forCellReuseIdentifier:@"CLDropDownMenuOnlyTitleCell"];
        
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    
    return _tableView;
}


- (void)tapHandleClose {
    
    [self dismissDropDownMenuView];
    
}


- (void)setBgImage:(UIImage *)bgImage {
    _bgImage = bgImage;
    
    CGFloat top = 30;             // 顶端盖高度
    CGFloat bottom = 10 ;         // 底端盖高度
    CGFloat left = 10;             // 左端盖宽度
    CGFloat right = 10;           // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 指定为拉伸模式，伸缩后重新赋值
    bgImage = [bgImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    self.bgImageView.image = bgImage;
    
    
}



#pragma mark --
#pragma mark --
#pragma mark --  tableViewDelegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.itemList.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.menuConfig.itemHeight;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     CLDropDownMenuInfo *info = self.itemList[indexPath.row];
  
    
    if (!self.menuConfig.disableItemSelected && info.disable) {
        
        [self dismissDropDownMenuView];
        return;
    }

    
    if (_delegate && [_delegate respondsToSelector:@selector(dropDownMenuView:didSelectIndex:)]) {
        [_delegate dropDownMenuView:self didSelectIndex:indexPath.row];
        [self dismissDropDownMenuView];
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.menuConfig.dropDownType == CLDropDownTypeAll) {
        CLDropDownMenuAllCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CLDropDownMenuAllCell"];
        
        CLDropDownMenuInfo *info = self.itemList[indexPath.row];
        cell.menuConfig = self.menuConfig;
        cell.menuInfo = info;
        
        return cell;
    }
    
    if (self.menuConfig.dropDownType == CLDropDownTypeOnlyTitle) {
        
        CLDropDownMenuAllCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CLDropDownMenuOnlyTitleCell"];
        
        CLDropDownMenuInfo *info = self.itemList[indexPath.row];
        cell.menuConfig = self.menuConfig;
        cell.menuInfo = info;
        
        return cell;
        
    }
    
    return nil;
    

}


@end
