//
//  QBTools.m
//  69Wallet
//
//  Created by cyh on 15/6/17.
//  Copyright (c) 2015年 TuShunJinRong. All rights reserved.
//

#import "QBTools.h"
#import <CommonCrypto/CommonDigest.h>
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
@implementation QBTools
#define BUBBLE_VIEW_PADDING 8 // bubbleView 与 在其中的控件内边距

+ (UIView *)MBProgressViewCustomViewFor69Pay
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(24, 0, 33, 35)];
    imageView.image = [UIImage imageNamed:@"common69Pay"];
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 41, 80, 21)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = @"69支付";
    [view addSubview:label];
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 62, 80, 20)];
    pageControl.numberOfPages = 3;

    [view addSubview:pageControl];
    
    return view;
}


+ (NSString *)md5:(NSString *)str {
    
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02x", result[i]];
    return [hash lowercaseString];
}



+ (BOOL)checkPhoneNumInput:(NSString *)string
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
//    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
     NSString * PHS = @"^([0-9]{3,4}-)?[0-9]{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];

    BOOL res1 = [regextestmobile evaluateWithObject:string];
    BOOL res2 = [regextestcm evaluateWithObject:string];
    BOOL res3 = [regextestcu evaluateWithObject:string];
    BOOL res4 = [regextestct evaluateWithObject:string];
    BOOL res5 = [regextestphs evaluateWithObject:string];

    if (res1 || res2 || res3 || res4 || res5)
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}


+(NSString *)notRounding:(double)price afterPoint:(int)position
{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithDouble:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    NSString *string = [NSString stringWithFormat:@"%%.%df",position];
    return [NSString stringWithFormat:string,[roundedOunces floatValue]];
}
#pragma 只是手机号
+ (BOOL)checkMoblePhoneNum:(NSString *) moblePhoneNum{
    NSString * MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    BOOL m=[regextestmobile evaluateWithObject:moblePhoneNum];
    if (m) {
        return YES;
    }else{
        return NO;
    }
}
#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    
    NSString * MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    NSString * PHS = @"^([0-9]{3,4}-)?[0-9]{7,8}$";
//    NSString * GUHUA=@"^(0[1-9]{2})-\\d{8}$|^(0[1-9]{3}-(\\d{7,8}))$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *phs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
//    NSPredicate *guhua = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", GUHUA];

    BOOL m=[regextestmobile evaluateWithObject:telNumber];
    BOOL n=[phs evaluateWithObject:telNumber];
//    BOOL p=[guhua evaluateWithObject:telNumber];
    
    if (m || n /*|| p*/) {
        return YES;
    }else{
        return NO;
    }
}


#pragma 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}

#pragma 正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName : (NSString *) userName
{
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
    
}


#pragma 正则匹配用户身份证号15或18位
+ (BOOL)checkUserIdCard: (NSString *) idCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber : (NSString *) number
{
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
    
}

#pragma 正则匹配URL
+ (BOOL)checkURL : (NSString *) url
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
    
}

+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(CGFloat)heightForBubbleWithStr:(NSString *)str font:(int)font
{
    CGSize textBlockMinSize = {MYWIDTH-16, CGFLOAT_MAX};
    CGSize size;
    static float systemVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    });
    if (systemVersion >= 7.0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:[[self class] lineSpacing]];//调整行间距
        size = [str boundingRectWithSize:textBlockMinSize options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{
                                                   NSFontAttributeName:[[self class] textLabelFont:font],
                                                   NSParagraphStyleAttributeName:paragraphStyle
                                                   }
                                         context:nil].size;
    }else{
        size = [str sizeWithFont:[self textLabelFont:font]
                       constrainedToSize:textBlockMinSize
                           lineBreakMode:[self textLabelLineBreakModel]];
    }
    return size.height;
}
+(UIFont *)textLabelFont:(int)font
{
    return [UIFont systemFontOfSize:font];
}
+(CGFloat)lineSpacing{
    return 1;//行间距
}

+(NSLineBreakMode)textLabelLineBreakModel
{
    return NSLineBreakByCharWrapping;
}

+ (NSMutableDictionary *)extractingParametersFromURLString:(NSString *)urlString
{
    //url参数截取
    NSMutableDictionary *parametersDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    NSArray *array = [urlString componentsSeparatedByString:@"?"];
    if (array && [array count] > 1)
    {
        NSString *parametersString = [array objectAtIndex:1];
        NSArray *parametersArray = [parametersString componentsSeparatedByString:@"&"];
        for (NSString *string in parametersArray)
        {
            NSArray *parameters = [string componentsSeparatedByString:@"="];
            if (parameters && [parameters count] >1)
            {
                NSString *key = [parameters objectAtIndex:0];
                NSString *value = [parameters objectAtIndex:1];
                if (key && [key length] && value && [value length])
                {
                    [parametersDic setObject:value forKey:key];
                }
            }
        }
    }
    
    return parametersDic;
}

