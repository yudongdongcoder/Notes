//
//  URLSessionViewController.m
//  AFNStudyDemo
//
//  Created by QD on 2017/9/12.
//  Copyright © 2017年 yudongdong. All rights reserved.
//

#import "URLSessionViewController.h"

@interface URLSessionViewController ()

@end

@implementation URLSessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testDtatTask];
}

- (void)testDtatTask{
    NSURL *url = [NSURL URLWithString:@""];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    [task resume];
}

- (void)testUploadTask{
    NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSData *data = nil;
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                               fromData:data
                                                      completionHandler:
                                          ^(NSData *data, NSURLResponse *response, NSError *error) {
                                              // ...
                                          }];
    
    [uploadTask resume];
}
- (void)testDownloadTask{
    NSURL *URL = [NSURL URLWithString:@"http://example.com/file.zip"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request
                                                            completionHandler:
                                              ^(NSURL *location, NSURLResponse *response, NSError *error) {
                                                  NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
                                                  NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:documentsPath];
                                                  NSURL *newFileLocation = [documentsDirectoryURL URLByAppendingPathComponent:[[response URL] lastPathComponent]];
                                                  [[NSFileManager defaultManager] copyItemAtURL:location toURL:newFileLocation error:nil];
                                              }];
    
    [downloadTask resume];
}
@end
