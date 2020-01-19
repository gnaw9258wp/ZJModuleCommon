//
//  ZJSetAuthManager.h
//  zjcmcc
//
//  Created by wp on 2019/4/4.
//  Copyright © 2019年 sjyyt. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  请求的权限
 */
typedef NS_ENUM(NSUInteger, ZJAuthType) {
    /**
     *  照片
     */
    ZJAuthTypePhotoLibrary = 0,
    /**
     *  相机
     */
    ZJAuthTypeCamera,
    /**
     *  位置
     */
    ZJAuthTypeLocation,
    /**
     *  录音
     */
    ZJAuthTypeRecord,
};

typedef void(^AuthTypeBlock)(ZJAuthType type,BOOL success);

@interface ZJSetAuthManager : NSObject

- (BOOL)reqestAuthType:(ZJAuthType)authType withAuthorizedBlock:(AuthTypeBlock)block;

+ (instancetype)sharedManager;

@end

NS_ASSUME_NONNULL_END
