//
//  ZJEnvironmentManager.m
//  ZJModuleCommon
//
//  Created by wp on 2020/1/16.
//  Copyright © 2020 wp. All rights reserved.
//

#import "ZJEnvironmentManager.h"

static ZJEnvironmentManager* instance = nil;

@interface ZJEnvironmentManager ()

@end

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
        address = self.addressModel.releaseAddress;
    }else if (self.environmentType == EnvironmentTypeTesting)
    {
        address = self.addressModel.testAddress;
    }else if (self.environmentType == EnvironmentTypeGrayScale)
    {
        address = self.addressModel.grayScaleAddress;
    }else if (self.environmentType == EnvironmentTypeCustom)
    {
        address = self.addressModel.customAddress;
    }
    return address;
}

@end


@implementation ZJEnvironmentRequestBaseAddress

@end
