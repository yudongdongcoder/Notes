//
//  CoreTextView.m
//  TextFontDemo
//
//  Created by QD on 2017/8/9.
//  Copyright © 2017年 QDDemo. All rights reserved.
//

#import "CoreTextView.h"
#import <CoreText/CoreText.h>
@implementation CoreTextView


- (void)drawRect:(CGRect)rect
{
    if (!self.as) {
        return;
    }
//    self.layers = [NSMutableArray array];
    [super drawRect:rect];
    
    // 1.获取上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    // [a,b,c,d,tx,ty]
//    NSLog(@"转换前的坐标：%@",NSStringFromCGAffineTransform(CGContextGetCTM(contextRef)));
    
    // 2.转换坐标系,CoreText的原点在左下角，UIKit原点在左上角
    CGContextSetTextMatrix(contextRef, CGAffineTransformIdentity);
    
    // 这两种转换坐标的方式效果一样
    // 2.1
    // CGContextTranslateCTM(contextRef, 0, self.bounds.size.height);
    // CGContextScaleCTM(contextRef, 1.0, -1.0);
    
    // 2.2
    CGContextConcatCTM(contextRef, CGAffineTransformMake(1, 0, 0, -1, 0, self.bounds.size.height));
    
//    NSLog(@"转换后的坐标：%@",NSStringFromCGAffineTransform(CGContextGetCTM(contextRef)));
    
    
    // 3.创建绘制区域，可以对path进行个性化裁剪以改变显示区域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    // CGPathAddEllipseInRect(path, NULL, self.bounds);
  /*
    // 4.创建需要绘制的文字
    NSString *str = @"爱上GFA股司法局";
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:str];
    
    [attributed addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"FZJLJW--GB1-0" size:40] range:NSMakeRange(0, attributed.length)];
//    [attributed addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:100] range:NSMakeRange(0, 5)];
    

    // 两种方式皆可
//    [attributed addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(4, 10)];
    [attributed addAttribute:(id)kCTForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(0, attributed.length)];
    
    // 设置行距等样式
    CGFloat lineSpace = 10; // 行距一般取决于这个值
    CGFloat lineSpaceMax = 20;
    CGFloat lineSpaceMin = 2;
    const CFIndex kNumberOfSettings = 3;
    
    // 结构体数组
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        
        {kCTParagraphStyleSpecifierLineSpacingAdjustment,sizeof(CGFloat),&lineSpace},
        {kCTParagraphStyleSpecifierMaximumLineSpacing,sizeof(CGFloat),&lineSpaceMax},
        {kCTParagraphStyleSpecifierMinimumLineSpacing,sizeof(CGFloat),&lineSpaceMin}
        
    };
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    
    // 单个元素的形式
    // CTParagraphStyleSetting theSettings = {kCTParagraphStyleSpecifierLineSpacingAdjustment,sizeof(CGFloat),&lineSpace};
    // CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(&theSettings, kNumberOfSettings);
    
    // 两种方式皆可
    // [attributed addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)theParagraphRef range:NSMakeRange(0, attributed.length)];
    
    // 将设置的行距应用于整段文字
    [attributed addAttribute:NSParagraphStyleAttributeName value:(__bridge id)(theParagraphRef) range:NSMakeRange(0, attributed.length)];
    
    CFRelease(theParagraphRef);
    
   */
    NSMutableAttributedString *attributed = [self.as mutableCopy];
    // 5.根据NSAttributedString生成CTFramesetterRef
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributed);
    
    CTFrameRef ctFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attributed.length), path, NULL);
    
    // 6.绘制除图片以外的部分
    CTFrameDraw(ctFrame, contextRef);
    
    
