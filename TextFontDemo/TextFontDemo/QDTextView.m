//
//  QDTextView.m
//  TextFontDemo
//
//  Created by QD on 2017/8/31.
//  Copyright © 2017年 QDDemo. All rights reserved.
//

#import "QDTextView.h"

@interface QDTextView ()<NSLayoutManagerDelegate>
@property (nonatomic, strong) NSTextStorage *ktextStorage;
@property (nonatomic, strong) NSLayoutManager *klayoutManager;
//@property (nonatomic, strong) <#NSMutableArray#> *<#dataSource#>;
@end
@implementation QDTextView

-(instancetype)initWithFrame:(CGRect)frame attributesString:(NSAttributedString *)attributesString;
{
//    NSString *text = @"我还是很喜欢你\n"
//    @"像老故事里的泛黄桥段\n"
//    @"半聋半哑\n"
//    @"失了声息";
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:attributesString];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:frame.size];
    [textStorage addLayoutManager:layoutManager];
    layoutManager.delegate = self;
    [layoutManager addTextContainer:textContainer];
    self.ktextStorage = textStorage;
    self.klayoutManager = layoutManager;
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        self.editable = NO;
        self.scrollEnabled = NO;
//        [self.ktextStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:text];
        CGRect layoutRect = [self.klayoutManager usedRectForTextContainer:self.textContainer];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        //    [self.layoutManager enumerateLineFragmentsForGlyphRange:NSMakeRange(0, self.text.length) usingBlock:^(CGRect rect, CGRect usedRect, NSTextContainer * _Nonnull textContainer, NSRange glyphRange, BOOL * _Nonnull stop) {
        //        CGRect kRect = usedRect;
        //        kRect.origin.y += self.bounds.size.height/2.0-layoutRect.size.height/2.0;
        //        [array addObject:[NSValue valueWithCGRect:kRect]];
        //    }];
        //    [self addLayer:array];
        [self.klayoutManager enumerateLineFragmentsForGlyphRange:NSMakeRange(0, self.text.length) usingBlock:^(CGRect rect, CGRect usedRect, NSTextContainer * _Nonnull textContainer, NSRange glyphRange, BOOL * _Nonnull stop) {
            [array addObject:[NSValue valueWithRange:glyphRange]];
            
        }];
        NSMutableArray *rects = [NSMutableArray array];
        for (NSValue *rangeValue in array) {
            CGRect rect = [self.layoutManager boundingRectForGlyphRange:rangeValue.rangeValue inTextContainer:self.textContainer];
            rect.origin.y += self.bounds.size.height/2-layoutRect.size.height/2.0;
            [rects addObject:[NSValue valueWithCGRect:rect]];
        }
        [self addLayer:rects];
    }
    return self;
}
//-(void)setText:(NSString *)text{
////    [super setText:text];
//    
//    [self.ktextStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:text];
//    CGRect layoutRect = [self.klayoutManager usedRectForTextContainer:self.textContainer];
//    NSMutableArray *array = [[NSMutableArray alloc] init];
////    [self.layoutManager enumerateLineFragmentsForGlyphRange:NSMakeRange(0, self.text.length) usingBlock:^(CGRect rect, CGRect usedRect, NSTextContainer * _Nonnull textContainer, NSRange glyphRange, BOOL * _Nonnull stop) {
////        CGRect kRect = usedRect;
////        kRect.origin.y += self.bounds.size.height/2.0-layoutRect.size.height/2.0;
////        [array addObject:[NSValue valueWithCGRect:kRect]];
////    }];
////    [self addLayer:array];
//            [self.klayoutManager enumerateLineFragmentsForGlyphRange:NSMakeRange(0, self.text.length) usingBlock:^(CGRect rect, CGRect usedRect, NSTextContainer * _Nonnull textContainer, NSRange glyphRange, BOOL * _Nonnull stop) {
//                [array addObject:[NSValue valueWithRange:glyphRange]];
//    
//            }];
//        NSMutableArray *rects = [NSMutableArray array];
//        for (NSValue *rangeValue in array) {
//           CGRect rect = [self.layoutManager boundingRectForGlyphRange:rangeValue.rangeValue inTextContainer:self.textContainer];
//            rect.origin.y += self.bounds.size.height/2-layoutRect.size.height/2.0;
//            [rects addObject:[NSValue valueWithCGRect:rect]];
//        }
//        [self addLayer:rects];
//}
- (void)addLayer:(NSArray *)lineRects
{
    for (NSValue *rectValue in lineRects) {
        CALayer *klayer = [CALayer layer];
        CGRect rect = rectValue.CGRectValue;
//        rect.size.height = 2;
        klayer.frame = rect;
        klayer.backgroundColor = [UIColor redColor].CGColor;
        [self.layer addSublayer:klayer];
    }
}
@end
