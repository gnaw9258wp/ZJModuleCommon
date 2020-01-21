//
//  ZJMediator.h
//  ZJModuleCommon
//  中间件类基类
//  Created by wp on 2020/1/21.
//  Copyright © 2020 wp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NSString * ZJMedicatorTarget;
typedef NSString * ZJMedicatorAction;

FOUNDATION_EXPORT NSString * const kZJTargetStr;
FOUNDATION_EXPORT NSString * const kZJActionStr;


@interface ZJMediator : NSObject
+ (instancetype)sharedInstance;

// 远程App调用入口
- (id)performActionWithUrl:(NSURL *)url completion:(void(^)(NSDictionary *info))completion;
// 本地组件调用入口
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(id)params shouldCacheTarget:(BOOL)shouldCacheTarget;
- (void)releaseCachedTargetWithTargetName:(NSString *)targetName;

@end

