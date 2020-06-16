//
//  UIApplication+vcManager.m
//  ease
//  UIApplication的VC管理器分类
//  Created by 戴奕 on 2017/5/19.
//  Copyright © 2017年 jincheng. All rights reserved.
//

#import "UIApplication+ZJVCManager.h"
#import "UIViewController+ZJDismiss.h"

@implementation UIApplication (ZJVCManager)

- (nullable UITabBarController *)ZJ_mainTabBarController {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *vcTabBar = (UITabBarController *)rootVC;
        return vcTabBar;
    }
    return nil;
}

- (void)ZJ_dismissAllPresentVCWithCompletionHandle:(void(^ __nullable)(void))completionHandle {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootVC ZJ_dismissAllPresentVCWithCompletion:completionHandle];
}

- (UINavigationController *_Nullable)ZJ_getNaviVCInMainController {
    UITabBarController *vcTabBar = [self ZJ_mainTabBarController];
    if (!vcTabBar) { return nil; }
    
    if ([vcTabBar.selectedViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nvc = (UINavigationController *)vcTabBar.selectedViewController;
        return nvc;
    } else {
        return nil;
    }
}

- (UINavigationController *_Nullable)ZJ_getNearestNaviVC {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self ZJ_findTopNavigationControllerFromNodeVC:rootVC];
}

- (UIViewController *_Nonnull)ZJ_getNearestViewController {
    UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self ZJ_findTopViewControllerFromNodeVC:rootVC];
}

- (UIViewController *_Nonnull)ZJ_getNesrestViewController {
    return [self ZJ_getNearestViewController];
}

#pragma mark - private Methods
- (UINavigationController * _Nullable)ZJ_findTopNavigationControllerFromNodeVC:(UIViewController *)nodeVC {
    // 先判断有无present页
    if (nodeVC.presentedViewController) {
        // 暂时只考虑一层present页，后期优化遍历vc树。
        UIViewController *presentVC = nodeVC.presentedViewController;
        return [self ZJ_findTopNavigationControllerFromNodeVC:presentVC];
    } else {            // 无present页
        if ([nodeVC isKindOfClass:[UINavigationController class]]) {
            
            UIViewController *topVC = ((UINavigationController *)nodeVC).topViewController;
            if ([topVC isKindOfClass:[UITabBarController class]]) {
                return [self ZJ_findTopNavigationControllerFromNodeVC:topVC];
            } else {
                return ((UINavigationController *)nodeVC);
            }
            
        } else if ([nodeVC isKindOfClass:[UITabBarController class]]) {
            UITabBarController *vcTabBar = (UITabBarController *)nodeVC;
            
            if ([vcTabBar.selectedViewController isKindOfClass:[UINavigationController class]]) {
                UINavigationController *nvc = (UINavigationController *)vcTabBar.selectedViewController;
                return [self ZJ_findTopNavigationControllerFromNodeVC:nvc];
            }
        }
    }
    return nil;
}

- (UIViewController * _Nullable)ZJ_findTopViewControllerFromNodeVC:(UIViewController *)nodeVC {
    // 判断有无present页
    if (nodeVC.presentedViewController) {
        // present页中可能也有嵌套层级，需要移交下一个节点
        UIViewController *nextNode = nodeVC.presentedViewController;
        return [self ZJ_findTopViewControllerFromNodeVC:nextNode];
    } else {
        // 根据控制器类型找下一个节点
        if ([nodeVC isKindOfClass:[UINavigationController class]]) {
            // 导航栏控制器下一个节点为 topViewController
            UIViewController *nextNode = ((UINavigationController *)nodeVC).topViewController;
            // 如果导航栏控制器没有子控制器了，则最上层 viewController 即为该导航栏控制器，否则继续寻找下一个节点
            if (nextNode) {
                return [self ZJ_findTopViewControllerFromNodeVC:nextNode];
            } else {
                return nodeVC;
            }
        } else if ([nodeVC isKindOfClass:[UITabBarController class]]) {
#warning 注意 UITabBarController.selectedViewController 可能返回一个 "More" navigation controller ，该场景若出现则需要兼容测试
            UIViewController *nextNode = ((UITabBarController *)nodeVC).selectedViewController;
            // 如果选项卡控制器没有子控制器了，则最上层 viewController 即为该选项卡控制器，否则继续寻找下一个节点
            if (nextNode) {
                return [self ZJ_findTopViewControllerFromNodeVC:nextNode];
            } else {
                return nodeVC;
            }
        } else {
            return nodeVC;
        }
    }
}

@end

