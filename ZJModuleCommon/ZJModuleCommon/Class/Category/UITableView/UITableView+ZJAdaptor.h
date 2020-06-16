//
//  UITableView+TCYAdaptor.h
//  iOS适配
//
//  Created by 王鹏 on 2017/12/29.
//  Copyright © 2017年 王鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ZJAdjustedContentInsetDidChange)(UIEdgeInsets adjustedContentInset);

@interface UITableView (ZJAdaptor)

- (instancetype)ZJ_categoryInitWithFrame:(CGRect)frame style:(UITableViewStyle)style;
/*
 * 当UIScrollViewContentInsetAdjustmentBehavior属性改变的时候可以通过调用此Block来获取到改变
 */
@property (nonatomic, assign)ZJAdjustedContentInsetDidChange zjadjustedContentInsetDidChangeBlock;

//修改iOS下属性
- (void)ZJ_fixAdaptor;

//修改frame让他和父视图一样大
- (void)ZJ_fixFrameToLayoutGuide;
@end
