//
//  QDCTCustomAttributedString.h
//  TextFontDemo
//
//  Created by QD on 2017/9/4.
//  Copyright © 2017年 QDDemo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContextHookModel.h"
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)


typedef NS_ENUM(NSUInteger, QDLinePosition) {
    QDLinePositionMiddle,
    QDLinePositionBottom,
    QDLinePositionCenter,
    QDLinePositionNone,
};

static NSString * const QDCustomLinePositionName =  @"QDCustomLinePositionName";//QDLinePosition
static NSString * const QDCustomLineIsForegroundName =  @"QDCustomLineIsForegroundName";//BOOL. default Yes
static NSString * const QDCustomLineValueName =  @"QDCustomLineValueName";//uicolor / uiimage. default redcolor

//float  default 1p 相对字形的比例
static NSString * const QDCustomLineHeightGlyphName =  @"QDCustomLineHeightGlyphName";
//cgfloat  default 1
static NSString * const QDCustomLineHeightName =  @"QDCustomLineHeightName";


static NSString * const QDCustomBackgroundValueSizeName =  @"QDCustomBackgroundValueSizeName";//cgsize value default

static NSString * const QDCustomObliquenessName =  @"QDCustomObliquenessName";//angle
static NSString * const QDCustomImageObliquenessName =  @"QDCustomImageObliquenessName";//angle
static NSString * const QDCustomContextHookName =  @"QDCustomContextHookName";// array [target action]
@interface QDCTCustomAttributedString : NSObject

@end
