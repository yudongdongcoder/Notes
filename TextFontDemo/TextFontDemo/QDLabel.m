//
//  QDLabel.m
//  TextFontDemo
//
//  Created by QD on 2017/8/30.
//  Copyright © 2017年 QDDemo. All rights reserved.
//

#import "QDLabel.h"
@import CoreText;

@interface QDLabel ()<NSLayoutManagerDelegate>
@property (nonatomic, strong) NSTextStorage *textStorage;
@property (nonatomic, strong)NSLayoutManager *textLayoutManager;
@property (nonatomic, strong) NSTextContainer *textContainer;
@end
@implementation QDLabel

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        [self textKitObjectSetup];
 
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
//        [self textKitObjectSetup];
    }
    return self;
}
-(void)drawTextInRect:(CGRect)rect{
//    [super drawTextInRect:rect];
    [self textKitObjectSetup];

}
- (void)textKitObjectSetup{
    self.textStorage = [[NSTextStorage alloc] initWithString:self.text];
    self.textLayoutManager = [[NSLayoutManager alloc] init];
    self.textContainer = [[NSTextContainer alloc] init];
    
    [self.textStorage addLayoutManager:self.textLayoutManager];
    [self.textLayoutManager addTextContainer:self.textContainer];
    self.textLayoutManager.delegate = self;
    self.textContainer.size = self.bounds.size;
    self.textContainer.maximumNumberOfLines = self.numberOfLines;
    self.textContainer.lineBreakMode = self.lineBreakMode;
    [self getSeparatedLinesFromLabel:self];
}

-(void)layoutManager:(NSLayoutManager *)layoutManager didCompleteLayoutForTextContainer:(NSTextContainer *)textContainer atEnd:(BOOL)layoutFinishedFlag{
    [self calculateLineFrame];
}

- (void)calculateLineFrame{
//    [self.textLayoutManager boundingRectForGlyphRange:NSMakeRange(0, 1) inTextContainer:self.textContainer];
    [self.textLayoutManager enumerateLineFragmentsForGlyphRange:NSMakeRange(0, self.text.length) usingBlock:^(CGRect rect, CGRect usedRect, NSTextContainer * _Nonnull textContainer, NSRange glyphRange, BOOL * _Nonnull stop) {
        
    }];
}
/*
-(void)drawTextInRect:(CGRect)rect{
  
//    UIImage *image = [UIImage imageNamed:@"heart.png"];
//    image = [image resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
//    CGRect rect1 = CGRectMake(0, self.bounds.size.height - 19, self.bounds.size.width, 19);
//    [image drawInRect:rect1];
//    
//    [super drawTextInRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height - 19)];
    [super drawTextInRect:rect];
        NSArray *lineRects =  [self getSeparatedLinesFromLabel:self];
        for (NSValue *rectValue in lineRects) {
            CALayer *klayer = [CALayer layer];
            klayer.frame = rectValue.CGRectValue;
            klayer.backgroundColor = [UIColor redColor].CGColor;
            [self.layer addSublayer:klayer];
        }
}
//-(void)layoutSubviews{
//    [super layoutSubviews];

//}

//-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
//  
//
//}
//
//-(CGSize)intrinsicContentSize{
//    CGSize size = [super intrinsicContentSize];
//    return CGSizeMake(size.width, size.height + 19);
//}
*/
- (NSArray *)getSeparatedLinesFromLabel:(UILabel *)label
{
    NSString *text = [label text];
    UIFont   *font = [label font];
    CGRect    bounds = [label bounds];
//    bounds.size.height += 50;
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
//    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
//    style.alignment = self.textAlignment;
//    [attStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, attStr.length)];

    [self.textStorage setAttributedString:attStr];

    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, bounds);
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    CFArrayRef lines = CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    CFIndex count = CFArrayGetCount(lines);
    
    // 获得每一行的origin坐标
    
    CGPoint origins[count];
    CTFrameGetLineOrigins(frame, CFRangeMake(0,0), origins);
    // 翻转坐标系
//    CGAffineTransform transform =  CGAffineTransformMakeTranslation(0, self.bounds.size.height);
//    transform = CGAffineTransformScale(transform, 1.f, -1.f);
    for (int i = 0; i < count; i++) {
        CTLineRef lineRef = CFArrayGetValueAtIndex(lines,i);
        CGPoint point = origins[i];
        CGFloat lineAscent;
        CGFloat lineDescent;
        CGFloat width = CTLineGetTypographicBounds(lineRef, &lineAscent, &lineDescent, NULL);
        
        CGRect lineRect = CGRectMake(point.x, self.bounds.size.height - point.y, width, lineDescent + lineAscent);
        [linesArray addObject:[NSValue valueWithCGRect:lineRect]];
    }
    
//    for (id line in lines)
//    {
//      
////        CFRange lineRange = CTLineGetStringRange(lineRef);
////        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
////        
////        NSString *lineString = [text substringWithRange:range];
////        [linesArray addObject:lineString];
//    }
    return (NSArray *)linesArray;
}

@end
