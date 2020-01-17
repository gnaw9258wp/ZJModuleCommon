//
//  ZJEnvironmentManager.h
//  ZJModuleCommon
//
//  Created by wp on 2020/1/16.
//  Copyright © 2020 wp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, EnvironmentType) {
    EnvironmentTypeRelease                   = 0,
    EnvironmentTypeTesting                   = 1
};

@interface ZJEnvironmentManager : NSObject
+ (ZJEnvironmentManager *)shareInstance;
@property (nonatomic,assign)EnvironmentType environmentType;

- (void)setEnvironmentType:(EnvironmentType)environmentType;

//获取请求服务器地址
- (NSString *)getRequestServerAddress;

@end

