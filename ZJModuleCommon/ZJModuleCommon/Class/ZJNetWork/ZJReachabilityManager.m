//
//  ZJReachabilityManager.m
//  ZJModuleCommon
//
//  Created by wp on 2020/1/17.
//  Copyright © 2020 wp. All rights reserved.
//

#import "ZJReachabilityManager.h"

@interface ZJReachabilityManager ()

@property (nonatomic, strong) Reachability *networkFlag;

@end

@implementation ZJReachabilityManager

+ (instancetype)instance{
    static ZJReachabilityManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self instance];
}

- (id)copy {
    return self;
}

#pragma mark - Public

- (void)spying {
    self.networkFlag = [Reachability reachabilityForInternetConnection];
    [self.networkFlag startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_privateReachabilityObserver) name:kReachabilityChangedNotification object:nil];
}

- (void)stop {
    [self.networkFlag stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
}

- (NetworkStatus)currentStatus {
    return [self.networkFlag currentReachabilityStatus];
}

#pragma mark - Private Listen

- (void)_privateReachabilityObserver {
    NetworkStatus currentStatus = [self.networkFlag currentReachabilityStatus];
    if (_delegate && [_delegate respondsToSelector:@selector(reachabilityManager:reachedStatus:)]) {
        [_delegate reachabilityManager:self reachedStatus:currentStatus];
    }
}
@end
