//
//  DeviceInfo.h
//  bingo_navDemo
//
//  Created by 王鹏 on 2018/7/23.
//  Copyright © 2018年 王鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ZJDeviceInfoPlatform) {
    // 暂时未定义机型
    ZJDeviceInfoPlatformUnknown                = -1,
    // iPhone
    ZJDeviceInfoPlatformiPhone4S              = 10,
    ZJDeviceInfoPlatformiPhone5,
    ZJDeviceInfoPlatformiPhone5C,
    ZJDeviceInfoPlatformiPhone5S,
    ZJDeviceInfoPlatformiPhone6,
    ZJDeviceInfoPlatformiPhone6Plus,
    ZJDeviceInfoPlatformiPhone6S,
    ZJDeviceInfoPlatformiPhone6SPlus,
    ZJDeviceInfoPlatformiPhoneSE,
    ZJDeviceInfoPlatformiPhone7,
    ZJDeviceInfoPlatformiPhone7Plus,
    ZJDeviceInfoPlatformiPhone8,
    ZJDeviceInfoPlatformiPhone8Plus,
    ZJDeviceInfoPlatformiPhoneX,
    ZJDeviceInfoPlatformiPhoneXS,
    ZJDeviceInfoPlatformiPhoneXSMax,
    ZJDeviceInfoPlatformiPhoneXR,
    ZJDeviceInfoPlatformiPhone11,
    ZJDeviceInfoPlatformiPhone11Pro,
    ZJDeviceInfoPlatformiPhone11ProMax,

    ZJDeviceInfoPlatformiPadMini,
    ZJDeviceInfoPlatformiPadMini2,
    ZJDeviceInfoPlatformiPadMini3,
    ZJDeviceInfoPlatformiPadMini4,

    ZJDeviceInfoPlatformiPodTouch  = 500,
    ZJDeviceInfoPlatformiPodTouch2,
    ZJDeviceInfoPlatformiPodTouch3,
    ZJDeviceInfoPlatformiPodTouch4,
    ZJDeviceInfoPlatformiPodTouch5,
    ZJDeviceInfoPlatformiPodTouch6,
    // 模拟器
    ZJDeviceInfoPlatformiPhoneSimulator       = 1000,
};

@interface ZJDeviceInfo : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, assign, readonly) CGFloat screenW;
@property (nonatomic, assign, readonly) CGFloat screenH;

/** 设备机型 */
@property (nonatomic, assign, readonly) ZJDeviceInfoPlatform devicePlatform;

@property (nonatomic, strong, readonly) NSString *systemVersion;

@end
