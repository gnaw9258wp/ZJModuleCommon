//
//  UIViewController+Dismiss.m
//  ease
//
//  Created by wp on 2017/5/19.
//  Copyright © 2017年 jincheng. All rights reserved.
//

#import "UIViewController+ZJDismiss.h"

@implementation UIViewController (ZJDismiss)

- (void)ZJ_dismissAllPresentVCWithCompletion:(void(^)(void))completion {
    if (self.presentedViewController != nil) {
        if (self.presentedViewController.isBeingDismissed) {
            if (completion) {
                completion();
            }
        } else {
            [self.presentedViewController dismissViewControllerAnimated:NO completion:^{
                [self ZJ_dismissAllPresentVCWithCompletion:completion];
            }];
            
        }
    } else {
        if (completion) {
            completion();
        }
    }
}


@end
