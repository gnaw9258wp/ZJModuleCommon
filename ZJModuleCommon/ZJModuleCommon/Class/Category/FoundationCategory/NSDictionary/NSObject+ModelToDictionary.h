//
//  NSObject+ModelToDictionary.h
//  bingo
//
//  Created by wp on 2019/2/22.
//  Copyright © 2019年 chinamobile. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ModelToDictionary)
/** 模型转字典 */
- (NSDictionary *)modelToDictionary;
/** 模型转数组 */
- (NSArray *)modelToArray;
@end

NS_ASSUME_NONNULL_END
