//
//  ZJReachabilityManager.h
//  ZJModuleCommon
//
//  Created by wp on 2020/1/17.
//  Copyright © 2020 wp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Reachability.h"

@class ZJReachabilityManager;

@protocol ZJReachabilityManagerDelegate <NSObject>
@optional
/**
 监听的当前网络状态

 @param manager Manager
 @param status 网络状态
 */
- (void)reachabilityManager:(ZJReachabilityManager *)manager reachedStatus:(NetworkStatus)status;

@end

@interface ZJReachabilityManager : NSObject

@property (nonatomic, weak) id<ZJReachabilityManagerDelegate> delegate;

@property (nonatomic, assign) NetworkStatus currentStatus;

// 生成实例
+ (instancetype)instance;

// 开始监控
- (void)spying;

// 停止监控
- (void)stop;
@end

