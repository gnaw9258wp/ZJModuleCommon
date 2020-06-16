//
//  UIViewController+TCYAdaptor.m
//  bingo
//
//  Created by wp on 2019/3/12.
//  Copyright © 2019年 chinamobile. All rights reserved.
//

#import "UIViewController+ZJAdaptor.h"

@implementation UIViewController (ZJAdaptor)
//修改iOS下属性
- (void)ZJ_fixAdaptor{
    if (@available(iOS 11.0, *) == NO) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
@end
