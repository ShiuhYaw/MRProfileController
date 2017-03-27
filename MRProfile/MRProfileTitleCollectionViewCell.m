//
//  MRProfileTitleCollectionViewCell.m
//  MRProfile
//
//  Created by Yaw on 24/3/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import "MRProfileTitleCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIImage+GIF.h>
#import <SDWebImage/UIImage+MultiFormat.h>

@interface MRProfileTitleCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation MRProfileTitleCollectionViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.activityIndicatorView.hidesWhenStopped = YES;
    [self.activityIndicatorView startAnimating];
    // Initialization code
}

- (void)setImage:(id)image {
    
    [self.activityIndicatorView startAnimating];
    if (!image) {
        [self.activityIndicatorView stopAnimating];
        return;
    }
    if ([image isKindOfClass:[UIImage class]]) {
        
        self.imageView.image = image;
        [self.imageView reloadInputViews];
        [self.activityIndicatorView stopAnimating];
    }
    if ([image isKindOfClass:[NSString class]]) {
        
        UIImageView * thumbnail = [[UIImageView alloc] init];
        [thumbnail sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:nil options:SDWebImageProgressiveDownload completed:^(UIImage * image, NSError * error,SDImageCacheType cachedType, NSURL * imageURL){
            if(image){
                [thumbnail setImage:image];
                self.imageView.image = image;
                [self.imageView reloadInputViews];
                [self.activityIndicatorView stopAnimating];
            }
        }];
    }
    if ([image isKindOfClass:[NSURL class]]) {
        
        UIImageView * thumbnail = [[UIImageView alloc] init];
        [thumbnail sd_setImageWithURL:image placeholderImage:nil options:SDWebImageProgressiveDownload completed:^(UIImage * image, NSError * error,SDImageCacheType cachedType, NSURL * imageURL){
            if(image){
                [thumbnail setImage:image];
                self.imageView.image = image;
                [self.imageView reloadInputViews];
                [self.activityIndicatorView stopAnimating];
            }
        }];
    }
    if ([image isKindOfClass:[NSData class]]) {
        
        self.imageView.image   = [UIImage imageWithData:image];
        [self.activityIndicatorView stopAnimating];
    }
}

- (void)dealloc {
    
    if (self.imageView) {
        
        self.imageView = nil;
    }
}

@end
