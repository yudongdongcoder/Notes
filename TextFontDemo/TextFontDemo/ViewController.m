//
//  ViewController.m
//  TextFontDemo
//
//  Created by QD on 2017/8/9.
//  Copyright © 2017年 QDDemo. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <VideoToolbox/VideoToolbox.h>
#import "A.h"
#import "QDTextView.h"
#import "CoreTextView.h"
#import "QDCTVIew.h"
@import CoreText;
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet CoreTextView *CT;
@property (weak, nonatomic) IBOutlet QDCTVIew *qdct;
@end

@implementation ViewController
//-(void)layoutManager:(NSLayoutManager *)layoutManager didCompleteLayoutForTextContainer:(NSTextContainer *)textContainer atEnd:(BOOL)layoutFinishedFlag{
////    [self calculateLineFrame];
//}




-(void)viewDidLoad{
    [super viewDidLoad];
        NSString *text =
    @"开始中划线测试中划线测试中划线测试中划\n"
    @"开始下划线图片测试下划线图片测试下划线\n"
    @"开始背景填充测试背景填充测试背景填充测\n"
    @"背景图片\n"
    @"文字旋转\n"
    @"背景图片和文字旋转\n";
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 20;// 字体的行间距
        paragraphStyle.alignment = NSTextAlignmentLeft;
        NSDictionary *attributes = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:30],
                                     NSParagraphStyleAttributeName:paragraphStyle
                                     };
      NSMutableAttributedString *as =  [[[NSAttributedString alloc] initWithString:text attributes:attributes] mutableCopy];
    NSDictionary *dictAttr4 = @{NSKernAttributeName:@(10)};
    [as addAttributes:dictAttr4 range:NSMakeRange(0, text.length)];
    
  // 中划线
    NSDictionary *strikenThroughStyle1 = @{QDCustomLinePositionName:@(QDLinePositionMiddle),
                                          QDCustomLineHeightName:@(6),
                                          QDCustomLineValueName:[UIColor redColor],
                                          QDCustomLineIsForegroundName:@(NO),
                                          };
    [as addAttributes:strikenThroughStyle1 range:NSMakeRange(1, 15)];
    
    // 下划线图片
        UIImage *image = [UIImage imageNamed:@"heart"];
        image = [image resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
    NSDictionary *strikenThroughStyle2 = @{QDCustomLinePositionName:@(QDLinePositionBottom),
                                           QDCustomLineHeightName:@(6),
                                           QDCustomLineValueName:image,
                                           QDCustomLineIsForegroundName:@(NO),
                                           };
    [as addAttributes:strikenThroughStyle2 range:NSMakeRange(21, 10)];
    // 开始背景填充测试
    NSDictionary *strikenThroughStyle3 = @{QDCustomLinePositionName:@(QDLinePositionMiddle),
                                           QDCustomLineHeightGlyphName:@(1),
                                           QDCustomLineValueName:[UIColor blackColor],
                                           QDCustomLineIsForegroundName:@(NO),
                                           NSForegroundColorAttributeName:[UIColor whiteColor]
                                           };
    [as addAttributes:strikenThroughStyle3 range:NSMakeRange(41, 15)];
    // 背景图片
    UIImage *image1 = [UIImage imageNamed:@"heart_back"];
    NSDictionary *strikenThroughStyle4 = @{
                                           NSKernAttributeName:@(30),
                                           NSFontAttributeName:[UIFont systemFontOfSize:50],
                                           QDCustomLinePositionName:@(QDLinePositionCenter),
                                           
                                           QDCustomLineValueName:image1,
                                           QDCustomLineIsForegroundName:@(NO),
                                           QDCustomBackgroundValueSizeName:[NSValue valueWithCGSize:CGSizeMake(70, 70)],
                                           NSForegroundColorAttributeName:[UIColor redColor]
                                           /*QDCustomImageObliquenessName:@(45)*/
                                           };
    [as addAttributes:strikenThroughStyle4 range:NSMakeRange(60, 4)];
    
    
    // 文字旋转
    NSDictionary *strikenThroughStyle5 = @{
                                           NSKernAttributeName:@(30),
                                           NSFontAttributeName:[UIFont systemFontOfSize:40],
                                           QDCustomObliquenessName:@(20)
                                           };
    [as addAttributes:strikenThroughStyle5 range:NSMakeRange(65, 4)];
    
    
    // 背景图片和文字旋转
    
    NSDictionary *strikenThroughStyle6 = @{
                                           NSKernAttributeName:@(30),
                                           NSFontAttributeName:[UIFont systemFontOfSize:50],
                                           QDCustomLinePositionName:@(QDLinePositionCenter),
                                           
                                           QDCustomLineValueName:image1,
                                           QDCustomLineIsForegroundName:@(NO),
                                           QDCustomBackgroundValueSizeName:[NSValue valueWithCGSize:CGSizeMake(70, 70)],
                                           QDCustomObliquenessName:@(45),
                                           QDCustomImageObliquenessName:@(45)

                                           };
    [as addAttributes:strikenThroughStyle6 range:NSMakeRange(70, 4)];
    
    self.qdct.as = as;
    return;
    

    // context hook
    SEL action = @selector(customDraw:);
    NSDictionary *strikenThroughStyle7 = @{
                                           QDCustomLinePositionName:@(QDLinePositionNone),
                                           QDCustomContextHookName:[ContextHookModel ContextHookWithTarget:self action:action]
                                          
                                           };
    [as addAttributes:strikenThroughStyle7 range:NSMakeRange(70, 2)];
    
    SEL action1 = @selector(customDraw1:run:);
    NSDictionary *strikenThroughStyle8 = @{
                                           QDCustomLinePositionName:@(QDLinePositionNone),
                                           QDCustomContextHookName:[ContextHookModel ContextHookWithTarget:self action:action1]
                                           
                                           };
    [as addAttributes:strikenThroughStyle8 range:NSMakeRange(73, 2)];
    
//    CGAffineTransform matrix = CGAffineTransformMake(1,0, tan(-M_PI_4), 1, 0, 0);
////    CGAffineTransform matrix = { 1, 0, 0.5, 1, 0, 0 };
//    CTFontRef myFont = CTFontCreateWithName(CFSTR("Helvetica"), 40, &matrix);
//    NSDictionary *dictAttr12 = @{(NSString *)kCTFontAttributeName:(__bridge id)myFont};
//    [as addAttributes:dictAttr12 range:NSMakeRange(7, 1)];
    
//    NSDictionary *dictAttr12 = @{NSObliquenessAttributeName:@(-0.7)};
//    [as addAttributes:dictAttr12 range:NSMakeRange(4, 3)];

//     [as addAttributes:strikenThroughStyle range:NSMakeRange(5, 1)];
//     [as addAttributes:strikenThroughStyle range:NSMakeRange(7, 1)];
//     [as addAttributes:strikenThroughStyle range:NSMakeRange(9, 1)];
//     [as addAttributes:strikenThroughStyle range:NSMakeRange(11, 1)];
//    [as addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(4, 3)];

//    [self.qdct sizeToFit];
//    self.qdct.underLineRange = NSMakeRange(3, 10);
//    self.label.attributedText = as;
//    self.label.hidden = YES;
}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    NSString *text = @"我还是很喜欢你\n"
//    @"像老故事里的泛黄桥段sdcascaxczxczxczxczxczxczxczxc时代峻峰噶就是看到合格方可骄傲三个地方金卡是个大飞机撒旦法还是贷款纠纷哈收到回复\n"
//    @"半聋半哑\n"
//    @"失了声息";
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.lineSpacing = 10;// 字体的行间距
//    
//    NSDictionary *attributes = @{
//                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
//                                 NSParagraphStyleAttributeName:paragraphStyle
//                                 };
//  NSAttributedString *as =  [[NSAttributedString alloc] initWithString:text attributes:attributes];
//    self.CT.as = as;
//
////    self.label.attributedText = as;
//   
//    QDTextView *textView = [[QDTextView alloc] initWithFrame:CGRectMake(100, 100, 100, 200) attributesString:as];
//    [self.view addSubview:textView];
////    [textView sizeToFit];
////    textView.attributedText = as;
////    textView.textAlignment = NSTextAlignmentCenter;
//    
//    
//    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithString:@"我还是很喜欢你\n"
//    @"像老故事里的泛黄桥段\n"
//    @"半聋半哑\n"
//    @"失了声息" ];
//    
//    NSLayoutManager *layoutManager = [NSLayoutManager new];
//    [textStorage addLayoutManager: layoutManager];
//    layoutManager.delegate = self;
//    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(100, 100)];
//    [layoutManager addTextContainer: textContainer];
//    
//    QDTextView *textView2 = [[QDTextView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)
//                                               textContainer:textContainer];
//    
////    textView.text = @"我还是很喜欢你\n"
////    @"像老故事里的泛黄桥段\n"
////    @"半聋半哑\n"
////    @"失了声息";
//    CGRect layoutRect = [layoutManager usedRectForTextContainer:textContainer];
//    [self.view addSubview:textView2];
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//        [layoutManager enumerateLineFragmentsForGlyphRange:NSMakeRange(0, textView.text.length) usingBlock:^(CGRect rect, CGRect usedRect, NSTextContainer * _Nonnull textContainer, NSRange glyphRange, BOOL * _Nonnull stop) {
//            [array addObject:[NSValue valueWithRange:glyphRange]];
//    
//        }];
//    NSMutableArray *rects = [NSMutableArray array];
//    for (NSValue *rangeValue in array) {
//       CGRect rect = [layoutManager boundingRectForGlyphRange:rangeValue.rangeValue inTextContainer:textContainer];
//        rect.origin.y += 100/2-layoutRect.size.height/2.0;
//        [rects addObject:[NSValue valueWithCGRect:rect]];
//    }
//    [textView2 addLayer:rects];
////    NSLayoutManager
////    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
////    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"test "
////                                                                             attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone)}]];
////    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"string"
////                                                                             attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleDouble | NSUnderlineByWord|NSUnderlinePatternDash),
////                                                                                          NSBackgroundColorAttributeName: [UIColor greenColor],
////                                                                                          NSUnderlineColorAttributeName:[UIColor redColor]}]];
////    
////    
////    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"tring"]];
////    self.label.attributedText =  attributedString;
////    self.label.text = @"我还是很喜欢你\n"
////                      @"像老故事里的泛黄桥段\n"
////                      @"半聋半哑\n"
////                      @"失了声息";
////    self.label.shadowColor = [UIColor redColor];
////    self.label.shadowOffset = 3;
////    A *a = [A new];
////    B *b = [B new];
////    a.b = b;
//////    [A logClass];
////    B *b1 = a;
////    b1.name = @"123";
//////    [b1 log];
////    NSLog(@"%@",b1.name);
////    
//////    b1->height = @"height123";
////    NSLog(@"%@",b1->height);
////    id h = b1->height;
////    NSLog(@"%@",h);
//    // FZJLJW--GB1-0
//    // Do any additional setup after loading the view, typically from a nib.
//}

- (void)customDraw:(CGContextRef)context{
//    NSLog(@"%@",context);
    CGContextSetLineWidth(context, 1);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(context, kCGTextStroke);
}
- (void)customDraw1:(CGContextRef)context run:(CTRunRef)run{
//    NSLog(@"%@",context);
    CGContextSetLineWidth(context, 1);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetTextDrawingMode(context, kCGTextFillStroke);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.label setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
