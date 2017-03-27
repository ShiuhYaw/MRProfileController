//
//  ViewController.m
//  MRProfile
//
//  Created by Yaw on 23/3/17.
//  Copyright © 2017 Yaw. All rights reserved.
//

#import "ViewController.h"
#import "MRProfileController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIImage+GIF.h>
#import <SDWebImage/UIImage+MultiFormat.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
 [super viewDidLoad];
 // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
 [super didReceiveMemoryWarning];
 // Dispose of any resources that can be recreated.
}

- (IBAction)touchMeDidTapped:(UIButton *)sender {
    
    MRProfileController *profileController = [MRProfileController profileWithName:@"Shiuh yaw" userID:@"1001010" image:[NSURL URLWithString:@"https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/male/86.png"] preferredStyle:MRProfileControllerStyleBottom];

    MRProfileAction *okAction = [MRProfileAction actionWithTitle:@"Follow" selectedTitle:@"Following" handler:^(MRProfileAction * _Nonnull action) {
        
        NSLog(@"action: %@", action);
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
}

- (IBAction)relese:(id)sender {
    
}

@end
