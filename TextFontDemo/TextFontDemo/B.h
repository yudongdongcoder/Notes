//
//  B.h
//  TextFontDemo
//
//  Created by QD on 2017/8/15.
//  Copyright © 2017年 QDDemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface B : NSObject
{
@public;
    NSString *height;
}
@property (nonatomic, copy) NSString *name;
- (void)log;
+ (void)logClass;
@end
