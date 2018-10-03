//
//  VideoPlayerVLCViewController.m
//  MobileVLCKiteTest
//
//  Created by Yanbing Peng on 9/02/16.
//  Copyright © 2016 Yanbing Peng. All rights reserved.
//

#import "VideoPlayerVLCViewController.h"
#import <MobileVLCKit/MobileVLCKit.h>

@interface VideoPlayerVLCViewController ()
@property(strong, nonatomic) VLCMediaPlayer *mediaPlayer;
@property(strong, nonatomic) UIView *mediaView;
@end

@implementation VideoPlayerVLCViewController

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight; // or LandscapeLeft
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

-(BOOL)shouldAutorotate{
    return NO;
}

-(id)init{
    if (self = [super init]){
        self.playOnStart = YES;
    }
    return  self;
}

- (void)viewDidLoad {
    NSLog(@"[VideoPlayerVLCViewController viewDidLoad]");
    [super viewDidLoad];
    self.view.backgroundColor =  [UIColor blackColor];
    
    
    self.mediaView = [[UIView alloc] init];
    self.mediaPlayer = [[VLCMediaPlayer alloc] initWithOptions:@[@"--network-caching=150 --clock-jitter=0 --clock-synchro=0"]];
        
    self.mediaView.translatesAutoresizingMaskIntoConstraints = NO;
    self.mediaView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.mediaView];
    
    NSLayoutConstraint *mediaViewWidthConstraint = [NSLayoutConstraint constraintWithItem:self.mediaView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    NSLayoutConstraint *mediaViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.mediaView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    NSLayoutConstraint *mediaViewCenterHorizontallyConstraint = [NSLayoutConstraint constraintWithItem:self.mediaView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
    
    [self.view addConstraint:mediaViewWidthConstraint];
    [self.view addConstraint:mediaViewHeightConstraint];
    [self.view addConstraint:mediaViewCenterHorizontallyConstraint];
    
    self.mediaPlayer.drawable = self.mediaView;    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.playOnStart) {
        if(self.mediaPlayer.media == nil){
            NSURL *mediaUrl = [[NSURL alloc] initWithString:self.urlString];
            if(mediaUrl != nil){
                [self.mediaPlayer setMedia:[[VLCMedia alloc] initWithURL:mediaUrl]];
            }
            else{
                [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Invalid URL" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                return;
            }
        }
        [self.mediaPlayer play];
    }
}


- (void)stop{
    if(self.mediaPlayer != nil){
        if(self.mediaPlayer.isPlaying){
            [self.mediaPlayer stop];
        }
    }
}

@end

