//
//  NSObject+ModelToDictionary.m
//  bingo
//
//  Created by wp on 2019/2/22.
//  Copyright © 2019年 chinamobile. All rights reserved.
//

#import "NSObject+ModelToDictionary.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@implementation NSObject (ModelToDictionary)
NSString *hexStringFromColor(UIColor *color) {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255)];
}

static id modelToJSONObject(id model) {
    // 保留空类型和nil
    if (!model || model == (id)kCFNull) { return model; }
    // 字符串直接返回
    if ([model isKindOfClass:[NSString class]]) { return model; }
    // NSNumber需要判定 NaN or infinity
    if ([model isKindOfClass:[NSNumber class]]) {
        // NaN判定
        if ([model isEqualToNumber:[NSDecimalNumber notANumber]]) {
            return nil;
        }
        // infinity判定
        BOOL toInfinityAndBeyond = [model isEqual:(NSNumber *)kCFNumberPositiveInfinity];
        if (toInfinityAndBeyond) {
            return nil;
        }
        return model;
    }
    // URL转为string类型URL
    if ([model isKindOfClass:[NSURL class]]) {
        return ((NSURL *)model).absoluteString;
    }
    // 富文本转为string
    if ([model isKindOfClass:[NSAttributedString class]]) {
        return ((NSAttributedString *)model).string;
    }
    // 日期转为时间戳
    if ([model isKindOfClass:[NSDate class]]) {
        return [NSString stringWithFormat:@"%lf", ((NSDate *)model).timeIntervalSince1970];
    }
    // 二进制数据转为string类型
    if ([model isKindOfClass:[NSData class]]) {
        NSString *dataString = ((NSData *)model).description;
        dataString = [dataString stringByReplacingOccurrencesOfString:@"<" withString:@""];
        dataString = [dataString stringByReplacingOccurrencesOfString:@">" withString:@""];
        dataString = [dataString stringByReplacingOccurrencesOfString:@" " withString:@""];
        return dataString;
    }
    // UIColor转为#777777格式
    if ([model isKindOfClass:[UIColor class]]) {
        return hexStringFromColor((UIColor *)model);
    }
    // 字典，对每个value进行处理后加入
    if ([model isKindOfClass:[NSDictionary class]]) {
        if ([NSJSONSerialization isValidJSONObject:model]) { return model; }
        NSDictionary *dicModel = (NSDictionary *)model;
        NSMutableDictionary *mdicJSON = [NSMutableDictionary dictionaryWithCapacity:dicModel.count];
        [dicModel enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull value, BOOL * _Nonnull stop) {
            id jsonObj = modelToJSONObject(value);
            if (jsonObj) {
                mdicJSON[key] = jsonObj;
            }
        }];
        return mdicJSON;
    }
    // 数组，对每个对象处理后加入
    if ([model isKindOfClass:[NSArray class]]) {
        if ([NSJSONSerialization isValidJSONObject:model]) { return model; }
        NSArray *arrModel = (NSArray *)model;
        // 对每个数字对象进行转json对象处理
        NSMutableArray *marrJSON = [NSMutableArray arrayWithCapacity:arrModel.count];
        for (id obj in arrModel) {
            id jsonObj = modelToJSONObject(obj);
            if (jsonObj) {
                [marrJSON addObject:jsonObj];
            }
        }
        return marrJSON;
    }
    // set转为数组处理
    if ([model isKindOfClass:[NSSet class]]) {
        NSArray *arrModel = ((NSSet *)model).allObjects;
        return modelToJSONObject(arrModel);
    }
    
    if ([model isKindOfClass:[UIImage class]]) {
        return nil;
    }
    
    // 其他对象处理
    unsigned int propCount;
    objc_property_t *properties = class_copyPropertyList([model class], &propCount);
    // 最终输出的字典
    NSMutableDictionary *mdicJSON = [NSMutableDictionary dictionaryWithCapacity:propCount];
    for (int index = 0; index < propCount; index++) {
        objc_property_t prop = properties[index];
        const char *propName = property_getName(prop);
        const char *propAttr = property_getAttributes(prop);
        
        NSString *propNameStr = [NSString stringWithCString:propName encoding:NSUTF8StringEncoding];
        NSString *propAttrStr = [NSString stringWithCString:propAttr encoding:NSUTF8StringEncoding];
        
        //        NSLog(@"propNameStr : %@",propNameStr);
        //        NSLog(@"propAttrStr : %@",propAttrStr);
        //        NSLog(@"\n");
        
        NSString *prefixAttr = [propAttrStr substringToIndex:2];
        /********************************* 基本数据类型处理 begin *********************************/
        // 判定属性是否为基本数据类型中的数值
        NSString *numberPrefix = @"Ts,TS,Ti,TI,Tl,TL,Tq,TQ,Tf,Td";
        if ([numberPrefix rangeOfString:prefixAttr].length > 0) {
            // 放入dicJSON中
            mdicJSON[propNameStr] = [model valueForKey:propNameStr];
        }
        
        // 判定属性是否为char
        NSString *stringPrefix = @"Tc,TC";
        if ([stringPrefix rangeOfString:prefixAttr].length > 0) {
            // 放入dicJSON中
            NSString *propValue = [NSString stringWithFormat:@"%c",[[model valueForKey:propNameStr] charValue]];
            mdicJSON[propNameStr] = propValue;
        }
        
        // 判定属性是否为char *
        if ([prefixAttr isEqualToString:@"T*"]) {
            SEL getSelector = NSSelectorFromString(propNameStr);
            IMP getIMP = [model methodForSelector:getSelector];
            if (getIMP == NULL) {
                continue;
            }
            char *(*getFunc)(id self, SEL selector) = (void *)getIMP;
            char *valueChar = getFunc(model, getSelector);
            if (valueChar != NULL) {
                NSString *valueStr = [NSString stringWithCString:valueChar encoding:NSUTF8StringEncoding];
                mdicJSON[propNameStr] = valueStr;
            }
        }
        
        // 判定属性是否为BOOL
        if ([prefixAttr isEqualToString:@"TB"]) {
            mdicJSON[propNameStr] = [model valueForKey:propNameStr];
        }
        
        /********************************* 基本数据类型处理 end *********************************/
        
        
        /********************************* 对象类型 begin *********************************/
        if ([prefixAttr isEqualToString:@"T@"]) {
            
            id propValue = [model valueForKey:propNameStr];
            id jsonObj = modelToJSONObject(propValue);
            if (jsonObj) {
                mdicJSON[propNameStr] = jsonObj;
            }
        }
        /********************************* 对象类型 end *********************************/
        
        
        // 校验当前mdicJSON的合法性
        BOOL validJSONResult = [NSJSONSerialization isValidJSONObject:mdicJSON];
        if (!validJSONResult) {
            NSLog(@"validJSON is failture");
        }
    }
    
    free(properties);
    return mdicJSON;
}

- (NSDictionary *)modelToDictionary {
    id JSONObject = modelToJSONObject(self);
    if ([JSONObject isKindOfClass:[NSDictionary class]]) {
        return JSONObject;
    } else {
        return nil;
    }
}

- (NSArray *)modelToArray {
    id JSONObject = modelToJSONObject(self);
    if ([JSONObject isKindOfClass:[NSArray class]]) {
        return JSONObject;
    } else {
        return nil;
    }
}

@end
