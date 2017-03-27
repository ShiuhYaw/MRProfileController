//
//  MRProfileController.m
//  MRProfile
//
//  Created by Yaw on 23/3/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import "MRProfileController.h"
#import "MRProfileTitleCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIImage+GIF.h>
#import <SDWebImage/UIImage+MultiFormat.h>

#pragma mark -
#pragma mark - MRProfileAction Class Implementation

typedef void (^Handler)(MRProfileAction *action);

@interface MRProfileAction()

@property (strong, nonatomic) NSString *selectedTitleString;
@property (strong, nonatomic) NSString *titleString;
@property (nonatomic, copy, nullable) Handler handler;

@end

@implementation MRProfileAction

+ (instancetype)actionWithTitle:(nullable NSString *)title selectedTitle:(nullable NSString *)selectedTitle handler:(void (^ __nullable)(MRProfileAction *action))handler {
    
    MRProfileAction *profileAction = [[MRProfileAction alloc] init];
    profileAction.titleString = title;
    profileAction.selectedTitleString = selectedTitle;
    profileAction.enabled = YES;
    profileAction.handler = handler;
    return profileAction;
}

- (BOOL)isEnabled {
    
    if (self.cell) {
        return NO;
    }
    return self.cell.actionButton.isEnabled;
}

- (BOOL)isSelected {
    
    if (self.cell) {
        return NO;
    }
    return self.cell.actionButton.selected;
}

- (void)setSelected:(BOOL)selected {
    
    if (self.cell) {
        return;
    }
    [self.cell updateActionButton:selected];
}

- (NSString *)selectedTitle {
    
    return self.selectedTitleString;
}

- (NSString *)title {
    
    return self.titleString;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    
    MRProfileAction *profileAction = [[[self class] allocWithZone:zone] init];
    profileAction.titleString = self.titleString;
    profileAction.selectedTitleString = self.selectedTitleString;
    profileAction.handler = self.handler;
    return profileAction;
}

- (void)dealloc {
    
    self.titleString = nil;
    self.selectedTitleString = nil;
}
@end

#pragma mark -
#pragma mark - MRProfileFollow Class Implementation

@interface MRProfileFollow()

@property (strong, nonatomic) NSString *valueString;
@property (strong, nonatomic) NSString *titleString;
@property (assign, nonatomic) MRProfileFollowStyle preferredStyle;

@end

@implementation MRProfileFollow

+ (instancetype)followWithValue:(NSString *)value title:(NSString *)title preferredStyle:(MRProfileFollowStyle)preferredStyle {

    MRProfileFollow *profileFollow = [[MRProfileFollow alloc]init];
    profileFollow.valueString = value;
    profileFollow.titleString = title;
    profileFollow.preferredStyle = preferredStyle;
    return profileFollow;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    
    MRProfileFollow *profileFollow = [[[self class] allocWithZone:zone] init];
    profileFollow.valueString = self.valueString;
    profileFollow.titleString = self.titleString;
    profileFollow.preferredStyle = self.preferredStyle;
    return profileFollow;
}

- (NSString *)value {
    
    return self.valueString;
}

- (NSString *)title {
    
    return self.titleString;
}

- (MRProfileFollowStyle)style {
    
    return self.preferredStyle;
}

- (void)dealloc {
    
    self.valueString = nil;
    self.titleString = nil;
}

@end

#pragma mark -
#pragma mark - MRProfileTitle Class Implementation

@interface MRProfileTitle()

@property (strong, nonatomic) id titleImage;
@property (strong, nonatomic) NSString *titleString;
@property (assign, nonatomic) MRProfileTitleStyle preferredStyle;

@end

@implementation MRProfileTitle

+ (instancetype)profileWithTitle:(NSString *)title titleImage:(id)titleImg preferredStyle:(MRProfileTitleStyle)preferredStyle {

    MRProfileTitle *profileTitle = [[MRProfileTitle alloc]init];
    profileTitle.titleImage = titleImg;
    profileTitle.titleString = title;
    profileTitle.preferredStyle = preferredStyle;
    return profileTitle;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    
    MRProfileTitle *profileTitle = [[[self class] allocWithZone:zone] init];
    profileTitle.titleImage = self.titleImage;
    profileTitle.titleString = self.titleString;
    profileTitle.preferredStyle = self.preferredStyle;
    return profileTitle;
}

- (id)image {
    
    return self.titleImage;
}

