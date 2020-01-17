//
//  UIViewController+interfaceOrientation.m
//  bingo
//
//  Created by 王鹏 on 2018/12/4.
//  Copyright © 2018 chinamobile. All rights reserved.
//

#import "UIViewController+interfaceOrientation.h"

@implementation UIViewController (interfaceOrientation)
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    UIInterfaceOrientation orientation1 = [UIApplication sharedApplication].statusBarOrientation;

    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}
@end
