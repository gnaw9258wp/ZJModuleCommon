//
//  ZJModuleDefine.h
//  ZJModuleCommon
//
//  Created by wp on 2020/1/19.
//  Copyright © 2020 wp. All rights reserved.
//

#ifndef ZJModuleDefine
#define ZJModuleDefine


#define ZJScreenWidth [UIScreen mainScreen].bounds.size.width
#define ZJScreenHeight [UIScreen mainScreen].bounds.size.height

//判断是否是ipad
#define ZJIsPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//判断iPhone4系列
#define ZJIPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !ZJIsPad : NO)
//判断iPhone5系列
#define ZJIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !ZJIsPad : NO)
//判断iPhone6 6s 7系列
#define ZJIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !ZJIsPad : NO)
//判断iPhone6p 6sp 7p系列
#define ZJIPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !ZJIsPad : NO)
//判断iPhoneX，Xs（iPhoneX，iPhoneXs）
#define ZJIS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !ZJIsPad : NO)
//判断iPhoneXr
#define ZJIS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !ZJIsPad : NO)
//判断iPhoneXsMax
#define ZJIS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)&& !ZJIsPad : NO)

//判断iPhoneX所有系列
#define ZJIS_PhoneXAll (ZJIS_IPHONE_X || ZJIS_IPHONE_Xr || ZJIS_IPHONE_Xs_Max)
#define ZJ_Height_NavContentBar 44.0f
#define ZJ_Height_StatusBar (ZJIS_PhoneXAll? 44.0 : 20.0)
#define ZJ_Height_NavBar (ZJIS_PhoneXAll ? 88.0 : 64.0)
#define ZJ_Height_TabBar (ZJIS_PhoneXAll ? 83.0 : 49.0)
#define ZJ_Height_Away_TabBar (ZJIS_PhoneXAll ? 34 : 0)

#define ZJScale ZJScreenWidth/375.0

#define ZJStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define ZJNaviHeight (ZJIS_PhoneXAll ? 84.f : 64.f)
#define ZJTopHeight (ZJStatusBarHeight + ZJNaviHeight)

// ------------------------------------ xcode 调试打印 ------------------------------------
#ifdef DEBUG
#define DebugLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#define NSLog(format, ...)                  \
NSLog(@"\n%s [%s  Line:%d]\n%@\n",               \
__PRETTY_FUNCTION__, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__,      \
[NSString stringWithFormat:format, ##__VA_ARGS__]);
#else
#define DebugLog(s, ...)
#define NSLog(format, ...)
#endif


#define ZJWeakObj(o) @autoreleasepool{} __weak typeof(o) o##Weak = o;
#define ZJStrongObj(o) @autoreleasepool{} __strong typeof(o) o = o##Weak;

#define ZJAPPName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

#endif /* ZJModuleDefine.h */
