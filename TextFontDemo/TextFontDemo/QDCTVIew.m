//
//  QDCTVIew.m
//  TextFontDemo
//
//  Created by QD on 2017/9/1.
//  Copyright © 2017年 QDDemo. All rights reserved.
//

#import "QDCTVIew.h"
#import <objc/runtime.h>
@import CoreText;
@interface QDCTVIew ()

@end
@implementation QDCTVIew


- (void)drawRect:(CGRect)rect {

    [super drawRect:rect];
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
     CGContextTranslateCTM(contextRef, 0, self.bounds.size.height);
     CGContextScaleCTM(contextRef, 1.0, -1.0);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);

    NSMutableAttributedString *attributed = [self.as mutableCopy];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributed);

    CTFrameRef ctFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attributed.length), path, NULL);

    
    CFArrayRef lines = CTFrameGetLines(ctFrame);
    CFIndex lineCount = CFArrayGetCount(lines);
    CGPoint lineOrigins[lineCount];
    CTFrameGetLineOrigins(ctFrame, CFRangeMake(0,0), lineOrigins);
    CFRange ranges[lineCount];

    NSMutableArray *linesArray = [NSMutableArray array];
    NSMutableArray *glyphRects = [NSMutableArray array];
    // 计算每个文字 每个line 的位置
    for (int i = 0; i < lineCount; i++) {
        CTLineRef lineRef = CFArrayGetValueAtIndex(lines,i);
         CGPoint point = lineOrigins[i];
        CGFloat lineAscent;
        CGFloat lineDescent;
        CGFloat width = CTLineGetTypographicBounds(lineRef, &lineAscent, &lineDescent, NULL);
        CGRect lineRect = CGRectMake(point.x, self.bounds.size.height - point.y - lineAscent, width, lineDescent + lineAscent);
        [linesArray addObject:[NSValue valueWithCGRect:lineRect]];
        CGContextSetTextPosition(contextRef, point.x, point.y);
        CFArrayRef runs = CTLineGetGlyphRuns(lineRef);
        CFIndex runCount = CFArrayGetCount(runs);
        for (int i = 0; i < runCount; i++){
            CTRunRef run = CFArrayGetValueAtIndex(runs, i);
            CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
            
            for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++)
            {
                CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
                CGGlyph glyph;
                CGPoint position;
                CTRunGetGlyphs(run, thisGlyphRange, &glyph);
                CTRunGetPositions(run, thisGlyphRange, &position);
                
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                if (!letter) {
                    [glyphRects addObject:[NSValue valueWithCGRect:CGRectZero]];
                    break;
                }
                UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:letter];
                CGAffineTransform t = CGAffineTransformMakeTranslation(point.x + position.x,point.y + position.y);
                [path applyTransform:t];
                CGRect r = path.bounds;
                r.origin.y = self.bounds.size.height - r.origin.y - r.size.height;
                [glyphRects addObject:[NSValue valueWithCGRect:r]];
            }
          
        }
    }
    self.lineRects = linesArray;
    self.glyphRects = glyphRects;
    [self createLayers];
    
// draw
    for (int i = 0; i < lineCount; i++) {
        CTLineRef lineRef = CFArrayGetValueAtIndex(lines,i);
        CFRange range = CTLineGetStringRange(lineRef);
        ranges[i] = range;
        CGPoint point = lineOrigins[i];
        CGContextSetTextPosition(contextRef, point.x, point.y);
        CFArrayRef runs = CTLineGetGlyphRuns(lineRef);
        CFIndex runCount = CFArrayGetCount(runs);

        for (int i = 0; i < runCount; i++){
            CTRunRef run = CFArrayGetValueAtIndex(runs, i);
            CFDictionaryRef runAttributesRef = CTRunGetAttributes(run);
            NSDictionary *runAttributes = (__bridge NSDictionary *)(runAttributesRef);
            
            BOOL isDraw = NO;
            if (![self getQDCustomLineIsForegroundNameValue:runAttributes]) {
                [self layoutCustomLineWithContextRef:contextRef point:point run:run isDraw:&isDraw];
            }
            
            if ([self shouldRunDraw:runAttributes]) {
                CTRunDraw(run, contextRef, CFRangeMake(0, 0));
            }
            if ([self getQDCustomLineIsForegroundNameValue:runAttributes]) {
                [self layoutCustomLineWithContextRef:contextRef point:point run:run isDraw:&isDraw];
            }
            
        }
        
        
      
}


    CFRelease(path);
    CFRelease(framesetter);
    CFRelease(ctFrame);

}

