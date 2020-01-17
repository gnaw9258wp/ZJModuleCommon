//
//  DeviceInfo.h
//  bingo_navDemo
//
//  Created by 王鹏 on 2018/7/23.
//  Copyright © 2018年 王鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, DeviceInfoPlatform) {
    // 暂时未定义机型
    DeviceInfoPlatformUnknown                = -1,
    // iPhone
    DeviceInfoPlatformiPhone4S              = 10,
    DeviceInfoPlatformiPhone5,
    DeviceInfoPlatformiPhone5C,
    DeviceInfoPlatformiPhone5S,
    DeviceInfoPlatformiPhone6,
    DeviceInfoPlatformiPhone6Plus,
    DeviceInfoPlatformiPhone6S,
    DeviceInfoPlatformiPhone6SPlus,
    DeviceInfoPlatformiPhoneSE,
    DeviceInfoPlatformiPhone7,
    DeviceInfoPlatformiPhone7Plus,
    DeviceInfoPlatformiPhone8,
    DeviceInfoPlatformiPhone8Plus,
    DeviceInfoPlatformiPhoneX,
    DeviceInfoPlatformiPhoneXS,
    DeviceInfoPlatformiPhoneXSMax,
    DeviceInfoPlatformiPhoneXR,
    DeviceInfoPlatformiPhone11,
    DeviceInfoPlatformiPhone11Pro,
    DeviceInfoPlatformiPhone11ProMax,

    DeviceInfoPlatformiPadMini,
    DeviceInfoPlatformiPadMini2,
    DeviceInfoPlatformiPadMini3,
    DeviceInfoPlatformiPadMini4,

    DeviceInfoPlatformiPodTouch  = 500,
    DeviceInfoPlatformiPodTouch2,
    DeviceInfoPlatformiPodTouch3,
    DeviceInfoPlatformiPodTouch4,
    DeviceInfoPlatformiPodTouch5,
    DeviceInfoPlatformiPodTouch6,
    // 模拟器
    DeviceInfoPlatformiPhoneSimulator       = 1000,
};

@interface DeviceInfo : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, assign, readonly) CGFloat screenW;
@property (nonatomic, assign, readonly) CGFloat screenH;

/** 设备机型 */
@property (nonatomic, assign, readonly) DeviceInfoPlatform devicePlatform;

@property (nonatomic, strong, readonly) NSString *systemVersion;

@end
