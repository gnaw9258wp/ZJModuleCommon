//
//  UIViewController+Dismiss.h
//  ease
//
//  Created by wp on 2017/5/19.
//  Copyright © 2017年 jincheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ZJDismiss)

/**
 dismiss掉所有present出来的VC
 
 @param completion 完成回调
 */
- (void)ZJ_dismissAllPresentVCWithCompletion:(void(^)(void))completion;

@end
