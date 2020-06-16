//
//  ViewController.m
//  ZJModuleCommon
//
//  Created by wp on 2020/1/16.
//  Copyright © 2020 wp. All rights reserved.
//

#import "ViewController.h"
#import "ZJModuleCommon.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [MBProgressHUD ZJ_showCustomGifLoadingInWindowMessage:nil iconName:@"tabbar_discoverhighlightgif" timer:2];
}
@end
