//
//  UITableView+TCYAdaptor.m
//  iOS适配
//
//  Created by 王鹏 on 2017/12/29.
//  Copyright © 2017年 王鹏. All rights reserved.
//

#import "UITableView+TCYAdaptor.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>
static NSString *nameWithTcyAdjustedContentInsetDidChange = @"nameWithTcyAdjustedContentInsetDidChange";

@implementation UITableView (TCYAdaptor)
- (instancetype)categoryInitWithFrame:(CGRect)frame style:(UITableViewStyle)style
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

- (void)fixAdaptor
{
    if (@available(iOS 11.0, *))
    {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
}

- (void)fixFrameToLayoutGuide
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
- (tcyAdjustedContentInsetDidChange)tcyAdjustedContentInsetDidChangeBlock
{
    return objc_getAssociatedObject(self, &nameWithTcyAdjustedContentInsetDidChange);
}

#pragma mark --setter
- (void)setTcyAdjustedContentInsetDidChangeBlock:(tcyAdjustedContentInsetDidChange)tcyAdjustedContentInsetDidChangeBlock
{
    objc_setAssociatedObject(self, &nameWithTcyAdjustedContentInsetDidChange, tcyAdjustedContentInsetDidChangeBlock, OBJC_ASSOCIATION_COPY);
    
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    NSLog(@"%@",newSuperview);
}
#pragma mark --delegate
- (void)adjustedContentInsetDidChange
{
    [super adjustedContentInsetDidChange];
    if (self.tcyAdjustedContentInsetDidChangeBlock)
    {
        self.tcyAdjustedContentInsetDidChangeBlock(self.adjustedContentInset);
    }
}
@end
