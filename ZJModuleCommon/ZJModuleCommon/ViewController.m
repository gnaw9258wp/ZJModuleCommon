//
//  ViewController.m
//  ZJModuleCommon
//
//  Created by wp on 2020/1/16.
//  Copyright © 2020 wp. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD+JDragon.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [MBProgressHUD showCustomGifLoadingInWindowMessage:@"tabbar_discoverhighlightgif" iconName:@"" timer:2];
}

@end
