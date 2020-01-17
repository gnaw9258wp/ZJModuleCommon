//
//  UITextField+LengthLimit.m
//  JFun
//
//  Created by KeithYang on 16/8/5.
//  Copyright © 2016年 miqu. All rights reserved.
//

#import "UITextField+LengthLimit.h"
#import <objc/runtime.h>

static void *limitLengthKey = &limitLengthKey;

@implementation UITextField (LengthLimit)

@dynamic limitLength;

- (void)setLimitLength:(NSNumber *)limitLength{
    objc_setAssociatedObject(self, limitLengthKey, limitLength, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(checkLength:) forControlEvents:UIControlEventAllEditingEvents];
}

- (NSNumber *)limitLength{
    return objc_getAssociatedObject(self, limitLengthKey);
}

- (void)checkLength:(id)sender{
    if (self.text.length > [self.limitLength intValue]) {
        if (!self.markedTextRange || self.markedTextRange.isEmpty) {
            self.text = [self.text substringToIndex:[self.limitLength intValue]];
        }
    }
}

@end
