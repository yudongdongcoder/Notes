//
//  QDCTVIew.h
//  TextFontDemo
//
//  Created by QD on 2017/9/1.
//  Copyright © 2017年 QDDemo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDCTCustomAttributedString.h"
@interface QDCTVIew : UIView
@property (nonatomic, strong) NSAttributedString *as;

@property (nonatomic, assign) BOOL debug;

@property (nonatomic, strong) NSArray<NSValue *> *lineRects;
@property (nonatomic, strong) NSMutableArray<NSValue *> *glyphRects;
@end
