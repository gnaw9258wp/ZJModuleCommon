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
@interface UIViewController (ZJNavigationViewController)

/**
 控制器可通过实现该方法来指定导航栏是否隐藏
 
 @return 导航栏是否隐藏。默认为 NO
 */
- (BOOL)ZJ_prefresHiddenNavigationBar;

/**
 指定控制器在导航栏栈中上一个返回的页面
 
 @return 上一个返回的控制器，默认为导航栏栈中上一个控制器
 */
- (nullable __kindof UIViewController *)ZJ_previousViewController;

/**
 控制器可以实现该方法自定义点击返回按钮时的逻辑。默认实现为空
 */
- (void)ZJ_backButtonAction;

/**
 控制器可以实现该方法自定义返回按钮
 
 @return 返回按钮item。默认返回 nil
 */
- (NSArray<UIBarButtonItem *> *)ZJ_backBarButtonItems;


/**
 控制器是否显示返回按钮
 @return YES显示 
 */
- (BOOL)ZJ_showBackButtonItem;

/**
 右滑返回手势是否可用
 
 @return 是否可用。默认为 YES
 */
- (BOOL)ZJ_interactivePopGestureEnabled;

- (id<UIViewControllerAnimatedTransitioning>)ZJ_pushAnimation;

- (id<UIViewControllerAnimatedTransitioning>)ZJ_popAnimation;


/**
 安全高度 0 ~ nav 底部
 */
- (CGFloat)safeAreaHeight;

- (NSDictionary<NSAttributedStringKey, id> *)ZJ_titleTextAttributes;

/**
 这个方法本来是用来改变导航栏下面那根线的，暂时还是有bug，别用...改天没有bug再用
 
 @return 导航栏下方分割线颜色
 */
- (UIColor *)ZJ_lineColor;

/**
 这个方法是在界面将要消失时候调用的方法，用以补充在dealloc时间太慢的切点
 */
- (void)ZJ_preDeallocInNav;


/**
 导航条样式
 */
- (NavType )ZJ_navType;

/**
 电池条样式
 */
- (UIStatusBarStyle)ZJ_StatusBarStyle;


/**
 强制展示返回按钮 一般用在presentViewController中
 */
- (BOOL)ZJ_forceShowBackButtonItem;
@end

NS_ASSUME_NONNULL_END
