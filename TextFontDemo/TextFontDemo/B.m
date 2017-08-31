//
//  B.m
//  TextFontDemo
//
//  Created by QD on 2017/8/15.
//  Copyright © 2017年 QDDemo. All rights reserved.
//

#import "B.h"

@implementation B
- (void)log{
    NSLog(@"b");
}
+ (void)logClass{
    NSLog(@"b class");
}
-(instancetype)init{
    self = [super init];
    if (self) {
        height = @"height1";
    }
    return self;
}
@end
