//
//  ZJDownloadHandle.h
//  zjcmcc
//
//  Created by wp on 2019/5/7.
//  Copyright © 2019年 sjyyt. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZJDownloadHandle : NSObject
+(void)downloadCustomStr:(NSString *)str
                filePath:(NSString *)filePath
              completion:(void (^)(NSURL *))completion;
@end


