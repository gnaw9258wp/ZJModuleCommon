//
//  DeviceInfo.m
//  bingo_navDemo
//
//  Created by 王鹏 on 2018/7/23.
//  Copyright © 2018年 王鹏. All rights reserved.
//

#import "ZJDeviceInfo.h"
#import <sys/utsname.h>

@interface ZJDeviceInfo () {
    CGFloat _screenW;
    CGFloat _screenH;
    ZJDeviceInfoPlatform _devicePlatform;
    NSString *_systemVersion;
}

@end

@implementation ZJDeviceInfo

+ (instancetype)shareInstance{
    static ZJDeviceInfo *sharedInstance;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[super allocWithZone:NULL] init];
    });
    return sharedInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self shareInstance];
}

- (id)copy {
    return self;
}

#pragma mark - setter and getter Methods
- (CGFloat)screenH{
    if (_screenH == 0) {
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        if (UIInterfaceOrientationIsPortrait(orientation)) {
            _screenH = [UIScreen mainScreen].bounds.size.height;
        } else if (UIInterfaceOrientationIsLandscape(orientation)) {
            _screenH = [UIScreen mainScreen].bounds.size.width;
        }
    }
    return _screenH;
}

- (CGFloat)screenW {
    if (_screenW == 0) {
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        if (UIInterfaceOrientationIsPortrait(orientation)) {
            _screenW = [UIScreen mainScreen].bounds.size.width;
        } else if (UIInterfaceOrientationIsLandscape(orientation)) {
            _screenW = [UIScreen mainScreen].bounds.size.height;
        }
    }
    return _screenW;
}

- (ZJDeviceInfoPlatform)devicePlatform {
    if (_devicePlatform == 0) {
        
        struct utsname systemInfo;
        uname(&systemInfo);
        NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
        
        if ([platform isEqualToString:@"iPhone4,1"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhone4S;
        } else if ([platform isEqualToString:@"iPhone5,1"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhone5;
        } else if ([platform isEqualToString:@"iPhone5,2"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhone5;
        } else if ([platform isEqualToString:@"iPhone5,3"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhone5C;
        } else if ([platform isEqualToString:@"iPhone5,4"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhone5C;
        } else if ([platform isEqualToString:@"iPhone6,1"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhone5S;
        } else if ([platform isEqualToString:@"iPhone6,2"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhone5S;
        } else if ([platform isEqualToString:@"iPhone7,1"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhone6Plus;
        } else if ([platform isEqualToString:@"iPhone7,2"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhone6;
        } else if ([platform isEqualToString:@"iPhone8,1"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhone6S;
        } else if ([platform isEqualToString:@"iPhone8,2"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhone6SPlus;
        } else if ([platform isEqualToString:@"iPhone8,3"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhoneSE;
        } else if ([platform isEqualToString:@"iPhone8,4"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhoneSE;
        } else if ([platform isEqualToString:@"iPhone9,1"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhone7;
        } else if ([platform isEqualToString:@"iPhone9,2"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhone7Plus;
        } else if ([platform isEqualToString:@"iPhone10,1"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhone8;
        } else if ([platform isEqualToString:@"iPhone10,2"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhone8Plus;
        } else if ([platform isEqualToString:@"iPhone10,3"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhoneX;
        } else if ([platform isEqualToString:@"iPhone10,4"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhone8;
        } else if ([platform isEqualToString:@"iPhone10,5"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhone8Plus;
        } else if ([platform isEqualToString:@"iPhone10,6"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhoneX;
        } else if ([platform isEqualToString:@"iPhone11,2"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhoneXS;
        } else if ([platform isEqualToString:@"iPhone11,4"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhoneXSMax;
        } else if ([platform isEqualToString:@"iPhone11,6"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhoneXSMax;
        } else if ([platform isEqualToString:@"iPhone11,8"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhoneXR;
        } else if ([platform isEqualToString:@"iPhone11,8"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhoneXR;
        } else if ([platform isEqualToString:@"iPhone12.1"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhone11;
        } else if ([platform isEqualToString:@"iPhone12.3"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhone11Pro;
        } else if ([platform isEqualToString:@"iPhone12.5"]) {
            _devicePlatform = ZJDeviceInfoPlatformiPhone11ProMax;
        }else if ([platform isEqualToString:@"iPad2,5"] ||
                  [platform isEqualToString:@"iPad2,6"] ||
                  [platform isEqualToString:@"iPad2,7"])
        {
            _devicePlatform = ZJDeviceInfoPlatformiPadMini;
        }else if ([platform isEqualToString:@"iPad4,4"] ||
                  [platform isEqualToString:@"iPad4,5"] ||
                  [platform isEqualToString:@"iPad4,6"])
        {
            _devicePlatform = ZJDeviceInfoPlatformiPadMini2;
        }else if ([platform isEqualToString:@"iPad4,7"] ||
                  [platform isEqualToString:@"iPad4,8"] ||
                  [platform isEqualToString:@"iPad4,9"])
        {
            _devicePlatform = ZJDeviceInfoPlatformiPadMini3;
        }else if ([platform isEqualToString:@"iPad5,1"] ||
               [platform isEqualToString:@"iPad5,2"])
        {
            _devicePlatform = ZJDeviceInfoPlatformiPadMini4;
        }else if([platform isEqualToString:@"iPod1,1"]){
            _devicePlatform = ZJDeviceInfoPlatformiPodTouch;
        }else if([platform isEqualToString:@"iPod2,1"]){
            _devicePlatform = ZJDeviceInfoPlatformiPodTouch2;
        }else if([platform isEqualToString:@"iPod3,1"]){
            _devicePlatform = ZJDeviceInfoPlatformiPodTouch3;
        }else if([platform isEqualToString:@"iPod4,1"]){
            _devicePlatform = ZJDeviceInfoPlatformiPodTouch4;
        }else if([platform isEqualToString:@"iPod5,1"]){
            _devicePlatform = ZJDeviceInfoPlatformiPodTouch5;
        }else if([platform isEqualToString:@"iPod7,1"]){
            _devicePlatform = ZJDeviceInfoPlatformiPodTouch6;
        }else if ([platform isEqualToString:@"i386"] ||
                  [platform isEqualToString:@"x86_64"])
        {
            _devicePlatform = ZJDeviceInfoPlatformiPhoneSimulator;
        }else {
            _devicePlatform = ZJDeviceInfoPlatformUnknown;
        }
    }
    return _devicePlatform;
}

- (NSString *)systemVersion{
    if (_systemVersion == nil) {
        _systemVersion = [[UIDevice currentDevice] systemVersion];
    }
    return _systemVersion;
}

@end
