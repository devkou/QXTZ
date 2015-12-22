//
//  UserModel.m
//  Water
//
//  Created by gs on 15/12/22.
//  Copyright © 2015年 KH. All rights reserved.
//

#import "UserModel.h"
#import "NSObject+Convert.h"

@implementation UserModel
+ (UserModel *)initWithDic:(id)dic {
    UserModel * data =[[UserModel alloc] init];
    data.createTime = [[dic valueForKey:@"createTime"] toString];
    data.mobile     = [[dic valueForKey:@"mobile"] toString];
    data.nickName   = [[dic valueForKey:@"nickName"] toString];
    data.realName   = [[dic valueForKey:@"realName"] toString];
    data.userKind   = [[dic valueForKey:@"userKind"] toString];
    data.userMd5    = [[dic valueForKey:@"userMd5"] toString];
    
    return data;
}

- (void)saveWithUser:(UserModel *)user {
    [[NSUserDefaults standardUserDefaults] setObject:user.createTime forKey:@"createTime"];
    [[NSUserDefaults standardUserDefaults] setObject:user.mobile forKey:@"mobile"];
    [[NSUserDefaults standardUserDefaults] setObject:user.nickName forKey:@"nickName"];
    [[NSUserDefaults standardUserDefaults] setObject:user.realName forKey:@"realName"];
    [[NSUserDefaults standardUserDefaults] setObject:user.userKind forKey:@"userKind"];
    [[NSUserDefaults standardUserDefaults] setObject:user.userMd5 forKey:@"userMd5"];

}
@end
