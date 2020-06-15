//
//  NSString+UrlEncode.h
//  KID
//
//  Created by NULL on Future.
//  Copyright © 2015年 KID. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSString (UrlEncode)
/**
 *  @brief  urlEncode
 *
 *  @return urlEncode 后的字符串
 */
- (NSString *)urlEncode;
/**
 *  @brief  urlEncode
 *
 *  @param encoding encoding模式
 *
 *  @return urlEncode 后的字符串
 */
- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;
/**
 *  @brief  urlDecode
 *
 *  @return urlDecode 后的字符串
 */
- (NSString *)urlDecode;
/**
 *  @brief  urlDecode
 *
 *  @param encoding encoding模式
 *
 *  @return urlDecode 后的字符串
 */
- (NSString *)urlDecodeUsingEncoding:(NSStringEncoding)encoding;

/**
 *  @brief  url query转成NSDictionary
 *
 *  @return NSDictionary
 */
- (NSDictionary *)dictionaryFromURLParameters;

/**
*  @brief  url 后拼接参数
*
*  @param value 值
*
*  @param key 键
*
*  @return 返回拼接后的链接
*/
-(NSString *)urlAddCompnentForValue:(NSString *)value key:(NSString *)key;
@end
