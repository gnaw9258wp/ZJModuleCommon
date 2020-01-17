//
//  ZJEnvironmentManager.m
//  ZJModuleCommon
//
//  Created by wp on 2020/1/16.
//  Copyright © 2020 wp. All rights reserved.
//

#import "ZJEnvironmentManager.h"

static ZJEnvironmentManager* instance = nil;

@implementation ZJEnvironmentManager

+ (ZJEnvironmentManager *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc]init];
    });
    return instance;
}

- (NSString *)getRequestServerAddress
{
    NSString *address = @"";
    if (self.environmentType == EnvironmentTypeRelease)
    {
        address = @"https://imoa.gmcc.net:8081/gmccservice/";
    }else if (self.environmentType == EnvironmentTypeTesting)
    {
        address = @"http://211.136.253.217:18088/gmccservice/";
    }
    return address;
}
@end
