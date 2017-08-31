//
//  A.h
//  AVFoundationDemo
//
//  Created by QD on 2017/8/29.
//  Copyright © 2017年 QDDemo. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^testBlock)();
@interface A : NSObject
//@property (nonatomic, copy) testBlock testBlock;
@property (nonatomic, strong) NSString *name;
- (void)test:(void(^)())block;
@end
