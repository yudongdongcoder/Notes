//
//  A.m
//  AVFoundationDemo
//
//  Created by QD on 2017/8/29.
//  Copyright © 2017年 QDDemo. All rights reserved.
//

#import "A.h"

@implementation A
- (void)test:(void(^)())block{
    NSLog(@"1");
    NSLog(@"%@",block);

//    self.testBlock = block;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"2");
//        self.testBlock();
//        NSLog(@"%@",self.testBlock);
        block();
        NSLog(@"%@%@",block,self.name);
        
        NSLog(@"3");
    });
}
-(void)dealloc{
    NSLog(@"A dealloc");
}
@end
