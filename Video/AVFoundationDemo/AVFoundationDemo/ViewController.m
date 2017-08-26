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
//#import <PhotosUI/PhotosUI.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test1" withExtension:@"mp4"];
    NSDictionary *options = @{AVURLAssetPreferPreciseDurationAndTimingKey:@YES};
    AVURLAsset *anAsset = [[AVURLAsset alloc] initWithURL:url options:options];
//    AVURLAssetPreferPreciseDurationAndTimingKey
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)loadAVAsset{
    
    PHPhotoLibrary *photoLibrary = [PHPhotoLibrary sharedPhotoLibrary];
    
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    // Enumerate just the photos and videos group by using ALAssetsGroupSavedPhotos.
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        // Within the group enumeration block, filter to enumerate just videos.
        [group setAssetsFilter:[ALAssetsFilter allVideos]];
        
        // For this example, we're only interested in the first item.
        [group enumerateAssetsAtIndexes:[NSIndexSet indexSetWithIndex:0]
                                options:0
                             usingBlock:^(ALAsset *alAsset, NSUInteger index, BOOL *innerStop) {
                                 
                                 // The end of the enumeration is signaled by asset == nil.
                                 if (alAsset) {
                                     ALAssetRepresentation *representation = [alAsset defaultRepresentation];
                                     NSURL *url = [representation url];
                                     AVAsset *avAsset = [AVURLAsset URLAssetWithURL:url options:nil];
                                     // Do something interesting with the AV asset.
                                 }
                             }];
    }
                         failureBlock: ^(NSError *error) {
                             // Typically you should handle an error more gracefully than this.
                             NSLog(@"No groups");
                         }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
