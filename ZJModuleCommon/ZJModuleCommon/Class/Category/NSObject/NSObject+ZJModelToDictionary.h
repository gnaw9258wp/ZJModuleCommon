//
//  NSObject+ZJModelToDictionary.h
//  ZJModuleCommon
//
//  Created by wp on 2020/6/16.
//  Copyright © 2020 wp. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSObject (ZJModelToDictionary)
/** 模型转字典 */
- (NSDictionary *)ZJ_modelToDictionary;
/** 模型转数组 */
- (NSArray *)ZJ_modelToArray;
@end