- (BOOL)shouldRunDraw:(NSDictionary *)runAttributes{
    if (nil != runAttributes[QDCustomObliquenessName]) {
        return NO;
    }
    if (nil != runAttributes[QDCustomContextHookName]) {
        return NO;
    }
    return YES;
}
- (void)invokeHookWithContextRef:(CGContextRef)contextRef point:(CGPoint)point run:(CTRunRef)run isDraw:(BOOL *)isDraw{

    NSInvocation *invocation = [self getInvokeHookWithContextRef:contextRef point:point run:run];
    if (invocation) {
        CGContextSaveGState(contextRef);
        
        [invocation invoke];
        CTRunDraw(run, contextRef, CFRangeMake(0, 0));
        
        CGContextRestoreGState(contextRef);
    }


}

- (NSInvocation *)getInvokeHookWithContextRef:(CGContextRef)contextRef point:(CGPoint)point run:(CTRunRef)run{
    CFDictionaryRef runAttributesRef = CTRunGetAttributes(run);
    NSDictionary *runAttributes = (__bridge NSDictionary *)(runAttributesRef);
    if(nil != runAttributes[QDCustomContextHookName]){
        ContextHookModel *model = runAttributes[QDCustomContextHookName];
        id target = model.target;
        SEL action = model.action;
        Method m = class_getInstanceMethod([target class], action);
        unsigned int argumentsCount = method_getNumberOfArguments(m);
        
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:action]];
        invocation.target = target;
        invocation.selector= action;
        for (unsigned int i = 2; i < argumentsCount; i++) {
            
            switch (i) {
                case 2:
                {
                    [invocation setArgument:&contextRef atIndex:i];
                    
                }
                    break;
                case 3:
                {
                    [invocation setArgument:&run atIndex:i];
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
        return invocation;
    }else{
        return nil;
    }
    
    
}
- (void)layoutCustomLineWithContextRef:(CGContextRef)contextRef point:(CGPoint)point run:(CTRunRef)run isDraw:(BOOL *)isDraw{
    
        CFDictionaryRef runAttributesRef = CTRunGetAttributes(run);
        NSDictionary *runAttributes = (__bridge NSDictionary *)(runAttributesRef);
        CFRange runRange = CTRunGetStringRange(run);


        if (nil != runAttributes[QDCustomLinePositionName]) {
            
            id lineValue = [self getQDCustomLineValueNameValue:runAttributes];
           
            CGPoint *points = (CGPoint *)CTRunGetPositionsPtr(run);
            CGPoint firstPosition = points[0];
            
            CGFloat ascent = 0.0f;
            CGFloat descent = 0.0f;
            CGFloat leading = 0.0f;
            float RunWidth=CTRunGetTypographicBounds((CTRunRef)run, CFRangeMake(0, 0), &ascent, &descent, &leading);
            CGFloat lineWidth = [self getQDCustomLineHeightNameValue:runAttributes withGlyph:ascent+descent];
            QDLinePosition position = [runAttributes[QDCustomLinePositionName] integerValue];
            
            if ([lineValue isKindOfClass:[UIColor class]]) {
                
                UIColor *lineColor = lineValue;
                CGContextSetLineWidth(contextRef, lineWidth);
                
                CGContextSetLineCap(contextRef,
                                    kCGLineCapButt);
                CGContextSetLineWidth(contextRef,
                                      lineWidth);
                CGContextSetStrokeColorWithColor(contextRef, lineColor.CGColor);
                CGContextBeginPath(contextRef);
                
                CGFloat y = 0;
                if (position == QDLinePositionMiddle) {
                    y = point.y - descent + (ascent+descent)/2.0;
                }else{
                    y = point.y - descent - lineWidth/2;
                }
                
                CGContextMoveToPoint(contextRef,
                                     point.x + firstPosition.x,y);
                
                CGContextAddLineToPoint(contextRef,
                                        point.x + firstPosition.x+RunWidth, y);
                CGContextStrokePath(contextRef);
                
            }else if ([lineValue isKindOfClass:[UIImage class]]){
                CGContextSaveGState(contextRef);
                CGContextTranslateCTM(contextRef, 0, self.bounds.size.height);
                CGContextScaleCTM(contextRef, 1.0, -1.0);
                UIImage *lineImage = (UIImage *)lineValue;
                CGFloat imageH = lineImage.size.height;
                
                CGFloat y = 0;
                if (position == QDLinePositionMiddle) {
                    
                    y = self.bounds.size.height - point.y + descent - (ascent+descent)/2.0 - imageH/2.0;
                    CGRect rect1 = CGRectMake(point.x + firstPosition.x,y, RunWidth, imageH);
                    [lineImage drawInRect:rect1];
                }else if(position == QDLinePositionBottom){
                    y = self.bounds.size.height - point.y + descent;
                    CGRect rect1 = CGRectMake(point.x + firstPosition.x,y, RunWidth, imageH);
                    [lineImage drawInRect:rect1];

                }else if (position == QDLinePositionCenter){

                    long begain = runRange.location;
                    long end = runRange.location + runRange.length;
                    CGSize imageSize = [self getQDCustomBackgroundValueSizeNameValue:runAttributes];
                    NSNumber *imageObliquenessValue = runAttributes[QDCustomImageObliquenessName];
                 
                    for (long i = begain; i<end; i++) {

                        CGRect glyphRect = [self.glyphRects[i] CGRectValue];
                        CGRect imageRect =
                        CGRectMake(
                                   glyphRect.origin.x + glyphRect.size.width/2.0 - imageSize.width/2.0,
                                   glyphRect.origin.y + glyphRect.size.height/2.0 - imageSize.height/2.0,
                                   imageSize.width,
                                   imageSize.height);
                        
                        if (imageObliquenessValue) {
                            CGContextSaveGState(contextRef);
                            
                            CGFloat imageObliqueness = imageObliquenessValue.doubleValue;
                            CGFloat sx = imageRect.origin.x + imageRect.size.width/2;
                            CGFloat sy = imageRect.origin.y + imageRect.size.height/2;
                            CGContextTranslateCTM(contextRef, sx, sy);
                            CGContextRotateCTM(contextRef, DEGREES_TO_RADIANS(imageObliqueness));
                            CGContextTranslateCTM(contextRef, -sx, -sy);
                            [lineImage drawInRect:imageRect];

                            CGContextRestoreGState(contextRef);
                        }else{
                            [lineImage drawInRect:imageRect];
 
                        }
                        
                       

                    }
                  
             
                }
                CGContextRestoreGState(contextRef);

            }
            
            
            
        }
    if (nil != runAttributes[QDCustomObliquenessName]) {
        CGFloat angle = [self getQDCustomObliquenessNameValue:runAttributes];
            CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        NSInvocation *invocation = [self getInvokeHookWithContextRef:contextRef point:point run:run];
        if (invocation) {
            [invocation invoke];
        }
            for (CFIndex runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run); runGlyphIndex++)
            {
                
                /* CGContextTranslateCTM实现文字旋转，有bug
                CGAffineTransform originT = CGContextGetTextMatrix(contextRef);
//                CGContextTranslateCTM(contextRef, 0, self.bounds.size.height);
//                CGContextScaleCTM(contextRef, 1.0, -1.0);
                CGAffineTransform   rotation = CGAffineTransformRotate(originT, DEGREES_TO_RADIANS(angle));
                   rotation = CGAffineTransformTranslate(rotation, -originT.tx,- originT.ty);
                CGContextSetTextMatrix(contextRef, rotation);
                
                CGContextTranslateCTM(contextRef, 0, self.bounds.size.height);
                CGContextScaleCTM(contextRef, 1.0, -1.0);
                
                CTRunDraw(run, contextRef, CFRangeMake(0, 0));
                
                CGContextSetTextMatrix(contextRef, originT);
                CGContextTranslateCTM(contextRef, 0, self.bounds.size.height);
                CGContextScaleCTM(contextRef, 1.0, -1.0);
                return;
                 */
                CFRange thisGlyphRange = CFRangeMake(runGlyphIndex, 1);
                CGGlyph glyph;
                CGPoint position;
                CTRunGetGlyphs(run, thisGlyphRange, &glyph);
                CTRunGetPositions(run, thisGlyphRange, &position);
                
                CGPathRef letter = CTFontCreatePathForGlyph(runFont, glyph, NULL);
                if (!letter) {
                    break;
                }
                UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:letter];
                CGAffineTransform t = CGAffineTransformMakeTranslation(point.x + position.x,point.y + position.y);
                [path applyTransform:t];

                CGContextSaveGState(contextRef);
                CGRect glyphRect = [self.glyphRects[runRange.location + runGlyphIndex] CGRectValue];
                CGFloat x = glyphRect.origin.x + glyphRect.size.width/2.0;
                CGFloat y = self.bounds.size.height - glyphRect.origin.y - glyphRect.size.height/2.0;
                CGContextTranslateCTM(contextRef, x, y);
                CGAffineTransform textTransform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(-angle));
                CGContextConcatCTM(contextRef, textTransform);
                CGContextTranslateCTM(contextRef, -x, -y);
              
                [path fill];
                CGContextRestoreGState(contextRef);

            }
    }else{
        [self invokeHookWithContextRef:contextRef point:point run:run isDraw:isDraw];

    }

    
}

