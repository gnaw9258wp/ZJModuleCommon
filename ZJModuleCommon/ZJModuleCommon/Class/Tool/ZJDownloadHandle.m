//
//  ZJDownloadHandle.m
//  zjcmcc
//
//  Created by wp on 2019/5/7.
//  Copyright © 2019年 sjyyt. All rights reserved.
//

#import "ZJDownloadHandle.h"
#import <AFNetworking/AFURLSessionManager.h>

@implementation ZJDownloadHandle
+(void)downloadCustomStr:(NSString *)str
                filePath:(NSString *)filePath
              completion:(void (^)(NSURL *))completion
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    NSURLSessionDownloadTask *downloadTask  = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(filePath);
            }
        });
    }];
    [downloadTask resume];
}

@end
