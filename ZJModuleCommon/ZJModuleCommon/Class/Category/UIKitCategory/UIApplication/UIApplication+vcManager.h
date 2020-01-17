//
//  UIApplication+vcManager.h
//  ease
//  UIApplication的VC管理器分类
//  Created by 戴奕 on 2017/5/19.
//  Copyright © 2017年 jincheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (vcManager)

/**
 获取主tabBar控制器
 */
- (nullable UITabBarController *)mainTabBarController;

/**
 取消所有present出来的控制器
 
 @param completionHandle dismiss完成
 */
- (void)dismissAllPresentVCWithCompletionHandle:(void(^ __nullable)(void))completionHandle;

/**
 获取mainVC上的导航栏控制器
 
 @return UINavigationController * 导航栏控制器
 */
- (UINavigationController *_Nullable)getNaviVCInMainController;

/**
 获取当前（屏幕上）最近的导航栏控制器
 
 @return UINavigationController * 导航栏控制器
 */
- (UINavigationController *_Nullable)getNearestNaviVC;

/**
 获取当前（屏幕上）最近的视图控制器

 @return UIViewController * 视图控制器
 */
- (UIViewController *_Nonnull)getNearestViewController;


@end
