//
//  Define.h
//  Water
//
//  Created by KouHao on 15/12/20.
//  Copyright © 2015年 KH. All rights reserved.
//

#ifndef Define_h
#define Define_h

#define MYWIDTH    [UIScreen mainScreen].bounds.size.width
#define MYHEIGHT    [UIScreen mainScreen].bounds.size.height


//颜色
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]


#define HOST                @"http://smf.hzsmf.com/"

#define LOGIN               @"mobileTer/regist/login"
#define REGIST              @"mobileTer/regist/registSubmit"
#define FORGET_PSW          @"mobileTer/regist/forpwdSubmit"
#define CHECK_MOBLIE_IS_HAD @"mobileTer/regist/checkMoblie"
#define GET_SMSCODE         @"mobileTer/user/createSmsCode"
/*
 //检查手机号是否存在 登陆
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

#endif /* Define_h */
