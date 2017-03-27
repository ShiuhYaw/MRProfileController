//
//  MRProfileActionCollectionViewCell.m
//  MRProfile
//
//  Created by Yaw on 24/3/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import "MRProfileActionCollectionViewCell.h"
#import "UIColor+Hex.h"

@interface MRProfileActionCollectionViewCell()

@end

@implementation MRProfileActionCollectionViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.activityIndicatorView.hidden = true;
    [self.activityIndicatorView hidesWhenStopped];
    [self.activityIndicatorView stopAnimating];
    [self.actionButton setBackgroundImage:[[UIImage imageNamed:@"bt_new_m_focus"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 20.0f, 0.0, 20.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateSelected];
    [self.actionButton setBackgroundImage:[[UIImage imageNamed:@"bt_new_normal"]resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 20.0f, 0.0, 20.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal];
    [self.actionButton setBackgroundImage:[[UIImage imageNamed:@"bt_new_pressed"]resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 20.0f, 0.0, 20.0f) resizingMode:UIImageResizingModeStretch] forState:UIControlStateHighlighted];
    [self.actionButton setTitleColor:[UIColor colorWithHexString: @"#ffffff"] forState:UIControlStateNormal];
    [self.actionButton setTitle:@"" forState:UIControlStateHighlighted];
    self.actionButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
}

- (void)setTitle:(NSString *)title {
    
    [self.actionButton setTitle:title forState:UIControlStateNormal];
}

- (void)setSelectedTitle:(NSString *)selectedTitle {
    
    [self.actionButton setTitle:selectedTitle forState:UIControlStateSelected];
}

- (void)updateActionButton:(BOOL)selected {
    
    if (selected) {
        
        [self selectedActionButton];
    }
    else {
        
        [self normalActionButton];
    }
}

- (void)selectedActionButton {
    
    self.actionButton.selected = YES;
    self.actionButton.enabled = YES;
    self.actionButton.hidden = NO;
    [self.activityIndicatorView stopAnimating];
    self.activityIndicatorView.hidden = YES;
}

- (void)normalActionButton {
    
    self.actionButton.selected = NO;
    self.actionButton.enabled = YES;
    self.actionButton.hidden = NO;
    [self.activityIndicatorView stopAnimating];
    self.activityIndicatorView.hidden = YES;
}

- (IBAction)actionButtonDidTapped:(UIButton *)sender {
    
    self.activityIndicatorView.hidden = NO;
    [self.activityIndicatorView startAnimating];
    sender.enabled = NO;
    sender.hidden = YES;
    if (self.actionSelectHandler) {
        
        self.actionSelectHandler(self);
    }
}

- (void)dealloc {
    
    self.selectedTitle = nil;
    self.title = nil;
    self.actionSelectHandler = nil;
}

@end