- (NSString *)title {
    
    return self.titleString;
}

- (MRProfileTitleStyle)style {
    
    return self.preferredStyle;
}

- (void)dealloc {
    
    self.titleImage = nil;
    self.titleString = nil;
}
@end

#pragma mark -
#pragma mark - MRProfileReport Class Implementation
typedef void (^ReportHandler)(void);

@interface MRProfileReport()

@property (strong, nonatomic) UIImage *reportImage;
@property (nonatomic, copy, nullable) ReportHandler reportHandler;

@end

@implementation MRProfileReport

+ (instancetype)reportWithImage:(UIImage *)image handler:(void (^)(void))handler {
    
    MRProfileReport *report = [[MRProfileReport alloc]init];
    report.reportImage = image;
    report.reportHandler = handler;
    return report;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    
    MRProfileReport *report = [[[self class] allocWithZone:zone] init];
    report.reportImage = self.reportImage;
    return report;
}

- (UIImage *)image {
    
    return self.reportImage;
}


- (void)dealloc {
    
    self.reportImage = nil;
}

@end

#pragma mark -
#pragma mark - MRProfileController Class Implementation

typedef void (^DiamondConfigurationHandler)(UILabel *diamondLabel);
typedef void (^VIPConfigurationHandler)(UIImageView *vipImage);
typedef void (^GoldCertConfigurationHandler)(UIImageView *vipImage);
typedef void (^CertConfigurationHandler)(UIImageView *vipImage);
typedef void (^DismissHandler)(BOOL isDismissedWithAction);

@interface MRProfileController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
#pragma mark - User Profile View

@property (strong, nonatomic) id userProfileImg;
@property (weak, nonatomic) IBOutlet UIView *userProfileView;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *userProfileActivityIndicatorView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userProfileTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userProfileCenterX;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userProfileWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userProfileHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userProfileImageViewLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userProfileImageViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userProfileImageViewTrailing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userProfileImageViewBottom;

#pragma mark - Profile Card View

@property (weak, nonatomic) IBOutlet UIView *profileCardView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userProfileCardCenterY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userProfileCardTrailingWhileCenterYEnable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userProfileCardLeadingWhileCenterYEnable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userProfileCardLeadingWhileCenterYDisable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userProfileCardTrailingWhileCenterYDisable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userProfileCardBottom;

#pragma mark - Report View

@property (weak, nonatomic) IBOutlet UIView *reportView;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;

#pragma mark - User Status View

@property (weak, nonatomic) IBOutlet UIView *userStatusView;
@property (weak, nonatomic) IBOutlet UIView *userDiamondStatusView;
@property (weak, nonatomic) IBOutlet UILabel *userDiamondStatusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userVIPStatusImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userGoldCertImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userCertImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userStatusTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userStatusHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userDiamondWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userVIPStatusWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userVIPStatusLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userGoldCertWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userGoldCertLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userCertWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userCertLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userNameLeading;

#pragma mark - User ID View

@property (weak, nonatomic) IBOutlet UIView *userIDView;
@property (weak, nonatomic) IBOutlet UILabel *userIDLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userIDTopUserStatus;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userIDHeight;

#pragma mark - User Title View

@property (weak, nonatomic) IBOutlet UIView *userTitleView;
@property (weak, nonatomic) IBOutlet UICollectionView *titleCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userTitleTopUserID;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userTitleHeight;

#pragma mark - User Follow View

@property (weak, nonatomic) IBOutlet UIView *userFollowView;
@property (weak, nonatomic) IBOutlet UILabel *userBroadcastLabel;
@property (weak, nonatomic) IBOutlet UILabel *broardcastLabel;

@property (weak, nonatomic) IBOutlet UILabel *userFansLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;

@property (weak, nonatomic) IBOutlet UILabel *userFollowingLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;

@property (weak, nonatomic) IBOutlet UIView *firstSeparateView;
@property (weak, nonatomic) IBOutlet UIView *secondSeparateView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userFollowTopUserTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userFollowHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userFollowTopUserID;

#pragma mark - User Action View

