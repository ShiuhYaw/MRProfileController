//
//  MRProfileActionCollectionViewCell.h
//  MRProfile
//
//  Created by Yaw on 24/3/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void  (^ActionSelectHandler)(UICollectionViewCell *cell);

@interface MRProfileActionCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *selectedTitle;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lowButtonWidth;
@property (nonatomic, copy) ActionSelectHandler actionSelectHandler;
- (void)updateActionButton:(BOOL)selected;

@end
