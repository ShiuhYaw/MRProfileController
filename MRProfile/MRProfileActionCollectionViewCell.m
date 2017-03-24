//
//  MRProfileActionCollectionViewCell.m
//  MRProfile
//
//  Created by Yaw on 24/3/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import "MRProfileActionCollectionViewCell.h"
#import "UIColor+Hex.h"

@implementation MRProfileActionCollectionViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    [self.actionButton setBackgroundImage:[[UIImage imageNamed:@"bt_new_m_focus"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 20.0f, 0.0, 20.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateSelected];
    [self.actionButton setBackgroundImage:[[UIImage imageNamed:@"bt_new_normal"]resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 20.0f, 0.0, 20.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    [self.actionButton setBackgroundImage:[[UIImage imageNamed:@"bt_new_pressed"]resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 20.0f, 0.0, 20.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateHighlighted];
    [self.actionButton setTitleColor:[UIColor colorWithHexString: @"#ffffff"] forState:UIControlStateNormal];
    self.actionButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
}

- (void)setTitle:(NSString *)title {
    
    [self.actionButton setTitle:title forState:UIControlStateNormal];
}

- (void)setSelectedTitle:(NSString *)selectedTitle {
    
    [self.actionButton setTitle:selectedTitle forState:UIControlStateSelected];
}

- (IBAction)actionButtonDidTapped:(UIButton *)sender {
    
    if (self.actionSelectHandler) {
        
        sender.selected = !sender.selected;
        self.actionSelectHandler(self);
    }
}

@end