@property (weak, nonatomic) IBOutlet UIView *userActionView;
@property (weak, nonatomic) IBOutlet UIButton *userFollowButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userActionHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *actionCollectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *actionActivityIndicatorView;
@property (strong, nonatomic) NSMutableArray<MRProfileAction *> *mutableActions;
@property (strong, nonatomic) NSMutableArray<MRProfileTitle *> *mutableTitles;
@property (strong, nonatomic) NSMutableArray<MRProfileFollow *> *mutableFollows;
@property (strong, nonatomic) MRProfileReport *currentReport;
@property (assign, nonatomic) MRProfileControllerStyle style;
@property (assign, nonatomic) BOOL dismissed;
@property (nonatomic, copy, nullable) DiamondConfigurationHandler diamondConfigurationHandler;
@property (nonatomic, copy, nullable) VIPConfigurationHandler vipConfigurationHandler;
@property (nonatomic, copy, nullable) GoldCertConfigurationHandler goldCertConfigurationHandler;
@property (nonatomic, copy, nullable) CertConfigurationHandler certConfigurationHandler;
@property (nonatomic, copy, nullable) DismissHandler dismissHandler;

@end

@implementation MRProfileController

@synthesize name;
@synthesize userID;
@synthesize userProfileImage;
@synthesize actions;
@synthesize follows;
@synthesize titles;
@synthesize report;

+ (instancetype)profileWithName:(nullable NSString *)name userID:(nullable NSString *)userID image:(nullable id)image preferredStyle:(MRProfileControllerStyle)preferredStyle dismissHandler:(void(^ __nullable)(BOOL isDismissedWithAction))dismissHander {

    MRProfileController *profileController = [[MRProfileController alloc]initWithNibName:NSStringFromClass([MRProfileController class]) bundle:[NSBundle mainBundle]];
    profileController.dismissed = NO;
    profileController.style = preferredStyle;
    profileController.name = name;
    profileController.userID = userID;
    profileController.userProfileImg = image;
    profileController.dismissHandler = dismissHander;
    profileController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    profileController.view.backgroundColor = [UIColor clearColor];
    return profileController;
}

- (id)userProfileImage {
    
    return self.userProfileImg;
}

- (void)addAction:(MRProfileAction *)action {
    
    if (!self.mutableActions) {
        
        self.mutableActions = [NSMutableArray array];
    }
    [self.mutableActions addObject:action];
}

- (void)addTitle:(MRProfileTitle *)title {
    
    if (!self.mutableTitles) {
        
        self.mutableTitles = [NSMutableArray array];
    }
    [self.mutableTitles addObject:title];
}

- (void)addFollow:(MRProfileFollow *)follow {
    
    if (!self.mutableFollows) {
        
        self.mutableFollows = [NSMutableArray array];
    }
    [self.mutableFollows addObject:follow];
}

- (void)addReport:(MRProfileReport *)currentReport {
    
    self.currentReport = currentReport;
}

- (void)addDiamondWithConfigurationHandler:(void (^)(UILabel * _Nonnull))diamondHandler {
    
    self.diamondConfigurationHandler = diamondHandler;
}

- (void)addVIPWithConfigurationHandler:(void (^)(UIImageView * _Nonnull))vipHandler {
    
    self.vipConfigurationHandler = vipHandler;
}

- (void)addGoldCertWithConfigurationHandler:(void (^)(UIImageView * _Nonnull))goldCertHandler {
    
    self.goldCertConfigurationHandler = goldCertHandler;
}

- (void)addCertWithConfigurationHandler:(void (^)(UIImageView * _Nonnull))certHandler {
    
    self.certConfigurationHandler = certHandler;
}

- (void)configureWithStyle:(MRProfileControllerStyle)style {
    
    switch (style) {
        case MRProfileControllerStyleNone:
            self.userProfileCardCenterY.priority = UILayoutPriorityDefaultLow;
            self.userProfileCardTrailingWhileCenterYEnable.priority = UILayoutPriorityDefaultLow;
            self.userProfileCardLeadingWhileCenterYEnable.priority = UILayoutPriorityDefaultLow;
            self.userProfileCardLeadingWhileCenterYDisable.priority = UILayoutPriorityDefaultHigh;
            self.userProfileCardTrailingWhileCenterYDisable.priority = UILayoutPriorityDefaultHigh;
            self.userProfileCardBottom.priority = UILayoutPriorityDefaultHigh;
            break;
        case MRProfileControllerStyleCenter:
            self.userProfileCardCenterY.priority = UILayoutPriorityDefaultHigh;
            self.userProfileCardTrailingWhileCenterYEnable.priority = UILayoutPriorityDefaultHigh;
            self.userProfileCardLeadingWhileCenterYEnable.priority = UILayoutPriorityDefaultHigh;
            self.userProfileCardLeadingWhileCenterYDisable.priority = UILayoutPriorityDefaultLow;
            self.userProfileCardTrailingWhileCenterYDisable.priority = UILayoutPriorityDefaultLow;
            self.userProfileCardBottom.priority = UILayoutPriorityDefaultLow;
            break;
        case MRProfileControllerStyleBottom:
            self.userProfileCardCenterY.priority = UILayoutPriorityDefaultLow;
            self.userProfileCardTrailingWhileCenterYEnable.priority = UILayoutPriorityDefaultLow;
            self.userProfileCardLeadingWhileCenterYEnable.priority = UILayoutPriorityDefaultLow;
            self.userProfileCardLeadingWhileCenterYDisable.priority = UILayoutPriorityDefaultHigh;
            self.userProfileCardTrailingWhileCenterYDisable.priority = UILayoutPriorityDefaultHigh;
            self.userProfileCardBottom.priority = UILayoutPriorityDefaultHigh;
            break;
        default:
            break;
    }
}

