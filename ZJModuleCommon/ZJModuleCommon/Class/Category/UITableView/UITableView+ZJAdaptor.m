//
//  UITableView+TCYAdaptor.m
//  iOS适配
//
//  Created by 王鹏 on 2017/12/29.
//  Copyright © 2017年 王鹏. All rights reserved.
//

#import "UITableView+ZJAdaptor.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

static NSString *nameWithZJAdjustedContentInsetDidChange = @"nameWithZJAdjustedContentInsetDidChange";

@implementation UITableView (ZJAdaptor)
- (instancetype)ZJ_categoryInitWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if ([self initWithFrame:frame style:style])
    {
        if (@available(iOS 11.0, *))
        {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            self.estimatedRowHeight = 0;
            self.estimatedSectionHeaderHeight = 0;
            self.estimatedSectionFooterHeight = 0;
        }
    }
    return self;
}

- (void)ZJ_fixAdaptor
{
    if (@available(iOS 11.0, *))
    {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
}

- (void)ZJ_fixFrameToLayoutGuide
{
    if (!self.superview)
    {
        return;
    }
    if ([self respondsToSelector:@selector(safeAreaLayoutGuide)])
    {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.superview.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.superview.mas_safeAreaLayoutGuideBottom);
            make.left.equalTo(self.superview.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.superview.mas_safeAreaLayoutGuideRight);
        }];
    }else
    {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.equalTo(self.superview.mas_bottom);
        }];
    }

}
#pragma mark -getter
- (ZJAdjustedContentInsetDidChange)zjadjustedContentInsetDidChangeBlock
{
    return objc_getAssociatedObject(self, &nameWithZJAdjustedContentInsetDidChange);
}

#pragma mark --setter

- (void)setZjadjustedContentInsetDidChangeBlock:(ZJAdjustedContentInsetDidChange)zjadjustedContentInsetDidChangeBlock{
    objc_setAssociatedObject(self, &nameWithZJAdjustedContentInsetDidChange, zjadjustedContentInsetDidChangeBlock, OBJC_ASSOCIATION_COPY);

}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    NSLog(@"%@",newSuperview);
}
#pragma mark --delegate
- (void)adjustedContentInsetDidChange
{
    [super adjustedContentInsetDidChange];
    if (self.zjadjustedContentInsetDidChangeBlock)
    {
        self.zjadjustedContentInsetDidChangeBlock(self.adjustedContentInset);
    }
}
@end
