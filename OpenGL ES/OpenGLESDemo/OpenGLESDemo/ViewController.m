//
//  ViewController.m
//  OpenGLESDemo
//
//  Created by QD on 2017/8/24.
//  Copyright © 2017年 QDDemo. All rights reserved.
//

#import "ViewController.h"
#import "OpenGLESView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    OpenGLESView *view = [[OpenGLESView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:view];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
