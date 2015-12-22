//
//  QBTools.h
//  69Wallet
//
//  Created by cyh on 15/6/17.
//  Copyright (c) 2015年 TuShunJinRong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Define.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <SVProgressHUD.h>
#import <objc/runtime.h>
#import <PureLayout.h>
#import <MBProgressHUD.h>

@interface QBTools : NSObject


+ (NSDictionary *)bankLogoAndBackgroundWithBankCode:(NSString *)bankCode;

+ (UIView *)MBProgressViewCustomViewFor69Pay;

+ (NSString *)md5:(NSString *)str;

+ (void)showTipInView:(UIView *)view andMessage:(NSString *)message;

+ (BOOL)checkPhoneNumInput:(NSString *)string;

#pragma 只是手机号
+ (BOOL)checkMoblePhoneNum:(NSString *) moblePhoneNum;
#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;
#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;
#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName;
#pragma 正则匹配用户身份证号
+ (BOOL)checkUserIdCard: (NSString *) idCard;
#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number;
#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url;

+ (NSDictionary *)basicParameters;//通用参数（token、code、userMd5...）

+ (NSString *)notRounding:(double)price afterPoint:(int)position;

+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

//自适应高度
+(CGFloat)heightForBubbleWithStr:(NSString *)str font:(int)font;

//url提取参数
+ (NSMutableDictionary *)extractingParametersFromURLString:(NSString *)urlString;

//获得缩略图name
+ (NSString*)getSmallImgNameWithbBigImgName:(NSString*)bigImagName;

+(UIImage *)noCacheImageWithName:(NSString *)imageName;

//  image = "c237871dd86fb130d7625de62ee35c27img18602347.jpg?w=800&h=2448";分割
+(NSString*)getimageNameWithImage:(NSString*)image;

// 获取网络图片大小
+(CGSize)downloadImageSizeWithURL:(id)imageURL;

+(void)showLoginView;

+(void)readMessageWithType:(int)type;

/**
 *  //////////////////////////////////////////////////
 */

+(NSString*)getDateForStringTime:(NSString*)stringTie withFormat:(NSString*)format;
+(UILabel*)getNavBarTitleLabWithStr:(NSString*)string stringColor:(UIColor*)corlor;

//吐死
+ (void) JustShowWithType:(BOOL)isSuccess withStatus:(NSString*)text;
+(BOOL) isNetworkEnabled;
//json格式字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//字典转json格式字符串：
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
+ (MBProgressHUD *)mbHudLoadingOfView:(UIView *)view;
@end