#pragma mark - get name value
- (CGFloat)getQDCustomImageObliquenessNameValue:(NSDictionary *)Attributes{
    NSNumber *valueAngle =  Attributes[QDCustomImageObliquenessName];
    
    if (valueAngle) {
        return valueAngle.doubleValue;
    }
    return 0;
}
- (CGFloat)getQDCustomObliquenessNameValue:(NSDictionary *)Attributes{
    NSNumber *valueAngle =  Attributes[QDCustomObliquenessName];
    
    if (valueAngle) {
        return valueAngle.doubleValue;
    }
    return 0;
}

- (CGSize)getQDCustomBackgroundValueSizeNameValue:(NSDictionary *)Attributes{
    NSValue *valueSize =  Attributes[QDCustomBackgroundValueSizeName];
    
    if (valueSize) {
        return valueSize.CGSizeValue;
    }
    return CGSizeZero;
}
- (BOOL)getQDCustomLineIsForegroundNameValue:(NSDictionary *)Attributes{
    NSNumber *isForeground =  Attributes[QDCustomLineIsForegroundName];
    
    if (isForeground) {
        return isForeground.boolValue;
    }
    return YES;
}
- (CGFloat)getQDCustomLineHeightNameValue:(NSDictionary *)Attributes withGlyph:(CGFloat)glyphHeight{
    
    NSNumber *lineHeightGlyph = Attributes[QDCustomLineHeightGlyphName];
    if (lineHeightGlyph) {
        return lineHeightGlyph.doubleValue * glyphHeight;
    }
    NSNumber *lineHeight =  Attributes[QDCustomLineHeightName];
    
    if (lineHeight) {
        return lineHeight.doubleValue;
    }
    return 1;
}
- (id)getQDCustomLineValueNameValue:(NSDictionary *)Attributes{
    id lineValue =  Attributes[QDCustomLineValueName];
    
    if (!lineValue) {
        return [UIColor redColor];
    }
    if ([lineValue isKindOfClass:[UIImage class]] || [lineValue isKindOfClass:[UIColor class]]) {
        return lineValue;
    }
    return [UIColor redColor];
}

