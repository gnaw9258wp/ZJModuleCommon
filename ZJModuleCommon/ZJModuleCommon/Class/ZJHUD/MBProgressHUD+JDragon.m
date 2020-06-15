//
//  MBProgressHUD+JDragon.m
//  JDragonHUD
//
//  Created by JDragon on 2017/1/17.
//  Copyright © 2017年 JDragon. All rights reserved.
//

#import "MBProgressHUD+JDragon.h"
#import "UIApplication+vcManager.h"
#import "UIColor+HEX.h"
#import "UIImage+GIF.h"
@implementation MBProgressHUD (JDragon)

+ (MBProgressHUD*)createMBProgressHUDviewWithMessage:(NSString*)message isWindiw:(BOOL)isWindow
{
    return [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow customView:nil];
}

+ (MBProgressHUD*)createMBProgressHUDviewWithMessage:(NSString*)message isWindiw:(BOOL)isWindow customView:(UIView *)customView
{
    if (![[NSThread currentThread]isMainThread]) {
        return nil;
    }
    UIView  *view = nil;
    if (customView) {
        [MBProgressHUD hideHUD:customView];
        view = customView;
    }else{
        [MBProgressHUD hideHUD];
        view = isWindow ? (UIView*)[UIApplication sharedApplication].delegate.window:[self getCurrentUIVC].view;
    }
    if (!view) {
        return nil;
    }

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.label.font =[UIFont systemFontOfSize:15];
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

#pragma mark-------------------- show Tip----------------------------

+ (void)showTipMessageInWindow:(NSString*)message
{
    [self showTipMessage:message isWindow:true timer:1.5];
}
+ (void)showTipMessageInView:(NSString*)message
{
    [self showTipMessage:message isWindow:false timer:1.5];
}
+ (void)showTipMessageInWindow:(NSString*)message timer:(int)aTimer
{
    [self showTipMessage:message isWindow:true timer:aTimer];
}
+ (void)showTipMessageInView:(NSString*)message timer:(int)aTimer
{
    [self showTipMessage:message isWindow:false timer:aTimer];
}
+ (void)showTipMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(int)aTimer
{
    MBProgressHUD *hud = [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
    if (hud == nil) {
        return ;
    }
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:aTimer];
}
#pragma mark-------------------- show Activity----------------------------

+ (void)showActivityMessageInWindow:(NSString*)message
{
    [self showActivityMessage:message isWindow:true customView:nil timer:0];
}
+ (void)showActivityMessageInView:(NSString*)message
{
    [self showActivityMessage:message isWindow:false customView:nil timer:0];
}
+ (void)showActivityMessageInWindow:(NSString*)message timer:(int)aTimer
{
    [self showActivityMessage:message isWindow:true customView:nil timer:aTimer];
}
+ (void)showActivityMessageInView:(NSString*)message timer:(int)aTimer
{
    [self showActivityMessage:message isWindow:false customView:nil timer:aTimer];
}
+ (void)showActivityMessageInCustomView:(UIView *)view Message:(NSString *)message{
    [self showActivityMessage:message isWindow:false customView:view timer:0];
}
+ (void)showActivityMessageInCustomView:(UIView *)view Message:(NSString *)message timer:(int)aTimer{
    [self showActivityMessage:message isWindow:false customView:view timer:0];
}

+ (void)showActivityMessage:(NSString*)message isWindow:(BOOL)isWindow customView:(UIView *)customView timer:(int)aTimer
{
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow customView:customView];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.bezelView.backgroundColor = [UIColor colorWithHexString:@"#f0f5f7" alpha:0.9];

    hud.label.textColor = [UIColor blackColor];
    hud.label.font = [UIFont systemFontOfSize:14];
    hud.activityIndicatorColor = [UIColor blackColor];
    if (aTimer>0) {
        [hud hideAnimated:YES afterDelay:aTimer];
    }
}
#pragma mark-------------------- show Image----------------------------

+ (void)showSuccessMessage:(NSString *)Message
{
    NSString *name =@"MBProgressHUD+JDragon.bundle/MBProgressHUD/MBHUD_Success";
    [self showCustomIconInWindow:name message:Message];
}
+ (void)showErrorMessage:(NSString *)Message
{
    NSString *name =@"MBProgressHUD+JDragon.bundle/MBProgressHUD/MBHUD_Error";
    [self showCustomIconInWindow:name message:Message];
}
+ (void)showInfoMessage:(NSString *)Message
{
    NSString *name =@"MBProgressHUD+JDragon.bundle/MBProgressHUD/MBHUD_Info";
    [self showCustomIconInWindow:name message:Message];
}
+ (void)showWarnMessage:(NSString *)Message
{
    NSString *name =@"MBProgressHUD+JDragon.bundle/MBProgressHUD/MBHUD_Warn";
    [self showCustomIconInWindow:name message:Message];
}

+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message
{
    [self showCustomIcon:iconName message:message isWindow:true];
    
}
+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message
{
    [self showCustomIcon:iconName message:message isWindow:false];
}
+ (void)showCustomIcon:(NSString *)iconName message:(NSString *)message isWindow:(BOOL)isWindow
{
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    hud.mode = MBProgressHUDModeCustomView;
    [hud hideAnimated:YES afterDelay:2];
}

