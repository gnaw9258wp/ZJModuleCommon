//
//  ZJBaseViewController.m
//  ZJModuleCommon
//
//  Created by wp on 2020/1/16.
//  Copyright © 2020 wp. All rights reserved.
//

#import "ZJBaseViewController.h"
#import "UIViewController+BGNavigationViewController.h"
#import "UIImage+Color.h"
#import "UIColor+HEX.h"
#import "ZJModuleDefine.h"
@interface ZJBaseViewController ()

@end

@implementation ZJBaseViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //布局导航条
    [self configureNav];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)configureNav{
    
    if ([self bg_prefresHiddenNavigationBar])
    {
        return;
    }
    
    if ([self bg_navType] == NavTypeNormal)
    {
        UIImage *whiteImage = [UIImage imageFromColor:[UIColor whiteColor] size:CGSizeMake(UIScreen.mainScreen.bounds.size.width, kTopHeight)];
        [self.navigationController.navigationBar setBackgroundImage:whiteImage forBarMetrics:UIBarMetricsDefault];
        if (self.bg_lineColor)
        {
            UIImage *lineImage = [UIImage imageFromColor:self.bg_lineColor size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.5)];
            [self.navigationController.navigationController.navigationBar setShadowImage:lineImage];
        }else
        {
            UIImage *lineImage = [UIImage imageFromColor:[UIColor clearColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.5)];
            [self.navigationController.navigationBar setShadowImage:lineImage];
        }
    }else if ([self bg_navType] == NavTypeBlue)
    {
        UIImage *blueImage = [UIImage imageWithColor:[UIColor blueColor]];
        [self.navigationController.navigationBar setBackgroundImage:blueImage forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }else if ([self bg_navType] == NavTypeClear)
    {
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.navigationBar.barTintColor = UIColor.clearColor;
        UIImage *clearImage = [UIImage imageWithColor:[UIColor clearColor]];
        [self.navigationController.navigationBar setBackgroundImage:clearImage forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }
}
@end
