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
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet CoreTextView *CT;

@end

@implementation ViewController
-(void)layoutManager:(NSLayoutManager *)layoutManager didCompleteLayoutForTextContainer:(NSTextContainer *)textContainer atEnd:(BOOL)layoutFinishedFlag{
//    [self calculateLineFrame];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *text = @"我还是很喜欢你\n"
    @"像老故事里的泛黄桥段sdcascaxczxczxczxczxczxczxczxc时代峻峰噶就是看到合格方可骄傲三个地方金卡是个大飞机撒旦法还是贷款纠纷哈收到回复\n"
    @"半聋半哑\n"
    @"失了声息";
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
  NSAttributedString *as =  [[NSAttributedString alloc] initWithString:text attributes:attributes];
    self.CT.as = as;

//    self.label.attributedText = as;
   
    QDTextView *textView = [[QDTextView alloc] initWithFrame:CGRectMake(100, 100, 100, 200) attributesString:as];
    [self.view addSubview:textView];
//    [textView sizeToFit];
//    textView.attributedText = as;
//    textView.textAlignment = NSTextAlignmentCenter;
    
    
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithString:@"我还是很喜欢你\n"
    @"像老故事里的泛黄桥段\n"
    @"半聋半哑\n"
    @"失了声息" ];
    
    NSLayoutManager *layoutManager = [NSLayoutManager new];
    [textStorage addLayoutManager: layoutManager];
    layoutManager.delegate = self;
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(100, 100)];
    [layoutManager addTextContainer: textContainer];
    
    QDTextView *textView2 = [[QDTextView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)
                                               textContainer:textContainer];
    
//    textView.text = @"我还是很喜欢你\n"
//    @"像老故事里的泛黄桥段\n"
//    @"半聋半哑\n"
//    @"失了声息";
    CGRect layoutRect = [layoutManager usedRectForTextContainer:textContainer];
    [self.view addSubview:textView2];
    NSMutableArray *array = [[NSMutableArray alloc] init];
        [layoutManager enumerateLineFragmentsForGlyphRange:NSMakeRange(0, textView.text.length) usingBlock:^(CGRect rect, CGRect usedRect, NSTextContainer * _Nonnull textContainer, NSRange glyphRange, BOOL * _Nonnull stop) {
            [array addObject:[NSValue valueWithRange:glyphRange]];
    
        }];
    NSMutableArray *rects = [NSMutableArray array];
    for (NSValue *rangeValue in array) {
       CGRect rect = [layoutManager boundingRectForGlyphRange:rangeValue.rangeValue inTextContainer:textContainer];
        rect.origin.y += 100/2-layoutRect.size.height/2.0;
        [rects addObject:[NSValue valueWithCGRect:rect]];
    }
    [textView2 addLayer:rects];
//    NSLayoutManager
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
//    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"test "
//                                                                             attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone)}]];
//    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"string"
//                                                                             attributes:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleDouble | NSUnderlineByWord|NSUnderlinePatternDash),
//                                                                                          NSBackgroundColorAttributeName: [UIColor greenColor],
//                                                                                          NSUnderlineColorAttributeName:[UIColor redColor]}]];
//    
//    
//    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"tring"]];
//    self.label.attributedText =  attributedString;
//    self.label.text = @"我还是很喜欢你\n"
//                      @"像老故事里的泛黄桥段\n"
//                      @"半聋半哑\n"
//                      @"失了声息";
//    self.label.shadowColor = [UIColor redColor];
//    self.label.shadowOffset = 3;
//    A *a = [A new];
//    B *b = [B new];
//    a.b = b;
////    [A logClass];
//    B *b1 = a;
//    b1.name = @"123";
////    [b1 log];
//    NSLog(@"%@",b1.name);
//    
////    b1->height = @"height123";
//    NSLog(@"%@",b1->height);
//    id h = b1->height;
//    NSLog(@"%@",h);
    // FZJLJW--GB1-0
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.label setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
