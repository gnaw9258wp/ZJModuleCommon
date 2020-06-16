//
//  ZJBaseViewController.m
//  ZJModuleCommon
//
//  Created by wp on 2020/1/16.
//  Copyright © 2020 wp. All rights reserved.
//

#import "ZJBaseViewController.h"
#import "UIViewController+ZJNavigationViewController.h"
#import "UIImage+ZJColor.h"
#import "UIImage+JKColor.h"
#import "UIColor+JKHEX.h"
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
    
    if ([self ZJ_prefresHiddenNavigationBar])
    {
        return;
    }
    
    if ([self ZJ_navType] == ZJNavTypeNormal)
    {
        UIImage *whiteImage = [UIImage ZJ_imageFromColor:[UIColor whiteColor] size:CGSizeMake(UIScreen.mainScreen.bounds.size.width, ZJTopHeight)];
        [self.navigationController.navigationBar setBackgroundImage:whiteImage forBarMetrics:UIBarMetricsDefault];
        if (self.ZJ_lineColor)
        {
            UIImage *lineImage = [UIImage ZJ_imageFromColor:self.ZJ_lineColor size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.5)];
            [self.navigationController.navigationController.navigationBar setShadowImage:lineImage];
        }else
        {
            UIImage *lineImage = [UIImage ZJ_imageFromColor:[UIColor clearColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.5)];
            [self.navigationController.navigationBar setShadowImage:lineImage];
        }
    }else if ([self ZJ_navType] == ZJNavTypeCustomColor)
    {
        UIImage *blueImage = [UIImage jk_imageWithColor:[self ZJ_navTypeCustomColor]];
        [self.navigationController.navigationBar setBackgroundImage:blueImage forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }else if ([self ZJ_navType] == ZJNavTypeClear)
    {
        self.navigationController.navigationBar.translucent = YES;
        self.navigationController.navigationBar.barTintColor = UIColor.clearColor;
        UIImage *clearImage = [UIImage jk_imageWithColor:[UIColor clearColor]];
        [self.navigationController.navigationBar setBackgroundImage:clearImage forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    }
}
@end
