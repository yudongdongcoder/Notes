//
//  QDTextView.h
//  TextFontDemo
//
//  Created by QD on 2017/8/31.
//  Copyright © 2017年 QDDemo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QDTextView : UITextView

-(instancetype)initWithFrame:(CGRect)frame attributesString:(NSAttributedString *)attributesString;
- (void)addLayer:(NSArray *)lineRects;

@end
