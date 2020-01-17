//
//  NSObject+XibView.m
//  JFun
//
//  Created by KeithYang on 16/8/29.
//  Copyright © 2016年 miqu. All rights reserved.
//

#import "NSObject+XibView.h"

@implementation NSObject (XibView)

- (instancetype)getXibInstance{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];;
}

@end