//    // 7.内存管理，ARC不能管理CF开头的对象，需要我们自己手动释放内存
//    CFRelease(path);
//    CFRelease(framesetter);
//    CFRelease(ctFrame);
    
    
    
    
    // 获取多少行
    CFArrayRef lines = CTFrameGetLines(ctFrame);

    
    CFIndex count = CFArrayGetCount(lines);
    
    // 获得每一行的origin坐标
    
    CGPoint origins[count];
    CTFrameGetLineOrigins(ctFrame, CFRangeMake(0,0), origins);
    CFRange ranges[count];
    
    // 翻转坐标系
    CGAffineTransform transform =  CGAffineTransformMakeTranslation(0, self.bounds.size.height);
    transform = CGAffineTransformScale(transform, 1.f, -1.f);
    
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];

    for (int i = 0; i < count; i++) {
        CTLineRef lineRef = CFArrayGetValueAtIndex(lines,i);
        CGPoint point = origins[i];
        CGFloat lineAscent;
        CGFloat lineDescent;
        CGFloat width = CTLineGetTypographicBounds(lineRef, &lineAscent, &lineDescent, NULL);
        
        CGRect lineRect = CGRectMake(point.x, self.bounds.size.height - point.y - lineAscent, width, lineDescent + lineAscent);
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
//    return (NSArray *)linesArray;
    [self addLayer:linesArray];
    
//    for (int i = 0; i < count; i++) {
//        
//        CGPoint linePoint = origins[i];
//        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
//        CFRange range = CTLineGetStringRange(line);
//        ranges[i] = range;
////        CFArrayRef run = CTLineGetGlyphRuns(line);
////        CFIndex runCount = CFArrayGetCount(run);
////        for (int i = 0; i < runCount; i++) {
//////            CTLin
////        }
//        // 获得每一行的CGRect信息
////        CGRect flippedRect = [self getLineBounds:line point:linePoint];
////        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
////        NSLog(@"%@",[NSValue valueWithCGPoint:linePoint]);
//        
////        if (CGRectContainsPoint(rect, point)) {
////            // 将点击的坐标转换成相对于当前行的坐标
////            CGPoint relativePoint = CGPointMake(point.x-CGRectGetMinX(rect),
////                                                point.y-CGRectGetMinY(rect));
////            // 获得当前点击坐标对应的字符串偏移
////            idx = CTLineGetStringIndexForPosition(line, relativePoint);
////        }
//    }
    
//[str enumerateSubstringsInRange:NSMakeRange(0, str.length) options:NSStringEnumerationByWords usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
////    NSLog(@"---%@",substring);
//}];
//    for (int i = 0; i < str.length; i ++) {
//        long maxLoc;
//        int lineNum;
//        for (int j = 0; j < count; j ++) {
//            CFRange range = ranges[j];
//            maxLoc = range.location + range.length - 1;
//            if (i <= maxLoc) {
//                lineNum = j;
//                break;
//            }
//        }
//        CTLineRef line = CFArrayGetValueAtIndex(lines, lineNum);
//        CGPoint origin = origins[lineNum];
//        CGRect CTRunFrame = [self frameForCTRunWithIndex:i CTLine:line origin:origin];
////        CTRunFrame.origin.y = rect.size.height - CTRunFrame.origin.y - CTRunFrame.size.height;
//        
////        CTRunFrame.origin.y += 200;
////        NSLog(@"===%@",[NSValue valueWithCGRect:CTRunFrame]);
//
//        [sellayerrs addObject:[NSValue valueWithCGRect:CTRunFrame]];
////        if ([self isFrame:CTRunFrame containsPoint:location]) {
////            NSLog(@"您点击到了第 %d 个字符，位于第 %d 行，然而他没有响应事件。",i,lineNum + 1);//点击到文字，然而没有响应的处理。可以做其他处理
////            return;
////        }
//    }
//    NSMutableArray *animationLayers = [NSMutableArray array];
//    int i = 0;
//    for (NSValue *frameV in self.layers) {
//        CATextLayer *textLayer = [CATextLayer layer];
//        textLayer.frame =frameV.CGRectValue;
//        textLayer.contentsScale = [UIScreen mainScreen].scale;
//        NSAttributedString *string = [attributed attributedSubstringFromRange:NSMakeRange(i, 1)];
//        textLayer.string = string;
//        [self.layer addSublayer:textLayer];
//        [animationLayers addObject:textLayer];
//        i++;
//    }
    
    CFRelease(path);
    CFRelease(framesetter);
    CFRelease(ctFrame);
//    NSLog(@"layer count = %ld",animationLayers.count);
//    NSLog(@"str count = %ld",str.length);
    
//    [animationLayers enumerateObjectsUsingBlock:^(CATextLayer *layer, NSUInteger idx, BOOL * _Nonnull stop) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(idx*0.1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            CABasicAnimation * ani = [CABasicAnimation animationWithKeyPath:@"position.y"];
//            ani.toValue = @(layer.position.y + 200);
//            ani.removedOnCompletion = NO;
//            ani.duration = 2;
//            ani.fillMode = kCAFillModeForwards;
//            ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//            [layer addAnimation:ani forKey:[NSString stringWithFormat:@"ddddd%ld",idx]];
//        });
//    }];
//    
    

}

- (CGRect)getLineBounds:(CTLineRef)line point:(CGPoint)point {
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + descent;
    return CGRectMake(point.x, point.y - descent, width, height);
}

-(CGRect)frameForCTRunWithIndex:(NSInteger)index
                         CTLine:(CTLineRef)line
                         origin:(CGPoint)origin
{
    CGFloat offsetX = CTLineGetOffsetForStringIndex(line, index, NULL);
    CGFloat offsexX2 = CTLineGetOffsetForStringIndex(line, index + 1, NULL);
    offsetX += origin.x;
    offsexX2 += origin.x;
    CGFloat offsetY = origin.y;
    CGFloat lineAscent;
    CGFloat lineDescent;
    NSArray * runs = (__bridge NSArray *)CTLineGetGlyphRuns(line);
    CTRunRef runCurrent;
    for (int k = 0; k < runs.count; k ++) {
        CTRunRef run = (__bridge CTRunRef)runs[k];
        CFRange range = CTRunGetStringRange(run);
        NSRange rangeOC = NSMakeRange(range.location, range.length);
        if ([self isIndex:index inRange:rangeOC]) {
            runCurrent = run;
            break;
        }
    }
    CTRunGetTypographicBounds(runCurrent, CFRangeMake(0, 0), &lineAscent, &lineDescent, NULL);
    CGFloat height = lineAscent + lineDescent;
    //        CTRunFrame.origin.y = rect.size.height - CTRunFrame.origin.y - CTRunFrame.size.height;

    return CGRectMake(offsetX, self.bounds.size.height - offsetY -lineAscent , offsexX2 - offsetX, height);
}
-(BOOL)isIndex:(NSInteger)index inRange:(NSRange)range
{
    if ((index <= range.location + range.length - 1) && (index >= range.location)) {
        return YES;
    }
    return NO;
}
- (void)addLayer:(NSArray *)lineRects
{
    for (NSValue *rectValue in lineRects) {
        CALayer *klayer = [CALayer layer];
        CGRect rect = rectValue.CGRectValue;
        //        rect.size.height = 2;
        klayer.frame = rect;
        klayer.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.3].CGColor;
        [self.layer addSublayer:klayer];
    }
}

@end
