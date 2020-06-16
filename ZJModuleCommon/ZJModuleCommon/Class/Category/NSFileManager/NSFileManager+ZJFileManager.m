//
//  NSFileManager+ZJFileManager.m
//  ZJModuleCommon
//
//  Created by wp on 2020/6/16.
//  Copyright © 2020 wp. All rights reserved.
//

#import "NSFileManager+ZJFileManager.h"


@implementation NSFileManager (ZJFileManager)
+ (NSString *)ZJ_creatFileIfNotExist:(NSString *)path{
    BOOL isDir = YES;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [NSFileManager ZJ_fileIfExist:path isDirectory:isDir];
    if ( !(isDir == YES && existed == YES) ) {//如果文件夹不存在
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+ (BOOL)ZJ_fileIfExist:(NSString *)path isDirectory:(BOOL)isDirectory{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDirectory];
    return existed;
}
@end
