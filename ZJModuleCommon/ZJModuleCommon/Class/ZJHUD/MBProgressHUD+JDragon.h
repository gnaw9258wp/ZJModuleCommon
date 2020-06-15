//
//  MBProgressHUD+JDragon.h
//  JDragonHUD
//
//  Created by JDragon on 2017/1/17.
//  Copyright © 2017年 JDragon. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (JDragon)

+ (void)showTipMessageInWindow:(NSString*)message;
+ (void)showTipMessageInView:(NSString*)message;
+ (void)showTipMessageInWindow:(NSString*)message timer:(int)aTimer;
+ (void)showTipMessageInView:(NSString*)message timer:(int)aTimer;


+ (void)showActivityMessageInWindow:(NSString*)message;
+ (void)showActivityMessageInView:(NSString*)message;
+ (void)showActivityMessageInWindow:(NSString*)message timer:(int)aTimer;
+ (void)showActivityMessageInView:(NSString*)message timer:(int)aTimer;

+ (void)showActivityMessageInCustomView:(UIView *)view Message:(NSString *)message;
+ (void)showActivityMessageInCustomView:(UIView *)view Message:(NSString *)message timer:(int)aTimer;

+ (void)showSuccessMessage:(NSString *)Message;
+ (void)showErrorMessage:(NSString *)Message;
+ (void)showInfoMessage:(NSString *)Message;
+ (void)showWarnMessage:(NSString *)Message;

+ (void)showCustomIconInWindow:(NSString *)iconName message:(NSString *)message;
+ (void)showCustomIconInView:(NSString *)iconName message:(NSString *)message;


+ (void)showCustomGifLoadingInWindowMessage:(NSString *)message  iconName:(NSString *)iconName;
+ (void)showCustomGifLoadingInViewMessage:(NSString *)message  iconName:(NSString *)iconName;

+ (void)showCustomGifLoadingInWindowMessage:(NSString *)message iconName:(NSString *)iconName timer:(int)aTimer;
+ (void)showCustomGifLoadingInViewMessage:(NSString *)message iconName:(NSString *)iconName timer:(int)aTimer;


+ (void)showCustomGifLoadingInCustomView:(UIView *)view Message:(NSString *)message  iconName:(NSString *)iconName;
+ (void)showCustomGifLoadingInCustomView:(UIView *)view Message:(NSString *)message iconName:(NSString *)iconName timer:(int)aTimer;


+ (void)hideHUD;
+ (void)hideHUD:(UIView *)view;
@end
