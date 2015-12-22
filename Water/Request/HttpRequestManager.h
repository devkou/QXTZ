//
//  HttpRequestManager.h
//  Water
//
//  Created by KouHao on 15/12/20.
//  Copyright © 2015年 KH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "QBTools.h"

typedef void (^CallBack)(BOOL isSucceed,id responseObject, NSError *error);

@interface HttpRequestManager : NSObject
/*
 //检查手机号是否存在
 mobileTer/regist/login   参数: username(mobile)  password   返回user   userKind：0为用户  1为安装工
 
 //注册提交
 mobileTer/regist/registSubmit   参数:  mobile  password  mobCode   generalize_code(你的姓名)
 
 //忘记密码重置密码提交
 mobileTer/regist/forpwdSubmit	参数： mobile password  mobCode
 
 //检查手机号是否存在
 mobileTer/regist/checkMoblie   参数： mobile
 
 //获取验证码
 mobileTer/user/createSmsCode   参数： mobile
 */
+ (void)GET:(NSString *)URLString
 parameters:(NSDictionary *)parameters
      block:(CallBack)block;

+ (void)POST:(NSString *)URLString
  parameters:(NSDictionary *)parameters
       block:(CallBack)block;

+ (void)POSTData:(NSData *)data
            name:(NSString *)name
        fileName:(NSString *)fileName
        mimeType:(NSString *)miniType
             url:(NSURL *)url
      parameters:(NSDictionary *)parameters
           block:(CallBack)block;

@end
