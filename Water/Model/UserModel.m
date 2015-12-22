//
//  UserModel.m
//  Water
//
//  Created by gs on 15/12/22.
//  Copyright © 2015年 KH. All rights reserved.
//

#import "UserModel.h"
#import "NSObject+Convert.h"
#import "QBTools.h"

@implementation UserModel
+ (UserModel *)initWithDic:(id)dic {
    [UserModel currentUser].createTime = [[dic valueForKey:@"createTime"] toString];
    [UserModel currentUser].mobile     = [[dic valueForKey:@"mobile"] toString];
    [UserModel currentUser].nickName   = [[dic valueForKey:@"nickName"] toString];
    [UserModel currentUser].realName   = [[dic valueForKey:@"realName"] toString];
    [UserModel currentUser].userKind   = [[dic valueForKey:@"userKind"] toString];
    [UserModel currentUser].userMd5    = [[dic valueForKey:@"userMd5"] toString];

    return [UserModel currentUser];
}

//- (void)saveWithUser:(UserModel *)user {
//    [[NSUserDefaults standardUserDefaults] setObject:user.createTime forKey:@"createTime"];
//    [[NSUserDefaults standardUserDefaults] setObject:user.mobile forKey:@"mobile"];
//    [[NSUserDefaults standardUserDefaults] setObject:user.nickName forKey:@"nickName"];
//    [[NSUserDefaults standardUserDefaults] setObject:user.realName forKey:@"realName"];
//    [[NSUserDefaults standardUserDefaults] setObject:user.userKind forKey:@"userKind"];
//    [[NSUserDefaults standardUserDefaults] setObject:user.userMd5 forKey:@"userMd5"];
//
//}

+ (instancetype)currentUser
{
    static UserModel *currentUser = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        currentUser = [[UserModel alloc] init];
    });
    return currentUser;
}

//清除用户信息
- (void)removeUserInfo
{
    [UserModel currentUser].createTime = nil;
    [UserModel currentUser].mobile = nil;
    [UserModel currentUser].nickName = nil;
    [UserModel currentUser].realName = nil;
    [UserModel currentUser].userKind = nil;
    [UserModel currentUser].userMd5 = nil;
    [UserModel currentUser].isLogin = nil;
    [UserModel currentUser].pswStr = nil;
}


- (void)saveUserInfo
{
    [QBTools setUserDefaultsValue:[UserModel currentUser].createTime key:@"createTime"];
    [QBTools setUserDefaultsValue:[UserModel currentUser].mobile key:@"mobile"];
    [QBTools setUserDefaultsValue:[UserModel currentUser].nickName key:@"nickName"];
    [QBTools setUserDefaultsValue:[UserModel currentUser].realName key:@"realName"];
    [QBTools setUserDefaultsValue:[UserModel currentUser].userKind key:@"userKind"];
    [QBTools setUserDefaultsValue:[UserModel currentUser].userMd5 key:@"userMd5"];
    [QBTools setUserDefaultsValue:@([UserModel currentUser].isLogin) key:@"isLogin"];
    [QBTools setUserDefaultsValue:[UserModel currentUser].pswStr key:@"pswStr"];
}


- (void)getUserInfo
{
    [UserModel currentUser].createTime = [QBTools valueForKey:@"createTime"];
    [UserModel currentUser].mobile = [QBTools valueForKey:@"mobile"];
    [UserModel currentUser].nickName = [QBTools valueForKey:@"nickName"];
    [UserModel currentUser].realName = [QBTools valueForKey:@"realName"];
    [UserModel currentUser].userKind = [QBTools valueForKey:@"userKind"];
    [UserModel currentUser].userMd5 = [QBTools valueForKey:@"userMd5"];
    [UserModel currentUser].isLogin = [[QBTools valueForKey:@"isLogin"] boolValue];
    [UserModel currentUser].pswStr = [QBTools valueForKey:@"pswStr"];

}

- (void)deleteSavedUserInfo
{
    
    @try {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"createTime"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"mobile"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"nickName"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"realName"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userKind"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userMd5"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isLogin"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"pswStr"];
    }
    @catch (NSException *exception) {

    }
}


@end
