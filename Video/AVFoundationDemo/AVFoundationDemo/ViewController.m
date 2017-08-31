//
//  ViewController.m
//  AVFoundationDemo
//
//  Created by QD on 2017/8/26.
//  Copyright © 2017年 QDDemo. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "A.h"
#import <CoreText/CoreText.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    int b = 3;
//    A *a = [A new];
//    a.name = @"name";
//    [a test:^{
//        NSLog(@"--%d",b);
//    }];
//    a = nil;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test1" withExtension:@"mp4"];
    NSDictionary *options = @{AVURLAssetPreferPreciseDurationAndTimingKey:@YES};
    AVURLAsset *anAsset = [[AVURLAsset alloc] initWithURL:url options:options];
//    AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:anAsset];
//    Float64 durationSeconds = CMTimeGetSeconds([anAsset duration]);
//    CMTime firstThird = CMTimeMakeWithSeconds(durationSeconds/3.0, 600);
//    CMTime  secondThird = CMTimeMakeWithSeconds(durationSeconds/2.0, 600);
//    CMTime end = CMTimeMakeWithSeconds(durationSeconds, 600);
//    
//    NSArray *times = @[[NSValue valueWithCMTime:kCMTimeZero],
//                       [NSValue valueWithCMTime:firstThird],
//                       [NSValue valueWithCMTime:secondThird],
//                       [NSValue valueWithCMTime:end]];
//    [imageGenerator generateCGImagesAsynchronouslyForTimes:times completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
//        NSString *requestedTimeString = CFBridgingRelease(CMTimeCopyDescription(NULL, requestedTime));
//        NSString *actualTimeString = CFBridgingRelease(CMTimeCopyDescription(NULL, actualTime));
//
//    }];
    
//    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:anAsset];
//    if ([compatiblePresets containsObject:AVAssetExportPresetLowQuality]) {
//        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:anAsset presetName:AVAssetExportPresetLowQuality];
//        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//       path = [path stringByAppendingPathComponent:@"abc.mov"];
//        exportSession.outputURL =[[NSURL alloc] initFileURLWithPath:path];
//        exportSession.outputFileType = AVFileTypeQuickTimeMovie;
//        CMTime start = CMTimeMakeWithSeconds(1.0, 600);
//        CMTime duration = CMTimeMakeWithSeconds(3.0, 600);
//        CMTimeRange range = CMTimeRangeMake(start, duration);
//        exportSession.timeRange = range;
//        
//        [exportSession exportAsynchronouslyWithCompletionHandler:^{
//            switch ([exportSession status]) {
//                case AVAssetExportSessionStatusFailed:
//                    NSLog(@"Export failed: %@", [[exportSession error] localizedDescription]);
//                    break;
//                case AVAssetExportSessionStatusCancelled:
//                    NSLog(@"Export canceled");
//                    break;
//                default:
//                    break;
//            }
//        }];
    
//    }
    
}



@end