#pragma mark-------------------- Custom Gif ----------------------------

+ (void)showCustomGifLoadingInWindowMessage:(NSString *)message  iconName:(NSString *)iconName{
    [self showCustomGifLoadingMessage:message isWindow:YES customView:nil timer:0 iconName:iconName];
}

+ (void)showCustomGifLoadingInViewMessage:(NSString *)message  iconName:(NSString *)iconName{
    [self showCustomGifLoadingMessage:message isWindow:NO customView:nil timer:0 iconName:iconName];
}

+ (void)showCustomGifLoadingInWindowMessage:(NSString *)message iconName:(NSString *)iconName timer:(int)aTimer{
    [self showCustomGifLoadingMessage:message isWindow:YES customView:nil timer:aTimer iconName:iconName];
}

+ (void)showCustomGifLoadingInViewMessage:(NSString *)message iconName:(NSString *)iconName timer:(int)aTimer{
    [self showCustomGifLoadingMessage:message isWindow:NO customView:nil timer:aTimer iconName:iconName];
}

+ (void)showCustomGifLoadingMessage:(NSString*)message isWindow:(BOOL)isWindow customView:(UIView *)customView timer:(int)aTimer  iconName:(NSString *)iconName
{
    MBProgressHUD *hud  =  [self createMBProgressHUDviewWithMessage:message isWindiw:isWindow customView:customView];
    hud.mode = MBProgressHUDModeCustomView;
    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]]pathForResource:iconName ofType:@"gif"];
    NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage sd_imageWithGIFData:imageData];
    UIImageView* mainImageView= [[UIImageView alloc] initWithImage:image];
    mainImageView.frame = CGRectMake(0, 0, 160/2, 128/2);
    mainImageView.backgroundColor = [UIColor clearColor];
    hud.customView = mainImageView;
    hud.animationType = MBProgressHUDAnimationFade;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor clearColor];
    if (aTimer>0) {
        [hud hideAnimated:YES afterDelay:aTimer];
    }
}

+ (void)showCustomGifLoadingInCustomView:(UIView *)view Message:(NSString *)message  iconName:(NSString *)iconName{
    [self showCustomGifLoadingMessage:message isWindow:NO customView:view timer:0 iconName:iconName];
}

+ (void)showCustomGifLoadingInCustomView:(UIView *)view Message:(NSString *)message iconName:(NSString *)iconName timer:(int)aTimer{
    [self showCustomGifLoadingMessage:message isWindow:NO customView:view timer:aTimer iconName:iconName];
}

+ (void)hideHUD:(UIView *)view
{
    if (![[NSThread currentThread]isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideHUDForView:view animated:YES];
        });
    }else{
        [self hideHUDForView:view animated:YES];
    }
}

+ (void)hideHUD
{
    if (![[NSThread currentThread]isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hide];
        });
    }else{
        [self hide];
    }
}

+(void)hide{
    UIView  *winView =(UIView*)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:winView animated:YES];
    [self hideHUDForView:[[UIApplication sharedApplication] getNearestViewController].view animated:YES];
}

#pragma mark --- 获取当前Window试图---------
//获取当前屏幕显示的viewcontroller
+(UIViewController*)getCurrentWindowVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到它
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    id nextResponder = nil;
    UIViewController *appRootVC = window.rootViewController;
    //1、通过present弹出VC，appRootVC.presentedViewController不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        //2、通过navigationcontroller弹出VC
        //        NSLog(@"subviews == %@",[window subviews]);
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    return nextResponder;
}

+(UINavigationController*)getCurrentNaVC
{
    
    UIViewController  *viewVC = (UIViewController*)[ self getCurrentWindowVC ];
    UINavigationController  *naVC;
    if ([viewVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController  *tabbar = (UITabBarController*)viewVC;
        naVC = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        if (naVC.presentedViewController) {
            while (naVC.presentedViewController) {
                naVC = (UINavigationController*)naVC.presentedViewController;
            }
        }
    }else
        if ([viewVC isKindOfClass:[UINavigationController class]]) {
            
            naVC  = (UINavigationController*)viewVC;
            if (naVC.presentedViewController) {
                while (naVC.presentedViewController) {
                    naVC = (UINavigationController*)naVC.presentedViewController;
                }
            }
        }else
            if ([viewVC isKindOfClass:[UIViewController class]])
            {
                if (viewVC.navigationController) {
                    return viewVC.navigationController;
                }
                return  (UINavigationController*)viewVC;
            }
    return naVC;
}

+(UIViewController*)getCurrentUIVC
{
    UIViewController   *cc;
    id  na = [[UIApplication sharedApplication] getNearestViewController];
    if ([na isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = na;
        cc =  nav.viewControllers.lastObject;
        
        if (cc.childViewControllers.count>0) {
            
            cc = [[self class] getSubUIVCWithVC:cc];
        }
    }else
    {
        cc = (UIViewController*)na;
    }
    return cc;
}
+(UIViewController *)getSubUIVCWithVC:(UIViewController*)vc
{
    UIViewController   *cc;
    cc =  vc.childViewControllers.lastObject;
    if (cc.childViewControllers>0) {
        
        [[self class] getSubUIVCWithVC:cc];
    }else
    {
        return cc;
    }
    return cc;
}

@end
