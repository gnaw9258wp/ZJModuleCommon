//
//  NSFileManager+ZJFileManager.h
//  ZJModuleCommon
//
//  Created by wp on 2020/6/16.
//  Copyright © 2020 wp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (ZJFileManager)
//创建文件如果不存在的话则创建
+ (NSString *)ZJ_creatFileIfNotExist:(NSString *)path;
//判断文件是否存在
+ (BOOL)ZJ_fileIfExist:(NSString *)path isDirectory:(BOOL)isDirectory;
@end


