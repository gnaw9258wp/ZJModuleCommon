//
//  ZJEnvironmentManager.h
//  ZJModuleCommon
//
//  Created by wp on 2020/1/16.
//  Copyright © 2020 wp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, EnvironmentType) {
    EnvironmentTypeRelease                   = 0,//正式
    EnvironmentTypeTesting                   = 1,//测试
    EnvironmentTypeGrayScale                 = 2,//灰度
    EnvironmentTypeCustom                    = 3,//自定义

};

@interface ZJEnvironmentRequestBaseAddress :NSObject

@property (nonatomic,copy)NSString *releaseAddress;

@property (nonatomic,copy)NSString *testAddress;

@property (nonatomic,copy)NSString *grayScaleAddress;

@property (nonatomic,copy)NSString *customAddress;

@end

@interface ZJEnvironmentManager : NSObject
+ (ZJEnvironmentManager *)shareInstance;

@property (nonatomic,assign)EnvironmentType environmentType;

@property (nonatomic,strong)ZJEnvironmentRequestBaseAddress *addressModel;

- (void)setEnvironmentType:(EnvironmentType)environmentType;

//获取请求服务器地址
- (NSString *)getRequestServerAddress;

@end

