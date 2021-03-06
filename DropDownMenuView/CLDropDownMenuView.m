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
#import "CLDropDownBgView.h"

@interface CLDropDownMenuView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *bgMaskView;

@property (nonatomic, strong) CLDropDownBgView *bgView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *toView;

@end


@implementation CLDropDownMenuView

+ (instancetype)dropDownMenuView {

    CLDropDownMenuView *dropDownView = [[CLDropDownMenuView alloc] init];
    return dropDownView;
    
}

- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier {
    
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier];
    
}


- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    [self.tableView registerClass:cellClass forCellReuseIdentifier:identifier];
}

- (__kindof UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    
  return [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
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
    
    self.bgView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.bgMaskView.alpha = 0.15;
        self.bgView.transform = CGAffineTransformIdentity;
        
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
        self.bgView.transform = CGAffineTransformMakeScale(0.01, 0.01);

    }completion:^(BOOL finished) {
        _isShow = NO;
        
        if (finished) {
            
            if (_delegate && [_delegate respondsToSelector:@selector(dropDownMenuViewDidDismiss:)]) {
                [_delegate dropDownMenuViewDidDismiss:self];
                [self removeAllSubViews];
            }
            
        }
        
        
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
    [self removeFromSuperview];
    [self.bgView removeFromSuperview];
    self.bgView = nil;
//    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)reloadData {

    [self removeAllSubViews];
    [self setup];
    
    [self addDropDownMenuToView:self.toView];
    
}


- (CLDropDownBgView *)bgView {

    if (!_bgView) {
        _bgView = [[CLDropDownBgView alloc] init];
        _bgView.menuConfig = self.menuConfig;
    }
    return _bgView;
}


- (void)setup {
    
    [self addSubview:self.bgMaskView];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.tableView];
    
    self.tableView.bounces = self.menuConfig.bounces;
    self.tableView.layer.cornerRadius = self.menuConfig.cornerRadius;
    self.tableView.layer.masksToBounds = YES;

    
      // 设置遮罩层视图的位置
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_bgMaskView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bgMaskView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_bgMaskView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bgMaskView)]];
    
    
    // 设置下拉菜单背景图片的位置
    self.bgView.frame = CGRectMake(0, 0, self.menuConfig.viewWidth, [self viewHeight]);
    self.bgView.layer.anchorPoint = CGPointMake(1, 0);
    self.bgView.layer.position = CGPointMake(self.frame.size.width-self.menuConfig.rightMarign, self.menuConfig.topMarign);
    
    // 设置tableView的位置
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];


    NSString *tableView_V = [NSString stringWithFormat:@"V:|-%f-[_tableView]|",self.menuConfig.pointedHeight];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:tableView_V options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    
    
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
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 44;

        

        // 这个xib在bundle中加载的解决办法  在终端输入命令：ibtool --errors --warnings --output-format human-readable-text --compile 文件路径.nib 文件路径.xib
        // 转化成nib进行加载
        
        // 如果不直接使用会出现奔溃信息 Terminating app due to uncaught exception
        // 'NSInternalInconsistencyException', reason: 'Could not load NIB in bundle:
        // 'NSBundle </var/mobile/Applications/C6718DB8-0C0F-4D38-84E6-55C145279957
        // /Documents/asset-4.bundle> (not yet loaded)' with name 'file''
        
        
        
        NSBundle *CLDropDownMenuViewBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"DropDownMenuView" ofType:@"bundle"]];
        
        [_tableView registerNib:[UINib nibWithNibName:@"CLDropDownMenuAllCell" bundle:CLDropDownMenuViewBundle] forCellReuseIdentifier:@"CLDropDownMenuAllCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"CLDropDownMenuOnlyTitleCell" bundle:CLDropDownMenuViewBundle] forCellReuseIdentifier:@"CLDropDownMenuOnlyTitleCell"];
        
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    
    return _tableView;
}


- (void)tapHandleClose {
    
    [self dismissDropDownMenuView];
    
}


//- (void)setBgImage:(UIImage *)bgImage {
//    _bgImage = bgImage;
//
//    CGFloat top = 30;             // 顶端盖高度
//    CGFloat bottom = 10 ;         // 底端盖高度
//    CGFloat left = 10;             // 左端盖宽度
//    CGFloat right = 10;           // 右端盖宽度
//    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
//    // 指定为拉伸模式，伸缩后重新赋值
//    bgImage = [bgImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
//
//
//
//}



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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
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
    
    
    if (self.menuConfig.dropDownType == CLDropDownTypeCustom) {
        // 这个是自定义cell
        if (self.delegate && [self.delegate respondsToSelector:@selector(dropDownMenuView:cellForIndex:)]) {
            UITableViewCell *cell = [self.delegate dropDownMenuView:self cellForIndex:indexPath.row];
            return cell;
        }
    }
    
    if (self.menuConfig.dropDownType == CLDropDownTypeAll) {
        CLDropDownMenuAllCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CLDropDownMenuAllCell"];
        
        CLDropDownMenuInfo *info = self.itemList[indexPath.row];
        cell.menuConfig = self.menuConfig;
        cell.menuInfo = info;
        cell.backgroundColor = self.menuConfig.backgroundColor;
        return cell;
    }
    
    if (self.menuConfig.dropDownType == CLDropDownTypeOnlyTitle) {
        
        CLDropDownMenuAllCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CLDropDownMenuOnlyTitleCell"];
        
        CLDropDownMenuInfo *info = self.itemList[indexPath.row];
        cell.menuConfig = self.menuConfig;
        cell.menuInfo = info;
        cell.backgroundColor = self.menuConfig.backgroundColor;
        return cell;
        
    }
    
    return nil;
    

}


@end
