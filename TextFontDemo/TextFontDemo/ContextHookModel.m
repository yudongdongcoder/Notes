//
//  ContextHookModel.m
//  TextFontDemo
//
//  Created by QD on 2017/9/7.
//  Copyright © 2017年 QDDemo. All rights reserved.
//

#import "ContextHookModel.h"

@interface ContextHookModel ()
@property (nonatomic, strong) id target;
@property (nonatomic, assign) SEL action;
@end
@implementation ContextHookModel
+ (instancetype)ContextHookWithTarget:(id)target action:(SEL)action{
    ContextHookModel *model = [[ContextHookModel alloc] init];
    model.target = target;
    model.action = action;
    return model;
}
@end
