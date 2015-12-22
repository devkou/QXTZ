//
//  HttpRequestManager.m
//  Water
//
//  Created by KouHao on 15/12/20.
//  Copyright © 2015年 KH. All rights reserved.
//

#import "HttpRequestManager.h"
#import <AFNetworking.h>

@implementation HttpRequestManager

////注册
//+ (void)registSubmitWithDic:(NSDictionary*)parameters url:(NSString*)url block:(CallBack)block {
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager POST:[NSString stringWithFormat:@"%@%@",HOST,url] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        block(YES,responseObject,nil);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        block(NO,nil,error);
//    }];
//}

+ (void)GET:(NSString *)URLString
 parameters:(NSDictionary *)parameters
      block:(CallBack)block {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:[NSString stringWithFormat:@"%@%@",HOST,URLString] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString*str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary*responseObjectDic = [QBTools dictionaryWithJsonString:str];
        NSLog(@"GET JSON: %@", responseObjectDic);

        block(YES,responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(NO,nil,error);
    }];
}

+ (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
       block:(CallBack)block {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:[NSString stringWithFormat:@"%@%@",HOST,URLString] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString*str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary*responseObjectDic = [QBTools dictionaryWithJsonString:str];
        NSLog(@"POST JSON: %@", responseObjectDic);
        block(YES,responseObjectDic,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(NO,nil,error);
    }];
}

+ (void)POSTData:(NSData *)data
            name:(NSString *)name
        fileName:(NSString *)fileName
        mimeType:(NSString *)miniType
             url:(NSURL *)url
      parameters:(NSDictionary *)parameters
           block:(CallBack)block {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:[NSString stringWithFormat:@"%@%@",HOST,url] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:miniType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString*str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary*responseObjectDic = [QBTools dictionaryWithJsonString:str];
        NSLog(@"POSTData JSON: %@", responseObjectDic);

        block(YES,responseObject,nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(NO,nil,error);
    }];    
}

@end
