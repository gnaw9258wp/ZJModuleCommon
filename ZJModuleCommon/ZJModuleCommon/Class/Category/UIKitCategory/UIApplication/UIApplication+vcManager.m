//
//  UIApplication+vcManager.m
//  ease
//  UIApplication的VC管理器分类
//  Created by 戴奕 on 2017/5/19.
//  Copyright © 2017年 jincheng. All rights reserved.
//

#import "UIApplication+vcManager.h"
#import "UIViewController+Dismiss.h"
//#import "AppDelegate.h"

@implementation UIApplication (vcManager)

- (nullable UITabBarController *)mainTabBarController {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *vcTabBar = (UITabBarController *)rootVC;
        return vcTabBar;
    }
    return nil;
}

- (void)dismissAllPresentVCWithCompletionHandle:(void(^ __nullable)(void))completionHandle {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC dismissAllPresentVCWithCompletion:completionHandle];
}

- (UINavigationController *_Nullable)getNaviVCInMainController {
    UITabBarController *vcTabBar = [self mainTabBarController];
    if (!vcTabBar) { return nil; }
    
    if ([vcTabBar.selectedViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nvc = (UINavigationController *)vcTabBar.selectedViewController;
        return nvc;
    } else {
        return nil;
    }
}

- (UINavigationController *_Nullable)getNearestNaviVC {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self findTopNavigationControllerFromNodeVC:rootVC];
}

- (UIViewController *_Nonnull)getNearestViewController {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self findTopViewControllerFromNodeVC:rootVC];
}

- (UIViewController *_Nonnull)getNesrestViewController {
    return [self getNearestViewController];
}

#pragma mark - private Methods
- (UINavigationController * _Nullable)findTopNavigationControllerFromNodeVC:(UIViewController *)nodeVC {
    // 先判断有无present页
    if (nodeVC.presentedViewController) {
        // 暂时只考虑一层present页，后期优化遍历vc树。
        UIViewController *presentVC = nodeVC.presentedViewController;
        return [self findTopNavigationControllerFromNodeVC:presentVC];
    } else {            // 无present页
        if ([nodeVC isKindOfClass:[UINavigationController class]]) {
            
            UIViewController *topVC = ((UINavigationController *)nodeVC).topViewController;
            if ([topVC isKindOfClass:[UITabBarController class]]) {
                return [self findTopNavigationControllerFromNodeVC:topVC];
            } else {
                return ((UINavigationController *)nodeVC);
            }
            
        } else if ([nodeVC isKindOfClass:[UITabBarController class]]) {
            UITabBarController *vcTabBar = (UITabBarController *)nodeVC;
            
            if ([vcTabBar.selectedViewController isKindOfClass:[UINavigationController class]]) {
                UINavigationController *nvc = (UINavigationController *)vcTabBar.selectedViewController;
                return [self findTopNavigationControllerFromNodeVC:nvc];
            }
        }
    }
    return nil;
}

- (UIViewController * _Nullable)findTopViewControllerFromNodeVC:(UIViewController *)nodeVC {
    // 判断有无present页
    if (nodeVC.presentedViewController) {
        // present页中可能也有嵌套层级，需要移交下一个节点
        UIViewController *nextNode = nodeVC.presentedViewController;
        return [self findTopViewControllerFromNodeVC:nextNode];
    } else {
        // 根据控制器类型找下一个节点
        if ([nodeVC isKindOfClass:[UINavigationController class]]) {
            // 导航栏控制器下一个节点为 topViewController
            UIViewController *nextNode = ((UINavigationController *)nodeVC).topViewController;
            // 如果导航栏控制器没有子控制器了，则最上层 viewController 即为该导航栏控制器，否则继续寻找下一个节点
            if (nextNode) {
                return [self findTopViewControllerFromNodeVC:nextNode];
            } else {
                return nodeVC;
            }
        } else if ([nodeVC isKindOfClass:[UITabBarController class]]) {
#warning 注意 UITabBarController.selectedViewController 可能返回一个 "More" navigation controller ，该场景若出现则需要兼容测试
            UIViewController *nextNode = ((UITabBarController *)nodeVC).selectedViewController;
            // 如果选项卡控制器没有子控制器了，则最上层 viewController 即为该选项卡控制器，否则继续寻找下一个节点
            if (nextNode) {
                return [self findTopViewControllerFromNodeVC:nextNode];
            } else {
                return nodeVC;
            }
        } else {
            return nodeVC;
        }
    }
}

@end

