//
//  ZJBaseRequest.m
//  YTNetWorkDemo
//
//  Created by wp on 2019/2/21.
//  Copyright © 2019年 wp. All rights reserved.
//

#import "ZJBaseRequest.h"
#import "ZJEnvironmentManager.h"
#import "NSObject+ZJModelToDictionary.h"
#import "NSString+ZJUrlEncode.h"
#import <objc/runtime.h>

@implementation ZJBaseRequest
- (NSString *)baseUrl{
    return [[ZJEnvironmentManager shareInstance] getRequestServerAddress];
}
- (NSString *)requestUrl
{
    return @"";
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

- (NSInteger)cacheTimeInSeconds {
    return 10.0;
}

- (YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeJSON;
}

- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeJSON;
}

- (id)requestArgument {
    NSMutableDictionary *mdic = [[NSMutableDictionary alloc] init];
    Class cls = [self class];
    unsigned int count;
    
    Ivar *vars = class_copyIvarList(cls, &count);
    
    for (int i = 0; i < count; i ++) {
        Ivar thisIvar = vars[i];
        
        const char* name = ivar_getName(thisIvar);  //获取成员变量的名字
        
        NSMutableString *ocName = [NSMutableString stringWithUTF8String:name];
        if ([ocName hasPrefix:@"_"]) {
            ocName = [NSMutableString stringWithString:[ocName substringFromIndex:1]];
        }
        
        NSString *key = [ocName copy];
        if ([ocName isEqualToString:@"mid"]) {
            ocName = [[NSMutableString alloc]initWithString:@"id"];
        }
        if ([ocName isEqualToString:@"mnewPwd"]) {
            ocName = [[NSMutableString alloc]initWithString:@"newPwd"];
        }
        
        if ([self valueForKey:key] != nil && ([[self valueForKey:key] isKindOfClass:[NSString class]] || [[self valueForKey:key] isKindOfClass:[NSNumber class]])) {
            [mdic setObject:[self valueForKey:key] forKey:ocName];
        } else if([[self valueForKey:key] isKindOfClass:[NSArray class]]) {
            NSObject *obj = [self valueForKey:key];
            NSArray *arr = [obj ZJ_modelToArray];
            [mdic setObject:arr forKey:key];
        } else if ([self valueForKey:key] != nil && ([[self valueForKey:key] isKindOfClass:[NSObject class]])){
            NSObject *obj = [self valueForKey:key];
            NSDictionary *dic = [obj ZJ_modelToDictionary];
            if (dic) {
                [mdic setObject:dic forKey:key];
            }
        }
    }
    free(vars);
    
    return (NSDictionary *)mdic;
}

- (NSTimeInterval)requestTimeoutInterval
{
    return 10;
}

- (void)ZJ_StartRequestWithCompletionBlockWithSuccess:(ZJRequestSuccessBlock)success failure:(ZJRequestFailBlock)failure{
    [self stop];
    __weak ZJBaseRequest *weakSelf = self;
    [self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        id result = nil;
        if ([weakSelf responseSerializerType] == YTKResponseSerializerTypeJSON)
        {
            result = request.responseJSONObject;
        }else if ([weakSelf responseSerializerType] == YTKResponseSerializerTypeJSON)
        {
            result = request.responseData;
        }else
        {
            result = request;
        }
        if (!result) {
            NSLog(@"服务器出错");
            if (failure) {
                failure(@"服务器出错",@"nil",nil);
            }
            return;
        }
        NSString *urlRequest = [request.baseUrl == nil ? @"":request.baseUrl stringByAppendingString:request.requestUrl == nil ? @"" :request.requestUrl];
        NSDictionary *requestArgument = request.requestArgument;
        if (requestArgument)
        {
            NSArray *arrayKey = requestArgument.allKeys;
            for (int i = 0; i < arrayKey.count; i++) {
                NSString *key = arrayKey[i];
                NSString *value = requestArgument[key];
                if (key && value) {
                    urlRequest = [urlRequest ZJ_urlAddCompnentForValue:value key:key];
                }
            }
        }
        NSLog(@"=====SUCCESS=====\n请求接口 : %@\n=================\n",urlRequest);
        NSLog(@"=====请求成功===== 响应参数 ：%@",result);
        if (success) {
            success(result);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSInteger errorCode = ((NSHTTPURLResponse *)request.requestTask.response).statusCode;
        
        NSLog(@"=====FAILURE=====\n请求接口 : %@\n请求参数 : %@\n返回主体 : %@\n errorCode :%ld =================\n",request,request.requestArgument,request.responseObject,(long)errorCode);
        
        NSString *errmsg;
        
        // 网络断开情况
        if (errorCode == 0) {
            errmsg = @"网络不给力哟";
        } else {
            if (errorCode == NSURLErrorTimedOut) {
                errmsg = @"网络不给力哦，请求超时";
            } else if (errorCode == NSURLErrorNotConnectedToInternet){
                errmsg = @"无法连接网络";
            } else if (errorCode == NSURLErrorNetworkConnectionLost){
                errmsg = @"网络不稳定，连接丢失";
            } else if (errorCode == NSURLErrorCannotConnectToHost){
                errmsg = @"无法连接服务器";
            } else {
                errmsg = @"请求失败";
            }
        }
        NSString *netError = (errorCode == 0 || errorCode == NSURLErrorNotConnectedToInternet)?@"netError":errmsg;
        if (failure) {
            failure(errmsg,netError,request.requestTask.error);
        }
    }];
}

@end
