//
//  QDCTViewController.m
//  TextFontDemo
//
//  Created by QD on 2017/9/8.
//  Copyright © 2017年 QDDemo. All rights reserved.
//

#import "QDCTViewController.h"
#import "QDCTVIew.h"
#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00) >> 8))/255.0 blue:((float)((rgbValue) & 0xFF))/255.0 alpha:a]
@interface QDCTViewController ()
@property (nonatomic, strong) QDCTVIew *CTV;
@end

@implementation QDCTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    QDCTVIew *CTV = [[QDCTVIew alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
    CTV.frame = CGRectMake((w-300)/2, 100, 300, 500);
    [self.view addSubview:CTV];
    self.CTV = CTV;
    self.CTV.backgroundColor = [UIColor whiteColor];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:NSSelectorFromString([NSString stringWithFormat:@"layoutText%ld",self.type])];
#pragma clang diagnostic pop
}
//块状背景
- (void)layoutText0{
    NSString *text = @"\n如果有一天，你不知道何故阴差阳错的梦到了我,请记得，我是爱你的。\n\n----李宫俊的诗";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_image"]];
    self.CTV.backgroundColor = UIColorFromRGBA(0x90c0ac, 0.3);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentRight;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:16],
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 NSForegroundColorAttributeName:[UIColor whiteColor]
                                 };
    NSMutableAttributedString *as =  [[[NSAttributedString alloc] initWithString:text attributes:attributes] mutableCopy];
    self.CTV.as = as;
    [self.CTV sizeToFit];

}
// 中划线
- (void)layoutText1{
    NSString *text = @"我不会在喜欢你了，这么久依赖，难过比开心更多，被你折磨的不想自己，我受够了。根本就不明白我想要什么，红红我就这么难吗？让我下定决心离开的，不是忽冷忽热的温柔，而是你从未我付出过。再见。";
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 };
    NSMutableAttributedString *as =  [[[NSAttributedString alloc] initWithString:text attributes:attributes] mutableCopy];

    NSDictionary *dictAttr4 = @{NSKernAttributeName:@(1)};
    [as addAttributes:dictAttr4 range:NSMakeRange(0, text.length)];
    
    NSDictionary *strikenThroughStyle1 = @{QDCustomLinePositionName:@(QDLinePositionMiddle),
                                           QDCustomLineHeightName:@(4),
                                           QDCustomLineValueName:[UIColor redColor],
                                           QDCustomLineIsForegroundName:@(YES),
                                           };
    [as addAttributes:strikenThroughStyle1 range:NSMakeRange(9, text.length-4-8)];
    self.CTV.as = as;
    [self.CTV sizeToFit];

}
// 下划线图片
- (void)layoutText2{
    NSString *text = @"\n我不会在喜欢你了，这么久依赖，难过比开心更多，被你折磨的不想自己，我受够了。根本就不明白我想要什么，红红我就这么难吗？让我下定决心离开的，不是忽冷忽热的温柔，而是你从未我付出过。再见。";
    self.CTV.backgroundColor = [UIColor greenColor];
//    self.CTV.debug = YES;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 20;
    paragraphStyle.alignment = NSTextAlignmentLeft;


    NSDictionary *attributes = @{
                                 NSKernAttributeName:@(1),
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 };
    NSMutableAttributedString *as =  [[[NSAttributedString alloc] initWithString:text attributes:attributes] mutableCopy];
    
    // 下划线图片
    UIImage *image = [UIImage imageNamed:@"heart"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
    NSDictionary *strikenThroughStyle2 = @{QDCustomLinePositionName:@(QDLinePositionBottom),
                                           QDCustomLineHeightName:@(6),
                                           QDCustomLineValueName:image,
                                           QDCustomLineIsForegroundName:@(NO),
                                           };
    [as addAttributes:strikenThroughStyle2 range:NSMakeRange(9, text.length-4-8)];
    self.CTV.as = as;
    
    
}
// 背景填充测试
- (void)layoutText3{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_image"]];
    self.CTV.backgroundColor = [UIColor clearColor];
    NSString *text = @"我不会在喜欢你了\n这么久依赖\n难过比开心更多\n被你折磨的不想自己\n我受够了";
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;
    paragraphStyle.alignment = NSTextAlignmentRight;
    NSDictionary *attributes = @{
                                 NSKernAttributeName:@(1),
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 };
    NSMutableAttributedString *as =  [[[NSAttributedString alloc] initWithString:text attributes:attributes] mutableCopy];
    
    // 开始背景填充测试
    NSDictionary *strikenThroughStyle3 = @{QDCustomLinePositionName:@(QDLinePositionMiddle),
                                           QDCustomLineHeightGlyphName:@(1),
                                           QDCustomLineValueName:[UIColor blackColor],
                                           QDCustomLineIsForegroundName:@(NO),
                                           NSForegroundColorAttributeName:[UIColor whiteColor]
                                           };
    [as addAttributes:strikenThroughStyle3 range:NSMakeRange(0, text.length)];
    self.CTV.as = as;
    
    
}

// 背景图片

- (void)layoutText4{
    self.CTV.backgroundColor = [UIColor greenColor];
    NSString *text = @"\n潜规则";
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 50;
    paragraphStyle.firstLineHeadIndent = 50;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    NSDictionary *attributes = @{
                                 NSKernAttributeName:@(50),
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 };
    NSMutableAttributedString *as =  [[[NSAttributedString alloc] initWithString:text attributes:attributes] mutableCopy];
    
    // 背景图片
  SEL action = @selector(customDraw5:);
    UIImage *image1 = [UIImage imageNamed:@"text_background"];
    NSDictionary *strikenThroughStyle4 = @{
                                           NSKernAttributeName:@(30),
                                           NSFontAttributeName:[UIFont systemFontOfSize:50],
                                           QDCustomLinePositionName:@(QDLinePositionCenter),
                                           
                                           QDCustomLineValueName:image1,
                                           QDCustomLineIsForegroundName:@(NO),
                                           QDCustomBackgroundValueSizeName:[NSValue valueWithCGSize:CGSizeMake(100, 100)],
                                               QDCustomContextHookName:[ContextHookModel ContextHookWithTarget:self action:action]
                                           };
    [as addAttributes:strikenThroughStyle4 range:NSMakeRange(1, text.length-1)];
    self.CTV.as = as;
//    self.CTV.debug = YES;
    
    
}
// 背景图片和文字旋转
- (void)layoutText5{
    NSString *text = @"\n潜规则";
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 50;
    paragraphStyle.firstLineHeadIndent = 50;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName:[UIColor redColor],
                                 NSKernAttributeName:@(50),
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                 NSParagraphStyleAttributeName:paragraphStyle,
                                 };
    NSMutableAttributedString *as =  [[[NSAttributedString alloc] initWithString:text attributes:attributes] mutableCopy];
    
    // 背景图片和文字旋转
    SEL action = @selector(customDraw5:);

    UIImage *image1 = [UIImage imageNamed:@"text_background"];

    NSDictionary *strikenThroughStyle6 = @{
                                           NSKernAttributeName:@(30),
                                           NSFontAttributeName:[UIFont systemFontOfSize:50],
                                           QDCustomLinePositionName:@(QDLinePositionCenter),
                                           
                                           QDCustomLineValueName:image1,
                                           QDCustomLineIsForegroundName:@(NO),
                                           QDCustomBackgroundValueSizeName:[NSValue valueWithCGSize:CGSizeMake(100, 100)],
                                           QDCustomObliquenessName:@(45),
                                           QDCustomImageObliquenessName:@(45),
                                            QDCustomContextHookName:[ContextHookModel ContextHookWithTarget:self action:action]
                                         
                                           };

    [as addAttributes:strikenThroughStyle6 range:NSMakeRange(1, text.length-1)];
    self.CTV.as = as;
//    self.CTV.debug = YES;
    
    
}
- (void)customDraw5:(CGContextRef)context{
    CGContextSetLineWidth(context, 1);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(context, kCGTextStroke);
}
@end
