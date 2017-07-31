//
//  CLDropDownMenuAllCell.m
//  DropDownMenuView
//
//  Created by hezhijingwei on 2017/7/21.
//  Copyright © 2017年 秦传龙. All rights reserved.
//

#import "CLDropDownMenuAllCell.h"
#import "CLDropDownMenuInfo.h"
#import "CLDropDownMenuConfig.h"

@interface CLDropDownMenuAllCell ()


@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end


@implementation CLDropDownMenuAllCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;


}



- (void)setMenuConfig:(CLDropDownMenuConfig *)menuConfig {
    _menuConfig = menuConfig;
    
    self.titleLabel.font = menuConfig.textFont;
    self.titleLabel.textColor = menuConfig.textColor;
    
    
}

- (void)setMenuInfo:(CLDropDownMenuInfo *)menuInfo {
    _menuInfo = menuInfo;
    
    self.titleLabel.text = menuInfo.title;
    self.iconImageView.image = [UIImage imageNamed:menuInfo.imageName];
    
    if (menuInfo.disable) {
        
        self.titleLabel.font = self.menuConfig.disableTextFont;
        self.titleLabel.textColor = self.menuConfig.disableTextColor;
        
    } else {
        
        self.titleLabel.font = self.menuConfig.textFont;
        self.titleLabel.textColor = self.menuConfig.textColor;
        
    }
}


- (void)setFrame:(CGRect)frame {
    
    frame.size.height -= 1;
    [super setFrame:frame];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
