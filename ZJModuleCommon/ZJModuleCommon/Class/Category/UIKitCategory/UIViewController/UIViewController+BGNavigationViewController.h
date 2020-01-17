//
//  UIViewController+BGNavigationViewController.h
//  bingo_navDemo
//
//  Created by 王鹏 on 2018/7/23.
//  Copyright © 2018年 王鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, NavType) {
    NavTypeNormal                  = 0, //导航条白色
    NavTypeBlue                    = 1, //导航条自定义的蓝色图片样式
    NavTypeClear                   = 2 //透明
};
@interface UIViewController (BGNavigationViewController)

/**
 控制器可通过实现该方法来指定导航栏是否隐藏
 
 @return 导航栏是否隐藏。默认为 NO
 */
- (BOOL)bg_prefresHiddenNavigationBar;

/**
 指定控制器在导航栏栈中上一个返回的页面
 
 @return 上一个返回的控制器，默认为导航栏栈中上一个控制器
 */
- (nullable __kindof UIViewController *)bg_previousViewController;

/**
 控制器可以实现该方法自定义点击返回按钮时的逻辑。默认实现为空
 */
- (void)bg_backButtonAction;

/**
 控制器可以实现该方法自定义返回按钮
 
 @return 返回按钮item。默认返回 nil
 */
- (NSArray<UIBarButtonItem *> *)bg_backBarButtonItems;


/**
 控制器是否显示返回按钮
 @return YES显示 
 */
- (BOOL)bg_showBackButtonItem;

/**
 右滑返回手势是否可用
 
 @return 是否可用。默认为 YES
 */
- (BOOL)bg_interactivePopGestureEnabled;

- (id<UIViewControllerAnimatedTransitioning>) pushAnimation;

- (id<UIViewControllerAnimatedTransitioning>) popAnimation;


/**
 安全高度 0 ~ nav 底部
 */
- (CGFloat)safeAreaHeight;

- (NSDictionary<NSAttributedStringKey, id> *)bg_titleTextAttributes;

/**
 这个方法本来是用来改变导航栏下面那根线的，暂时还是有bug，别用...改天没有bug再用
 
 @return 导航栏下方分割线颜色
 */
- (UIColor *)bg_lineColor;

/**
 这个方法是在界面将要消失时候调用的方法，用以补充在dealloc时间太慢的切点
 */
- (void)bg_preDeallocInNav;


/**
 导航条样式
 */
- (NavType )bg_navType;

/**
 电池条样式
 */
- (UIStatusBarStyle)bg_StatusBarStyle;


/**
 强制展示返回按钮 一般用在presentViewController中
 */
- (BOOL)bg_forceShowBackButtonItem;
@end

NS_ASSUME_NONNULL_END
