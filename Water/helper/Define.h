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

#define LOGIN               @"mobileTer/regist/login"           //登陆
#define REGIST              @"mobileTer/regist/registSubmit"    //注册
#define FORGET_PSW          @"mobileTer/regist/forpwdSubmit"    //忘记密码重置密码
#define CHECK_MOBLIE_IS_HAD @"mobileTer/regist/checkMoblie"     //检查手机号是否存在
#define GET_SMSCODE         @"mobileTer/user/createSmsCode"     //获取验证码

#define WORKER_ORDER_LIST   @"mobileTer/userOrderTer/userOrderInstal" //安装工登陆派单列表
#define SURE_INSTAL         @"mobileTer/userOrderTer/sureInstal"      //确认安装


#endif /* Define_h */
