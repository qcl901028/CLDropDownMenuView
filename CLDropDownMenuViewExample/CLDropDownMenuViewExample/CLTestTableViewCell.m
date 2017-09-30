//
//  CLTestTableViewCell.m
//  CLDropDownMenuViewExample
//
//  Created by hezhijingwei on 2017/9/30.
//  Copyright © 2017年 秦传龙. All rights reserved.
//

#import "CLTestTableViewCell.h"

@implementation CLTestTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setFrame:(CGRect)frame {
    frame.size.height -= 1;
    
    [super setFrame:frame];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