#pragma mark - size fit
-(CGSize)sizeThatFits:(CGSize)size{
  CGFloat h =  [self getAttributedStringHeightWithString:self.as WidthValue:self.bounds.size.width];
    return CGSizeMake(size.width, h);
}
- (int)getAttributedStringHeightWithString:(NSAttributedString *)  string  WidthValue:(int) width
{
    int total_height = 0;
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);
    CGRect drawingRect = CGRectMake(0, 0, width, 1000);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray *linesArray = (NSArray *) CTFrameGetLines(textFrame);
    
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    int line_y = (int) origins[[linesArray count] -1].y;  //最后一行line的原点y坐标
    NSLog(@"1===%d",line_y);

    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    
    CTLineRef line = (__bridge CTLineRef) [linesArray objectAtIndex:[linesArray count]-1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    total_height = 1000 - line_y + (int) descent +1 + 5;
    
    CFRelease(textFrame);
    
    return total_height;
    
}

- (CGSize)intrinsicContentSize{
    return [self sizeThatFits:[super intrinsicContentSize]];
}
#pragma mark - debug
- (void)createLayers{
    if (!self.debug) {
        return;
    }
    for (NSValue *rectValue in self.glyphRects) {
        CGRect rect = rectValue.CGRectValue;
        CALayer *layer = [CALayer layer];
        layer.frame = rect;
        layer.backgroundColor = [UIColor colorWithRed:arc4random()%255/256.0 green:arc4random()%255/256.0 blue:arc4random()%255/256.0 alpha:0.3].CGColor;
        [self.layer addSublayer:layer];
    }
}


@end
