//
//  UIViewController+TCYAdaptor.m
//  bingo
//
//  Created by wp on 2019/3/12.
//  Copyright © 2019年 chinamobile. All rights reserved.
//

#import "UIViewController+TCYAdaptor.h"

@implementation UIViewController (TCYAdaptor)
//修改iOS下属性
- (void)fixAdaptor{
    if (@available(iOS 11.0, *) == NO) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
@end
