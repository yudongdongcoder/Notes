//
//  A.h
//  TextFontDemo
//
//  Created by QD on 2017/8/15.
//  Copyright © 2017年 QDDemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "B.h"
@interface A : NSObject

@property (nonatomic, strong) B *b;
+ (void)logClass;

@end
