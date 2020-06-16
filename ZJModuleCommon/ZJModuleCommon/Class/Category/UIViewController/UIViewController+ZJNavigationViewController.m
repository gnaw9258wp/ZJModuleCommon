//
//  UIViewController+BGNavigationViewController.m
//  bingo_navDemo
//
//  Created by 王鹏 on 2018/7/23.
//  Copyright © 2018年 王鹏. All rights reserved.
//

#import "UIViewController+ZJNavigationViewController.h"
@implementation UIViewController (ZJNavigationViewController)

- (BOOL)ZJ_prefresHiddenNavigationBar {
    return NO;
}

- (UIViewController *)ZJ_previousViewController {
    NSInteger count = self.navigationController.viewControllers.count;
    if (count > 1) {
        return self.navigationController.viewControllers[count - 2];
    }
    
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)ZJ_pushAnimation{
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>)ZJ_popAnimation {
    return nil;
}

- (void)ZJ_backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)ZJ_showBackButtonItem
{
    return YES;
}

- (NSArray<UIBarButtonItem *> *)ZJ_backBarButtonItems {
    return nil;
}

- (BOOL)ZJ_interactivePopGestureEnabled {
    return YES;
}

- (CGFloat)safeAreaHeight {
    return  [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height;
}

- (NSDictionary<NSAttributedStringKey, id> *)ZJ_titleTextAttributes {
    return nil;
}

- (UIColor *)ZJ_lineColor {
    return nil;
}

- (void)ZJ_preDeallocInNav {
    
}

//默认导航条背景色
- (ZJNavType)ZJ_navType
{
    return ZJNavTypeNormal;
}

- (UIColor *)ZJ_navTypeCustomColor{
    return [UIColor whiteColor];
}

- (UIStatusBarStyle)ZJ_StatusBarStyle
{
    return UIStatusBarStyleDefault;
}
//强制展示返回按钮 一般用在presentViewController中
- (BOOL)ZJ_forceShowBackButtonItem
{
    return NO;
}
@end
