//
//  MRProfileController.h
//  MRProfile
//
//  Created by Yaw on 23/3/17.
//  Copyright © 2017 Yaw. All rights reserved.
//
//  Usage:
/*
    MRProfileController *profileController = [MRProfileController profileWithName:@"Shiuh yaw" userID:@"1001010" image:[NSURL URLWithString:@"https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/male/86.png"] preferredStyle:MRProfileControllerStyleBottom];

    MRProfileAction *okAction = [MRProfileAction actionWithTitle:@"Follow" selectedTitle:@"Following" handler:^(MRProfileAction * _Nonnull action) {
        
    }];
    [profileController addAction:okAction];

    MRProfileReport *report = [MRProfileReport reportWithImage:[UIImage imageNamed:@"ic_report"] handler:^() {
        NSLog(@"report %@", report);
    }];
    [profileController addReport:report];
    MRProfileFollow *broadcast = [MRProfileFollow followWithValue:@"123" title:@"Broadcast" preferredStyle:MRProfileFollowStyleBroadcast];
    [profileController addFollow:broadcast];

    MRProfileFollow *fans = [MRProfileFollow followWithValue:@"13" title:@"Fans" preferredStyle:MRProfileFollowStyleFans];
    [profileController addFollow:fans];

    MRProfileFollow *following = [MRProfileFollow followWithValue:@"103" title:@"Following" preferredStyle:MRProfileFollowStyleFollowing];
    [profileController addFollow:following];

    MRProfileTitle *title = [MRProfileTitle profileWithTitle:@"" titleImage: [NSURL URLWithString:@"https://cdn3.iconfinder.com/data/icons/business-3-2/256/Award-512.png"] preferredStyle:MRProfileTitleStyleBroadcaster];
    [profileController addTitle:title];

    MRProfileTitle *viewweTitle = [MRProfileTitle profileWithTitle:@"" titleImage:[NSURL URLWithString:@"https://cdn3.iconfinder.com/data/icons/business-3-2/256/Award-512.png"] preferredStyle:MRProfileTitleStyleViewer];
    [profileController addTitle:viewweTitle];

    [profileController addDiamondWithConfigurationHandler:^(UILabel * _Nonnull label) {
        label.text = @"123";
    }];

    [profileController addVIPWithConfigurationHandler:^(UIImageView * _Nonnull imageView) {
        imageView.image = [UIImage imageNamed:@"icn_vip2"];
    }];
    [profileController addGoldCertWithConfigurationHandler:^(UIImageView * _Nonnull imageView) {
        imageView.image = [UIImage imageNamed:@"cert_norm"];
    }];
    [profileController addCertWithConfigurationHandler:^(UIImageView * _Nonnull imageView) {
        imageView.image = [UIImage imageNamed:@"cert_gold"];
    }];
    [self presentViewController:profileController animated:true completion:^{
        
    }];
*/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MRProfileControllerStyle) {
    
    MRProfileControllerStyleNone = 0,
    MRProfileControllerStyleCenter,
    MRProfileControllerStyleBottom,
    
} NS_ENUM_AVAILABLE_IOS(8_0);

typedef NS_ENUM(NSInteger, MRProfileTitleStyle) {
    
    MRProfileTitleStyleNone = 0,
    MRProfileTitleStyleBroadcaster,
    MRProfileTitleStyleViewer,
} NS_ENUM_AVAILABLE_IOS(8_0);

typedef NS_ENUM(NSInteger, MRProfileFollowStyle) {
    
    MRProfileFollowStyleNone = 0,
    MRProfileFollowStyleBroadcast,
    MRProfileFollowStyleFans,
    MRProfileFollowStyleFollowing,
} NS_ENUM_AVAILABLE_IOS(8_0);

NS_CLASS_AVAILABLE_IOS(8_0) @interface MRProfileAction : NSObject <NSCopying>

+ (instancetype)actionWithTitle:(nullable NSString *)title selectedTitle:(nullable NSString *)selectedTitle handler:(void (^ __nullable)(MRProfileAction *action))handler;

@property (nullable, nonatomic, readonly) NSString *title;
@property (nullable, nonatomic, readonly) NSString *selectedTitle;
@property (nonatomic, getter=isEnabled) BOOL enabled;
@property (nonatomic, getter=isSelected) BOOL selected;

@end

NS_CLASS_AVAILABLE_IOS(8_0) @interface MRProfileFollow : NSObject <NSCopying>

+ (instancetype)followWithValue:(NSString *)value title:(NSString *)title preferredStyle:(MRProfileFollowStyle)preferredStyle;

@property (nullable, nonatomic, readonly) NSString *value;
@property (nullable, nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) MRProfileFollowStyle style;
@end

NS_CLASS_AVAILABLE_IOS(8_0) @interface MRProfileTitle : NSObject <NSCopying>

+ (instancetype)profileWithTitle:(NSString *)title titleImage:(id)titleImg preferredStyle:(MRProfileTitleStyle)preferredStyle;

@property (nullable, nonatomic, readonly) id image;
@property (nullable, nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) MRProfileTitleStyle style;
@end

NS_CLASS_AVAILABLE_IOS(8_0) @interface MRProfileReport : NSObject <NSCopying>

+ (instancetype)reportWithImage:(UIImage *)image handler:(void (^)(void))handler;

@property (nullable, nonatomic, readonly) UIImage *image;
@property (nonatomic, getter=isEnabled) BOOL enabled;

@end

NS_CLASS_AVAILABLE_IOS(8_0) @interface MRProfileController : UIViewController

+ (instancetype)profileWithName:(nullable NSString *)name userID:(nullable NSString *)userID image:(nullable id)image preferredStyle:(MRProfileControllerStyle)preferredStyle;

- (void)addAction:(MRProfileAction *)action;
@property (nonatomic, readonly) NSArray<MRProfileAction *> *actions;

- (void)addTitle:(MRProfileTitle *)title;
@property (nonatomic, readonly) NSArray<MRProfileTitle *> *titles;

- (void)addFollow:(MRProfileFollow *)follow;
@property (nonatomic, readonly) NSArray<MRProfileFollow *> *follows;

- (void)addReport:(MRProfileReport *)report;
@property (nullable, nonatomic, readonly) MRProfileReport *report;

- (void)addDiamondWithConfigurationHandler:(void (^ __nullable)(UILabel *label))diamondHandler;
- (void)addVIPWithConfigurationHandler:(void (^ __nullable)(UIImageView *imageView))vipHandler;
- (void)addGoldCertWithConfigurationHandler:(void (^ __nullable)(UIImageView *imageView))goldCertHandler;
- (void)addCertWithConfigurationHandler:(void (^ __nullable)(UIImageView *imageView))certHandler;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *userID;
@property (nullable, nonatomic, copy) id userProfileImage;
@property (nonatomic, readonly) MRProfileControllerStyle preferredStyle;
@property (nonatomic, readonly) BOOL isDismissed;

@end

NS_ASSUME_NONNULL_END
