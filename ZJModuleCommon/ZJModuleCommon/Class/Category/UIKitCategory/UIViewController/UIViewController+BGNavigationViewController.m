//
//  UIViewController+BGNavigationViewController.m
//  bingo_navDemo
//
//  Created by 王鹏 on 2018/7/23.
//  Copyright © 2018年 王鹏. All rights reserved.
//

#import "UIViewController+BGNavigationViewController.h"
@implementation UIViewController (BGNavigationViewController)

- (BOOL)bg_prefresHiddenNavigationBar {
    return NO;
}

- (UIViewController *)bg_previousViewController {
    NSInteger count = self.navigationController.viewControllers.count;
    if (count > 1) {
        return self.navigationController.viewControllers[count - 2];
    }
    
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>) pushAnimation{
    return nil;
}

- (id<UIViewControllerAnimatedTransitioning>) popAnimation {
    return nil;
}

- (void)bg_backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)bg_showBackButtonItem
{
    return YES;
}

- (NSArray<UIBarButtonItem *> *)bg_backBarButtonItems {
    return nil;
}

- (BOOL)bg_interactivePopGestureEnabled {
    return YES;
}

- (CGFloat)safeAreaHeight {
    return  [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height;
}

- (NSDictionary<NSAttributedStringKey, id> *)bg_titleTextAttributes {
    return nil;
}

- (UIColor *)bg_lineColor {
    return nil;
}

- (void)bg_preDeallocInNav {
    
}

//默认导航条背景色
- (NavType)bg_navType
{
    return NavTypeNormal;
}

- (UIStatusBarStyle)bg_StatusBarStyle
{
    return UIStatusBarStyleDefault;
}
//强制展示返回按钮 一般用在presentViewController中
- (BOOL)bg_forceShowBackButtonItem
{
    return NO;
}
@end
