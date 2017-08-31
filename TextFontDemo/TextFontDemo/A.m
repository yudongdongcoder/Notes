//
//  A.m
//  TextFontDemo
//
//  Created by QD on 2017/8/15.
//  Copyright © 2017年 QDDemo. All rights reserved.
//

#import "A.h"

@implementation A
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    NSStringFromSelector(aSelector);
    NSLog(@"%p",aSelector);
    return self.b;
}
+ (id)forwardingTargetForSelector:(SEL)aSelector {
    
    NSLog(@"%p",aSelector);

    return [B class];
}
@end
