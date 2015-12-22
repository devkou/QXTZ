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
@property (retain,nonatomic) NSString *createTime;
@property (retain,nonatomic) NSString *mobile;
@property (retain,nonatomic) NSString *nickName;
@property (retain,nonatomic) NSString *realName;
@property (retain,nonatomic) NSString *userKind;
@property (retain,nonatomic) NSString *userMd5;

- (void)saveWithUser:(UserModel *)user;

@end
