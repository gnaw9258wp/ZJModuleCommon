//
//  MBProgressHUD+JDragon.h
//  JDragonHUD
//
//  Created by JDragon on 2017/1/17.
//  Copyright © 2017年 JDragon. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (ZJagon)

+ (void)ZJ_showTipMessageInWindow:(NSString*)message;
+ (void)ZJ_showTipMessageInView:(NSString*)message;
+ (void)ZJ_showTipMessageInWindow:(NSString*)message timer:(int)aTimer;
+ (void)ZJ_showTipMessageInView:(NSString*)message timer:(int)aTimer;


+ (void)ZJ_showActivityMessageInWindow:(NSString*)message;
+ (void)ZJ_showActivityMessageInView:(NSString*)message;
+ (void)ZJ_showActivityMessageInWindow:(NSString*)message timer:(int)aTimer;
+ (void)ZJ_showActivityMessageInView:(NSString*)message timer:(int)aTimer;

+ (void)ZJ_showActivityMessageInCustomView:(UIView *)view Message:(NSString *)message;
+ (void)ZJ_showActivityMessageInCustomView:(UIView *)view Message:(NSString *)message timer:(int)aTimer;

+ (void)ZJ_showSuccessMessage:(NSString *)Message;
+ (void)ZJ_showErrorMessage:(NSString *)Message;
+ (void)ZJ_showInfoMessage:(NSString *)Message;
+ (void)ZJ_showWarnMessage:(NSString *)Message;

+ (void)ZJ_showCustomIconInWindow:(NSString *)iconName message:(NSString *)message;
+ (void)ZJ_showCustomIconInView:(NSString *)iconName message:(NSString *)message;


+ (void)ZJ_showCustomGifLoadingInWindowMessage:(NSString *)message  iconName:(NSString *)iconName;
+ (void)ZJ_showCustomGifLoadingInViewMessage:(NSString *)message  iconName:(NSString *)iconName;

+ (void)ZJ_showCustomGifLoadingInWindowMessage:(NSString *)message iconName:(NSString *)iconName timer:(int)aTimer;
+ (void)ZJ_showCustomGifLoadingInViewMessage:(NSString *)message iconName:(NSString *)iconName timer:(int)aTimer;


+ (void)ZJ_showCustomGifLoadingInCustomView:(UIView *)view Message:(NSString *)message  iconName:(NSString *)iconName;
+ (void)ZJ_showCustomGifLoadingInCustomView:(UIView *)view Message:(NSString *)message iconName:(NSString *)iconName timer:(int)aTimer;


+ (void)ZJ_hideHUD;
+ (void)ZJ_hideHUD:(UIView *)view;
@end
