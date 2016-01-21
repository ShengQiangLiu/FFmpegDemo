//
//  ViewController.m
//  FFmpegDemo
//
//  Created by admin on 16/1/13.
//  Copyright © 2016年 ShengQiangLiu. All rights reserved.
//

#import "ViewController.h"
#import "KxMovieViewController.h"
#import "IFrameExtractorViewController.h"
#import "RTSPPlayerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

/**
 *  kxmovie example
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}

- (IBAction)kxmovieBtnClick:(UIButton *)sender
{
    NSString *path = @"http://m1.26ts.com/bwsd64-AsiaMoviePass.mp4";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    // increase buffering for .wmv, it solves problem with delaying audio frames
    if ([path.pathExtension isEqualToString:@"wmv"])
        parameters[KxMovieParameterMinBufferedDuration] = @(5.0);
    
    // disable deinterlacing for iPhone, because it's complex operation can cause stuttering
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        parameters[KxMovieParameterDisableDeinterlacing] = @(YES);
    
    KxMovieViewController *vc = [KxMovieViewController movieViewControllerWithContentPath:path
                                                                               parameters:parameters];
    [self presentViewController:vc animated:YES completion:nil];
}


- (IBAction)rtspPlayerBtnClick:(UIButton *)sender
{
    [self presentViewController:[RTSPPlayerViewController new] animated:YES completion:nil];
}

- (IBAction)iFrameExtractorBtnClick:(UIButton *)sender
{
    [self presentViewController:[IFrameExtractorViewController new] animated:YES completion:nil];
}

@end
