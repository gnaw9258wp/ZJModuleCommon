//
//  BGOBaseRequest.h
//  YTNetWorkDemo
//
//  Created by wp on 2019/2/21.
//  Copyright © 2019年 wp. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef void (^BGORequestSuccessBlock)(id result);
typedef void(^BGORequestFailBlock)(NSString *message,NSString *statusCode,NSError *error);

#define RequestSuccessStatus @"4000"

#import "YTKBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJBaseRequest : YTKBaseRequest

@property (nonatomic,strong)NSString *action;
@property (nonatomic,strong)NSString *reqId;

- (void)ZJ_StartRequestWithCompletionBlockWithSuccess:(BGORequestSuccessBlock)success failure:(BGORequestFailBlock)failure;

@end

NS_ASSUME_NONNULL_END
