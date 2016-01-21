//
//  IFrameExtractorViewController.m
//  FFmpegDemo
//
//  Created by admin on 16/1/20.
//  Copyright © 2016年 ShengQiangLiu. All rights reserved.
//

#import "IFrameExtractorViewController.h"
#import "VideoFrameExtractor.h"
#import "Utilities.h"

@interface IFrameExtractorViewController ()
{
    float lastFrameTime;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic, retain) VideoFrameExtractor *video;


@end

@implementation IFrameExtractorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.video = [[VideoFrameExtractor alloc] initWithVideo:[Utilities bundlePath:@"sophie.mov"]];
    
    self.video.outputWidth = 426;
    self.video.outputHeight = 320;
    
    // print some info about the video
    NSLog(@"video duration: %f",self.video.duration);
    NSLog(@"video size: %d x %d", self.video.sourceWidth, self.video.sourceHeight);
    
    // video images are landscape, so rotate image view 90 degrees
    [self.imageView setTransform:CGAffineTransformMakeRotation(M_PI/2)];
    
}

- (IBAction)playButtonAction:(UIButton *)sender
{
    [self.playButton setEnabled:NO];
    lastFrameTime = -1;
    
    // seek to 0.0 seconds
    [self.video seekTime:0.0];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0/30
                                     target:self
                                   selector:@selector(displayNextFrame:)
                                   userInfo:nil
                                    repeats:YES];
    
    
}

#define LERP(A,B,C) ((A)*(1.0-C)+(B)*C)

-(void)displayNextFrame:(NSTimer *)timer {
    NSTimeInterval startTime = [NSDate timeIntervalSinceReferenceDate];
    if (![self.video stepFrame]) {
        [timer invalidate];
        [self.playButton setEnabled:YES];
        return;
    }
    self.imageView.image = self.video.currentImage;
    float frameTime = 1.0/([NSDate timeIntervalSinceReferenceDate]-startTime);
    if (lastFrameTime<0) {
        lastFrameTime = frameTime;
    } else {
        lastFrameTime = LERP(frameTime, lastFrameTime, 0.8);
    }
    [self.label setText:[NSString stringWithFormat:@"%.0f",lastFrameTime]];
}


- (IBAction)showTime:(UIButton *)sender
{
    NSLog(@"current time: %f s",self.video.currentTime);
}

@end
