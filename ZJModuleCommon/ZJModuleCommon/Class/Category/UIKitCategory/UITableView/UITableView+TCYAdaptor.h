//
//  UITableView+TCYAdaptor.h
//  iOS适配
//
//  Created by 王鹏 on 2017/12/29.
//  Copyright © 2017年 王鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^tcyAdjustedContentInsetDidChange)(UIEdgeInsets adjustedContentInset);

@interface UITableView (TCYAdaptor)

/*
 * 当UIScrollViewContentInsetAdjustmentBehavior属性改变的时候可以通过调用此Block来获取到改变
 */
@property (nonatomic, assign)tcyAdjustedContentInsetDidChange tcyAdjustedContentInsetDidChangeBlock;

//修改iOS下属性
- (void)fixAdaptor;

//修改frame让他和父视图一样大
- (void)fixFrameToLayoutGuide;
@end
