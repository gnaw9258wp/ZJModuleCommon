//
//  ZJSetAuthManager.m
//  zjcmcc
//
//  Created by wp on 2019/4/4.
//  Copyright © 2019年 sjyyt. All rights reserved.
//

#import "ZJSetAuthManager.h"
#import <CoreLocation/CoreLocation.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "ZJModuleDefine.h"
#import <UIKit/UIKit.h>
#define iOS8  ([[UIDevice currentDevice].systemVersion doubleValue] >= 8)

static ZJSetAuthManager *instance;

@interface ZJSetAuthManager ()<UIAlertViewDelegate>
@property (nonatomic,copy)AuthTypeBlock typeBlock;
@property (nonatomic,assign)ZJAuthType authType;
@end

@implementation ZJSetAuthManager
+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZJSetAuthManager alloc]init];
    });
    return instance;
}

- (BOOL)reqestAuthType:(ZJAuthType)authType withAuthorizedBlock:(AuthTypeBlock)block{
    __weak typeof(self) weakSelf = self;
    self.typeBlock = nil;
    self.typeBlock = block;
    self.authType = authType;
    switch (authType) {
        case ZJAuthTypePhotoLibrary:
        {
            if (NSClassFromString(@"PHAsset")) {
                PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
                if (status == PHAuthorizationStatusNotDetermined) {
                    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                        if (status == PHAuthorizationStatusAuthorized) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                if (weakSelf.typeBlock) {
                                    weakSelf.typeBlock(authType,YES);
                                }
                            });
                        }
                    }];
                } else if (status == PHAuthorizationStatusAuthorized) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (weakSelf.typeBlock) {
                            weakSelf.typeBlock(authType,YES);
                        }
                    });

                } else if (status == PHAuthorizationStatusDenied || status == ALAuthorizationStatusRestricted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"相册权限未开启,请到[设置]中对“%@”授权",ZJAPPName] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
                        alert.tag = 100;
                        [alert show];
                    });
                }
            }else{
                ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
                if (status == ALAuthorizationStatusAuthorized) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (weakSelf.typeBlock) {
                            weakSelf.typeBlock(authType,YES);
                        }
                    });
                } else if (status == ALAuthorizationStatusDenied || status == ALAuthorizationStatusRestricted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"相册权限未开启,请到[设置]中对“%@”授权",ZJAPPName] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
                        alert.tag = 100;
                        [alert show];
                    });
                }
            }
        }
            break;
        case ZJAuthTypeCamera:
        {
            NSString *mediaType = AVMediaTypeVideo;
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"相机权限未开启,请到[设置]中对“%@”授权",ZJAPPName] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
                    alert.tag = 101;
                    [alert show];
                });
            }else if (authStatus == AVAuthorizationStatusNotDetermined){
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted == YES)
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (weakSelf.typeBlock) {
                                weakSelf.typeBlock(authType,YES);
                            }
                        });
                    }else
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"相机权限未开启,请到[设置]中对“%@”授权",ZJAPPName] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
                            alert.tag = 101;
                            [alert show];
                        });
                    }
                }];
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (weakSelf.typeBlock) {
                        weakSelf.typeBlock(authType,YES);
                    }
                });
            }
        }
            break;
        case ZJAuthTypeLocation:
        {
            if (![CLLocationManager locationServicesEnabled]) {//定位功能没有开

                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"定位服务未开启" message:[NSString stringWithFormat:@"定位服务未开启，请进入系统【设置】>【隐私】>【定位服务】中打开开关，并允许%@使用定位服务",ZJAPPName] delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                    [alert show];
                });
                
            }else{//定位功能已经开启
                if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted)
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                       UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"定位服务未开启" message:[NSString stringWithFormat:@"定位服务未开启，请进入系统【设置】>【隐私】>【定位服务】中打开开关，并允许%@使用定位服务",ZJAPPName] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
                       alert.tag = 102;
                       [alert show];
                    });

                }else{
                    
                    if (([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusNotDetermined||[CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)|| [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {//必须要明确用户已经同意了，用户没有来的及进行定位的话，先给他系统弹框弹出来
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (weakSelf.typeBlock) {
                                weakSelf.typeBlock(authType,YES);
                            }
                        });
                    }
                }
            }
        }
            break;
        case ZJAuthTypeRecord:
        {
            AVAudioSessionRecordPermission permissionStatus = [[AVAudioSession sharedInstance] recordPermission];
            switch (permissionStatus) {
                case AVAudioSessionRecordPermissionUndetermined:{
                    [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                        if (granted == YES)
                        {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                if (weakSelf.typeBlock) {
                                    weakSelf.typeBlock(authType,YES);
                                }
                            });
                        }else
                        {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"麦克风权限未开启,请到[设置]中对“%@”授权",ZJAPPName] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
                                alert.tag = 103;
                                [alert show];
                            });
                        }
                    }];
                    break;
                }
                case AVAudioSessionRecordPermissionDenied: {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:[NSString stringWithFormat:@"麦克风权限未开启,请到[设置]中对“%@”授权",ZJAPPName] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
                        alert.tag = 103;
                        [alert show];
                    });
                }
                    break;
                case AVAudioSessionRecordPermissionGranted: {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (weakSelf.typeBlock) {
                            weakSelf.typeBlock(authType,YES);
                        }
                    });
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if (self.typeBlock) {
            self.typeBlock(self.authType, NO);
        }
        return;
    }
    if (alertView.tag == 100 || alertView.tag == 101 || alertView.tag == 102 || alertView.tag == 103)
    {
        if (iOS8) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }
}
@end