- (BOOL)isDismissed {
    
    return self.dismissed;
}

- (MRProfileControllerStyle)preferredStyle {
    
    return self.style;
}

- (MRProfileReport *)report {
    
    return self.currentReport;
}

- (NSArray<MRProfileTitle *> *)titles {
    
    if (self.mutableTitles) {
        
        return [self.mutableTitles copy];
    }
    return nil;
}

- (NSArray<MRProfileFollow *> *)follows {
    
    if (self.mutableFollows) {
        
        return [self. mutableFollows copy];
    }
    return nil;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.userDiamondWidth.constant = 0;
    self.userVIPStatusWidth.constant = 0;
    self.userVIPStatusLeading.constant = 0;
    self.userGoldCertWidth.constant = 0;
    self.userGoldCertLeading.constant = 0;
    self.userCertWidth.constant = 0;
    self.userCertLeading.constant = 0;
    
    [self configureWithStyle:self.preferredStyle];
    self.userNameLabel.text = self.name;
    self.userIDLabel.text = [NSString stringWithFormat:@"User ID: %@", self.userID];
    self.userProfileActivityIndicatorView.hidesWhenStopped = YES;
    [self.userProfileActivityIndicatorView startAnimating];
    self.actionActivityIndicatorView.hidesWhenStopped = YES;
    [self.actionActivityIndicatorView startAnimating];

    [[self.userProfileView layer]setCornerRadius:self.userProfileView.bounds.size.height/2];
    [[self.userProfileImageView layer]setCornerRadius:self.userProfileImageView.bounds.size.height/2];
    [[self.firstSeparateView layer]setCornerRadius:self.firstSeparateView.bounds.size.height/2];
    [[self.secondSeparateView layer]setCornerRadius:self.secondSeparateView.bounds.size.height/2];
    
    [self.actionCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MRProfileActionCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([MRProfileActionCollectionViewCell class])];
    [self.titleCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MRProfileTitleCollectionViewCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:NSStringFromClass([MRProfileTitleCollectionViewCell class])];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    BOOL isDiamondAvailable = NO;
    BOOL isVIPAvailable = NO;
    BOOL isGoldCertAvailable = NO;
    BOOL isCertAvailable = NO;

    if (self.diamondConfigurationHandler && self.userDiamondStatusLabel) {
        
        self.diamondConfigurationHandler(self.userDiamondStatusLabel);
        self.userDiamondWidth.constant = 32;
        isDiamondAvailable = YES;
    }
    if (self.vipConfigurationHandler && self.userVIPStatusImageView) {
        
        self.vipConfigurationHandler(self.userVIPStatusImageView);
        self.userVIPStatusWidth.constant = 32;
        self.userVIPStatusLeading.constant = 5;
        isVIPAvailable = YES;
    }
    if (self.goldCertConfigurationHandler && self.userVIPStatusImageView) {
        
        self.goldCertConfigurationHandler(self.userGoldCertImageView);
        self.userGoldCertWidth.constant = 14;
        self.userGoldCertLeading.constant = 5;
        isGoldCertAvailable = YES;
    }
    if (self.certConfigurationHandler && self.userVIPStatusImageView) {
        
        self.certConfigurationHandler(self.userCertImageView);
        self.userCertWidth.constant = 14;
        self.userCertLeading.constant = 5;
        isCertAvailable = YES;
    }
    if (!isDiamondAvailable && !isVIPAvailable && !isGoldCertAvailable && !isCertAvailable) {
        self.userNameLeading.constant = 0;
    }
    
    self.reportView.hidden = true;
    if (self.currentReport) {
        self.reportView.hidden = false;
        [self.reportButton setImage:[UIImage imageNamed:@"ic_report"] forState:UIControlStateNormal];
        [self.reportButton setImage:[UIImage imageNamed:@"ic_report_pressed"] forState:UIControlStateHighlighted];
    }
    
    if (!self.mutableFollows || self.mutableFollows.count < 1) {
        
        self.userFollowHeight.constant = 0;
    }

    for (MRProfileFollow *follow in self.mutableFollows) {
        
        switch (follow.style) {
            case MRProfileFollowStyleFollowing:
                if (follow.value && follow.value > 0) {
                    self.userFollowingLabel.text = follow.value;
                }
                if (follow.title && follow.title.length > 0) {
                    self.followingLabel.text = follow.title;
                }
                break;
            case MRProfileFollowStyleFans:
                if (follow.value && follow.value > 0) {
                    self.userFansLabel.text = follow.value;
                }
                if (follow.title && follow.title.length > 0) {
                    self.fansLabel.text = follow.title;
                }
                break;
            case MRProfileFollowStyleBroadcast:
                if (follow.value && follow.value > 0) {
                    self.userBroadcastLabel.text = follow.value;
                }
                if (follow.title && follow.title.length > 0) {
                    self.broardcastLabel.text = follow.title;
                }
                break;
            default:
                break;
        }
    }
    
    if (!self.mutableTitles || self.mutableTitles.count < 1) {
        
        self.userTitleHeight.constant = 0;
        self.userTitleTopUserID.priority = UILayoutPriorityDefaultLow;
        self.userFollowTopUserTitle.priority = UILayoutPriorityDefaultLow;
        self.userFollowTopUserID.priority = UILayoutPriorityDefaultHigh;
    }
    else {
        
        [self.titleCollectionView reloadData];
    }
    
    if (self.mutableActions || self.mutableActions.count > 0) {
        
        [self.actionActivityIndicatorView stopAnimating];
        [self.actionCollectionView reloadData];
    }
    switch (self.preferredStyle) {
        case MRProfileControllerStyleNone:
            self.profileCardView.layer.cornerRadius = 0;
            break;
        case MRProfileControllerStyleCenter:
            self.profileCardView.layer.cornerRadius = 10;
            break;
        case MRProfileControllerStyleBottom:
            self.profileCardView.layer.cornerRadius = 0;
            break;
        default:
            break;
    }
    
    if ([self.userProfileImage isKindOfClass:[UIImage class]]) {
        [self.userProfileActivityIndicatorView stopAnimating];
        self.userProfileImageView.image = self.userProfileImage;
        [self.userProfileImageView reloadInputViews];

    }
    if ([self.userProfileImage isKindOfClass:[NSString class]]) {
        __weak typeof(self) weak = self;
        [self.userProfileImageView sd_setImageWithURL:[NSURL URLWithString:self.userProfileImage] placeholderImage:nil options:SDWebImageProgressiveDownload completed:^(UIImage * image, NSError * error,SDImageCacheType cachedType, NSURL * imageURL){
            if(image){
                [weak.userProfileActivityIndicatorView stopAnimating];
            }
        }];
    }
    if ([self.userProfileImage isKindOfClass:[NSURL class]]) {
        __weak typeof(self) weak = self;
        [self.userProfileImageView sd_setImageWithURL:self.userProfileImage placeholderImage:nil options:SDWebImageProgressiveDownload completed:^(UIImage * image, NSError * error,SDImageCacheType cachedType, NSURL * imageURL){
            if(image){
                [weak.userProfileActivityIndicatorView stopAnimating];
            }
        }];
    }
    if ([self.userProfileImage isKindOfClass:[NSData class]]) {
        [self.userProfileActivityIndicatorView stopAnimating];
        self.userProfileImageView.image   = [UIImage imageWithData:self.userProfileImage];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    [[SDImageCache sharedImageCache]clearMemory];
}

- (IBAction)reportButtonDidTapped:(UIButton *)sender {
    
    if (self.currentReport) {
        self.currentReport.reportHandler();
    }
}

- (IBAction)dismissButtonDidTapped:(UIButton *)sender {
    
    self.dismissed = YES;
    if (self.dismissHandler) {
        self.dismissHandler(NO);
    }
    [self dismissViewControllerAnimated:true completion:^{
        
        NSLog(@"dismissed");
    }];
}
#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:false];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return @(1).integerValue;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    if ([collectionView isEqual:self.titleCollectionView]) {
        if (!self.mutableTitles || self.mutableTitles.count == 0) {
            self.userTitleHeight.constant = 0;
            self.userTitleTopUserID.priority = UILayoutPriorityDefaultLow;
            self.userFollowTopUserTitle.priority = UILayoutPriorityDefaultLow;
            self.userFollowTopUserID.priority = UILayoutPriorityDefaultHigh;
            return @(0).integerValue;
        }
        return self.mutableTitles.count;
    }
    if (!self.mutableActions) {
        
        return @(0).integerValue;
    }
    NSUInteger rows = self.mutableActions.count;
    return rows;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([collectionView isEqual:self.titleCollectionView]) {
        MRProfileTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MRProfileTitleCollectionViewCell class]) forIndexPath:indexPath];
        cell.image = self.mutableTitles[indexPath.row].image;
        return cell;
    }
    
    MRProfileActionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MRProfileActionCollectionViewCell class]) forIndexPath:indexPath];
    cell.buttonWidth.priority = UILayoutPriorityDefaultHigh;
    cell.lowButtonWidth.priority = UILayoutPriorityDefaultLow;

    NSUInteger rows = self.mutableActions.count;
    if (rows == 2) {
        
        cell.buttonWidth.priority = UILayoutPriorityDefaultLow;
        cell.lowButtonWidth.priority = UILayoutPriorityDefaultHigh;
    }
    __weak typeof(self) weak = self;
    cell.actionSelectHandler = ^(UICollectionViewCell * _Nonnull cell) {
        
        MRProfileAction *alertAction = weak.mutableActions[cell.tag];
        if (alertAction.handler) {
            alertAction.handler(alertAction);
        }
    };
    MRProfileAction *action = self.mutableActions[indexPath.row];
    action.cell = cell;
    cell.tag = indexPath.row;
    cell.title = action.title;
    cell.selectedTitle = action.selectedTitle;
    cell.actionButton.enabled = action.isEnabled;
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([collectionView isEqual:self.titleCollectionView]) {
        
        NSUInteger rows = self.mutableTitles.count;
        if (rows < 2) {
            
            self.userTitleHeight.constant = 42;
        }
        if (rows == 2) {
            
            self.userTitleHeight.constant = (42) ;
        }
        if (rows > 2) {
            
            if (rows%2) {
                self.userTitleHeight.constant = ((42 * rows/2) + 42);
            }
            else {
                self.userTitleHeight.constant = (42 * rows/2) ;
            }
        }
        return CGSizeMake(66, 42);
    }
    CGRect rect = collectionView.bounds;
    CGFloat width = rect.size.width;
    NSUInteger rows = self.mutableActions.count;
    if (rows < 2) {
        
        self.userActionHeight.constant = 78;
        return CGSizeMake(width, 78);
    }
    if (rows == 2) {
        
        self.userActionHeight.constant = (78) ;
        return CGSizeMake(width / 2, 78);
    }
    if (rows > 2) {
        
        self.userActionHeight.constant = (78 * rows) ;
        return CGSizeMake(width, 78);
    }
    
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0 ;
}

- (void)dealloc {
    
    if (self.mutableActions) {
        if (self.mutableActions.count > 0) {
            [self.mutableActions removeAllObjects];
        }
        self.mutableActions = nil;
    }
    if (self.mutableTitles) {
        if (self.mutableTitles.count > 0) {
            [self.mutableTitles removeAllObjects];
        }
        self.mutableTitles = nil;
    }
    if (self.mutableFollows) {
        if (self.mutableFollows.count > 0) {
            [self.mutableFollows removeAllObjects];
        }
        self.mutableFollows = nil;
    }
    if (self.currentReport) {
        self.currentReport = nil;
    }
    if (self.userProfileImg) {
        self.userProfileImg = nil;
    }
    if (self.diamondConfigurationHandler) {
        self.diamondConfigurationHandler = nil;
    }
    if (self.vipConfigurationHandler) {
        self.vipConfigurationHandler = nil;
    }
    if (self.goldCertConfigurationHandler) {
        self.goldCertConfigurationHandler = nil;
    }
    if (self.certConfigurationHandler) {
        self.certConfigurationHandler = nil;
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache]clearMemory];
}

@end
