//
//  UIView+Convert.m
//  JFun
//
//  Created by KID on 16/1/26.
//  Copyright © 2016年 miqu. All rights reserved.
//

#import "UIView+Convert.h"

@implementation UIView (Convert)

- (UIImage *)convertImage
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
