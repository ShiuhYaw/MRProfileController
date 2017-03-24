//
//  MRProfileController.h
//  MRProfile
//
//  Created by Yaw on 23/3/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

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

@end

NS_CLASS_AVAILABLE_IOS(8_0) @interface MRProfileFollow : NSObject <NSCopying>

+ (instancetype)followWithValue:(NSString *)value title:(NSString *)title preferredStyle:(MRProfileFollowStyle)preferredStyle;

@property (nullable, nonatomic, readonly) NSString *value;
@property (nullable, nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) MRProfileFollowStyle style;
@end

NS_CLASS_AVAILABLE_IOS(8_0) @interface MRProfileTitle : NSObject <NSCopying>

+ (instancetype)profileWithTitle:(NSString *)title titleImage:(UIImage *)titleImg preferredStyle:(MRProfileTitleStyle)preferredStyle;

@property (nullable, nonatomic, readonly) UIImage *image;
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
@property (nullable, nonatomic, copy) UIImage *userProfileImage;
@property (nonatomic, readonly) MRProfileControllerStyle preferredStyle;

@end

NS_ASSUME_NONNULL_END
