//
//  ContextHookModel.h
//  TextFontDemo
//
//  Created by QD on 2017/9/7.
//  Copyright © 2017年 QDDemo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContextHookModel : NSObject
@property (nonatomic, strong,readonly) id target;
@property (nonatomic, assign,readonly) SEL action;
+ (instancetype)ContextHookWithTarget:(id)target action:(SEL)action;
@end
