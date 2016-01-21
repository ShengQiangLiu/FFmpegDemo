//
//  RTSPPlayerViewController.m
//  FFmpegDemo
//
//  Created by admin on 16/1/20.
//  Copyright © 2016年 ShengQiangLiu. All rights reserved.
//

#import "RTSPPlayerViewController.h"
#import "RTSPPlayer.h"

@interface RTSPPlayerViewController ()

@property (nonatomic, strong) RTSPPlayer *video;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (nonatomic, strong) NSTimer *nextFrameTimer;

@end

@implementation RTSPPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.video = [[RTSPPlayer alloc] initWithVideo:@"rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov" usesTcp:YES];
    self.video.outputWidth = 426;
    self.video.outputHeight = 320;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [_nextFrameTimer invalidate];
    self.nextFrameTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/30
                                                           target:self
                                                         selector:@selector(displayNextFrame:)
                                                         userInfo:nil
                                                          repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated {
    [_nextFrameTimer invalidate];
    self.nextFrameTimer = nil;
}

-(void)displayNextFrame:(NSTimer *)timer
{
    if (![self.video stepFrame]) {
        [timer invalidate];
        [self.video closeAudio];
        return;
    }
    self.image.image = self.video.currentImage;
}


@end
