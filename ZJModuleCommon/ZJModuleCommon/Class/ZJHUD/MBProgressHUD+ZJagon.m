//
//  MBProgressHUD+ZJagonn.m
//  ZJagonnHUD
//
//  Created by ZJagonn on 2017/1/17.
//  Copyright © 2017年 ZJagonn. All rights reserved.
//

#import "MBProgressHUD+ZJagon.h"
#import "UIApplication+ZJVCManager.h"
#import "UIColor+ZJHEX.h"
#import "UIImage+GIF.h"
@implementation MBProgressHUD (ZJagon)

+ (MBProgressHUD*)ZJ_createMBProgressHUDviewWithMessage:(NSString*)message isWindiw:(BOOL)isWindow
{
    return [self ZJ_createMBProgressHUDviewWithMessage:message isWindiw:isWindow customView:nil];
}

+ (MBProgressHUD*)ZJ_createMBProgressHUDviewWithMessage:(NSString*)message isWindiw:(BOOL)isWindow customView:(UIView *)customView
{
    if (![[NSThread currentThread]isMainThread]) {
        return nil;
    }
    UIView  *view = nil;
    if (customView) {
        [MBProgressHUD ZJ_hideHUD:customView];
        view = customView;
    }else{
        [MBProgressHUD ZJ_hideHUD];
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

+ (void)ZJ_showTipMessageInWindow:(NSString*)message
{
    [self ZJ_showTipMessage:message isWindow:true timer:1.5];
}
+ (void)ZJ_showTipMessageInView:(NSString*)message
{
    [self ZJ_showTipMessage:message isWindow:false timer:1.5];
}
+ (void)ZJ_showTipMessageInWindow:(NSString*)message timer:(int)aTimer
{
    [self ZJ_showTipMessage:message isWindow:true timer:aTimer];
}
+ (void)ZJ_showTipMessageInView:(NSString*)message timer:(int)aTimer
{
    [self ZJ_showTipMessage:message isWindow:false timer:aTimer];
}
+ (void)ZJ_showTipMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(int)aTimer
{
    MBProgressHUD *hud = [self ZJ_createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
    if (hud == nil) {
        return ;
    }
    hud.mode = MBProgressHUDModeText;
    [hud hideAnimated:YES afterDelay:aTimer];
}
#pragma mark-------------------- show Activity----------------------------

+ (void)ZJ_showActivityMessageInWindow:(NSString*)message
{
    [self ZJ_showActivityMessage:message isWindow:true customView:nil timer:0];
}
+ (void)ZJ_showActivityMessageInView:(NSString*)message
{
    [self ZJ_showActivityMessage:message isWindow:false customView:nil timer:0];
}
+ (void)ZJ_showActivityMessageInWindow:(NSString*)message timer:(int)aTimer
{
    [self ZJ_showActivityMessage:message isWindow:true customView:nil timer:aTimer];
}
+ (void)ZJ_showActivityMessageInView:(NSString*)message timer:(int)aTimer
{
    [self ZJ_showActivityMessage:message isWindow:false customView:nil timer:aTimer];
}
+ (void)ZJ_showActivityMessageInCustomView:(UIView *)view Message:(NSString *)message{
    [self ZJ_showActivityMessage:message isWindow:false customView:view timer:0];
}
+ (void)ZJ_showActivityMessageInCustomView:(UIView *)view Message:(NSString *)message timer:(int)aTimer{
    [self ZJ_showActivityMessage:message isWindow:false customView:view timer:0];
}

+ (void)ZJ_showActivityMessage:(NSString*)message isWindow:(BOOL)isWindow customView:(UIView *)customView timer:(int)aTimer
{
    MBProgressHUD *hud  =  [self ZJ_createMBProgressHUDviewWithMessage:message isWindiw:isWindow customView:customView];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.bezelView.backgroundColor = [UIColor ZJ_colorWithHexString:@"#f0f5f7" alpha:0.9];
    hud.label.textColor = [UIColor blackColor];
    hud.label.font = [UIFont systemFontOfSize:14];
    hud.activityIndicatorColor = [UIColor blackColor];
    if (aTimer>0) {
        [hud hideAnimated:YES afterDelay:aTimer];
    }
}
#pragma mark-------------------- show Image----------------------------

+ (void)ZJ_showSuccessMessage:(NSString *)Message
{
    NSString *name =@"MBProgressHUD+ZJagonn.bundle/MBProgressHUD/MBHUD_Success";
    [self ZJ_showCustomIconInWindow:name message:Message];
}
+ (void)ZJ_showErrorMessage:(NSString *)Message
{
    NSString *name =@"MBProgressHUD+ZJagonn.bundle/MBProgressHUD/MBHUD_Error";
    [self ZJ_showCustomIconInWindow:name message:Message];
}
+ (void)ZJ_showInfoMessage:(NSString *)Message
{
    NSString *name =@"MBProgressHUD+ZJagonn.bundle/MBProgressHUD/MBHUD_Info";
    [self ZJ_showCustomIconInWindow:name message:Message];
}
+ (void)ZJ_showWarnMessage:(NSString *)Message
{
    NSString *name =@"MBProgressHUD+ZJagonn.bundle/MBProgressHUD/MBHUD_Warn";
    [self ZJ_showCustomIconInWindow:name message:Message];
}

+ (void)ZJ_showCustomIconInWindow:(NSString *)iconName message:(NSString *)message
{
    [self ZJ_showCustomIcon:iconName message:message isWindow:true];
    
}
+ (void)ZJ_showCustomIconInView:(NSString *)iconName message:(NSString *)message
{
    [self ZJ_showCustomIcon:iconName message:message isWindow:false];
}
+ (void)ZJ_showCustomIcon:(NSString *)iconName message:(NSString *)message isWindow:(BOOL)isWindow
{
    MBProgressHUD *hud  =  [self ZJ_createMBProgressHUDviewWithMessage:message isWindiw:isWindow];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
    hud.mode = MBProgressHUDModeCustomView;
    [hud hideAnimated:YES afterDelay:2];
}

#pragma mark-------------------- Custom Gif ----------------------------

+ (void)ZJ_showCustomGifLoadingInWindowMessage:(NSString *)message  iconName:(NSString *)iconName{
    [self ZJ_showCustomGifLoadingMessage:message isWindow:YES customView:nil timer:0 iconName:iconName];
}

+ (void)ZJ_showCustomGifLoadingInViewMessage:(NSString *)message  iconName:(NSString *)iconName{
    [self ZJ_showCustomGifLoadingMessage:message isWindow:NO customView:nil timer:0 iconName:iconName];
}

+ (void)ZJ_showCustomGifLoadingInWindowMessage:(NSString *)message iconName:(NSString *)iconName timer:(int)aTimer{
    [self ZJ_showCustomGifLoadingMessage:message isWindow:YES customView:nil timer:aTimer iconName:iconName];
}

+ (void)ZJ_showCustomGifLoadingInViewMessage:(NSString *)message iconName:(NSString *)iconName timer:(int)aTimer{
    [self ZJ_showCustomGifLoadingMessage:message isWindow:NO customView:nil timer:aTimer iconName:iconName];
}

+ (void)ZJ_showCustomGifLoadingMessage:(NSString*)message isWindow:(BOOL)isWindow customView:(UIView *)customView timer:(int)aTimer  iconName:(NSString *)iconName
{
    MBProgressHUD *hud  =  [self ZJ_createMBProgressHUDviewWithMessage:message isWindiw:isWindow customView:customView];
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

+ (void)ZJ_showCustomGifLoadingInCustomView:(UIView *)view Message:(NSString *)message  iconName:(NSString *)iconName{
    [self ZJ_showCustomGifLoadingMessage:message isWindow:NO customView:view timer:0 iconName:iconName];
}

+ (void)ZJ_showCustomGifLoadingInCustomView:(UIView *)view Message:(NSString *)message iconName:(NSString *)iconName timer:(int)aTimer{
    [self ZJ_showCustomGifLoadingMessage:message isWindow:NO customView:view timer:aTimer iconName:iconName];
}

+ (void)ZJ_hideHUD:(UIView *)view
{
    if (![[NSThread currentThread]isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideHUDForView:view animated:YES];
        });
    }else{
        [self hideHUDForView:view animated:YES];
    }
}

+ (void)ZJ_hideHUD
{
    if (![[NSThread currentThread]isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self ZJ_hide];
        });
    }else{
        [self ZJ_hide];
    }
}

+(void)ZJ_hide{
    UIView  *winView =(UIView*)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:winView animated:YES];
    [self hideHUDForView:[[UIApplication sharedApplication] ZJ_getNearestViewController].view animated:YES];
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
    id  na = [[UIApplication sharedApplication] ZJ_getNearestViewController];
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
