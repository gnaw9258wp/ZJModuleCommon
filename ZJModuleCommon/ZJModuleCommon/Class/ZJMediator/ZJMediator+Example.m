//
//  ZJMediator+Example.m
//  ZJModuleCommon
//
//  Created by wp on 2020/1/21.
//  Copyright © 2020 wp. All rights reserved.
//

#import "ZJMediator+Example.h"

static ZJMedicatorTarget const kZJMediatorTargetZJExample = @"ZJExample";

static ZJMedicatorAction const kZJMediatorActionHomeViewController = @"nativeFetchSecondTabBarController";


@implementation ZJMediator (Example)

- (UITabBarController *)ZJMediator_SecondTabBarViewController:(NSDictionary *)params {
    UITabBarController *vc = [self performTarget:kZJMediatorTargetZJExample action:kZJMediatorActionHomeViewController params:params shouldCacheTarget:YES];
    return vc;
}

@end
