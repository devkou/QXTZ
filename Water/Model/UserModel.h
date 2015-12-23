//
//  UserModel.h
//  Water
//
//  Created by gs on 15/12/22.
//  Copyright © 2015年 KH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

+ (UserModel *)initWithDic:(id)dic;

@property (assign,nonatomic) BOOL isLogin;
@property (retain,nonatomic) NSString *pswStr;

@property (retain,nonatomic) NSString *createTime;
@property (retain,nonatomic) NSString *mobile;
@property (retain,nonatomic) NSString *nickName;
@property (retain,nonatomic) NSString *realName;
@property (retain,nonatomic) NSString *userKind;
@property (retain,nonatomic) NSString *userMd5;
@property (retain,nonatomic) NSString *token;
//- (void)saveWithUser:(UserModel *)user;

+ (instancetype)currentUser;
- (void)removeUserInfo;//用不上
- (void)saveUserInfo;// 保存用户数据
- (void)getUserInfo;// 获取保存的用户数据
- (void)deleteSavedUserInfo;//清除去用户数据

@end