//获得缩略图name
+ (NSString*)getSmallImgNameWithbBigImgName:(NSString*)bigImagName
{
   NSString*str=[bigImagName stringByReplacingOccurrencesOfString:@"." withString:@"M."];
    return str;
}


+(UIImage *)noCacheImageWithName:(NSString *)imageName
{
    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:imageName];
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];
    return image;
}

+(NSString*)getimageNameWithImage:(NSString*)image{
    NSArray *array = [image componentsSeparatedByString:@"?"];
    return array[0];
}


+(CGSize)downloadImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;
    NSString* absoluteString = URL.absoluteString;
#ifdef dispatch_main_sync_safe
    if([[SDImageCache sharedImageCache] diskImageExistsWithKey:absoluteString])
    {
        UIImage* image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:absoluteString];
        if(!image)
        {
            NSData* data = [[SDImageCache sharedImageCache] performSelector:@selector(diskImageDataBySearchingAllPathsForKey:) withObject:URL.absoluteString];
            image = [UIImage imageWithData:data];
        }
        if(!image)
        {
            return image.size;
        }
    }
#endif
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self downloadPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self downloadGIFImageSizeWithRequest:request];
    }
    else{
        size = [self downloadJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
#ifdef dispatch_main_sync_safe
            [[SDImageCache sharedImageCache] storeImage:image recalculateFromImage:YES imageData:data forKey:URL.absoluteString toDisk:YES];
#endif
            size = image.size;
        }
    }
    return size;
}
+(CGSize)downloadPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
+(CGSize)downloadGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
+(CGSize)downloadJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}

//只为去除警告 diskImageDataBySearchingAllPathsForKey
-(id)diskImageDataBySearchingAllPathsForKey:(id)key{
    return nil;
}

+(NSString*)getDateForStringTime:(NSString*)stringTie withFormat:(NSString*)format
{
    NSDate* timeSp = [NSDate dateWithTimeIntervalSince1970:[stringTie doubleValue]];
    
    if (format == nil) {
        format = @"yyyy-MM-dd HH:mm:ss";
    }
    
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:format];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:timeSp];
    return currentDateStr;
    
}
+(UILabel*)getNavBarTitleLabWithStr:(NSString*)string stringColor:(UIColor*)corlor
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = corlor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = string;
    
    return titleLabel;
}

//吐死
+ (void) JustShowWithType:(BOOL)isSuccess withStatus:(NSString*)text
{
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    if (isSuccess) {
        if (!text) {
            [SVProgressHUD showSuccessWithStatus:@"成功了!"];
        }
        else
        {
            [SVProgressHUD showSuccessWithStatus:text];
        }
    }
    else
    {
        if (!text) {
            [SVProgressHUD showErrorWithStatus:@"失败了!"];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:text];
        }
    }
}

#pragma mark -是否存在网络
+(BOOL) isNetworkEnabled
{
    BOOL bEnabled = FALSE;
    NSString *url = @"www.baidu.com";
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithName(NULL, [url UTF8String]);
    SCNetworkReachabilityFlags flags;
    
    bEnabled = SCNetworkReachabilityGetFlags(ref, &flags);
    
    CFRelease(ref);
    if (bEnabled) {
        //        kSCNetworkReachabilityFlagsReachable：能够连接网络
        //        kSCNetworkReachabilityFlagsConnectionRequired：能够连接网络，但是首先得建立连接过程
        //        kSCNetworkReachabilityFlagsIsWWAN：判断是否通过蜂窝网覆盖的连接，比如EDGE，GPRS或者目前的3G.主要是区别通过WiFi的连接。
        BOOL flagsReachable = ((flags & kSCNetworkFlagsReachable) != 0);
        BOOL connectionRequired = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
        BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
        bEnabled = ((flagsReachable && !connectionRequired) || nonWiFi) ? YES : NO;
    }
    
    if (bEnabled) {
        
        return YES;
    }
    else
    {
        [self JustShowWithType:NO withStatus:@"请检查您的网络连接..."];
        return NO;
    }
    
    return YES;
}

//json格式字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}

//字典转json格式字符串：
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

+ (void)showTipInView:(UIView *)view andMessage:(NSString *)message
{
    if (!message || ![message length])
    {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelText = message;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [MBProgressHUD hideAllHUDsForView:view animated:YES];
        });
    });
    
    return;
}

+ (MBProgressHUD *)mbHudLoadingOfView:(UIView *)view {
    MBProgressHUD*hud = [[MBProgressHUD alloc] initWithView:view];
    hud.labelText = @"loading...";
    [view addSubview:hud];
    [hud show:YES];
    
    return hud;
}

+ (void)setUserDefaultsValue:(id)value key:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (NSString *)valueForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end
