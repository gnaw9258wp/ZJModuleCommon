//
//  NSString+UrlEncode.h
//  KID
//
//  Created by NULL on Future.
//  Copyright © 2015年 KID. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSString (ZJUrlEncode)

/**
*  @brief  url 后拼接参数
*
*  @param value 值
*
*  @param key 键
*
*  @return 返回拼接后的链接
*/
-(NSString *)ZJ_urlAddCompnentForValue:(NSString *)value key:(NSString *)key;

-(NSData*)ZJ_stringToByte;
@end
