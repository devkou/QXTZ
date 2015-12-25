//
//  AppDelegate.m
//  Water
//
//  Created by gs on 15/12/10.
//  Copyright © 2015年 KH. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "LoginViewController.h"
#import "UserModel.h"
#import "QBTools.h"
#import "HttpRequestManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //just test use sourceTree
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [[UserModel currentUser] getUserInfo];
    if (![UserModel currentUser].isLogin) {
        UINavigationController*loginNav = [mainStoryboard instantiateViewControllerWithIdentifier:@"loginNav"];
        loginNav.navigationBar.tintColor = [UIColor whiteColor];
        self.window.rootViewController = loginNav;
    }else{
        if ([[[UserModel currentUser] userKind] length]&&[[[UserModel currentUser] userKind] isEqualToString:@"0"]) {
            //用户
            /**************  客户页面  *************/
            UINavigationController*nav2 = [mainStoryboard instantiateViewControllerWithIdentifier:@"rootNav2"];
            [nav2.navigationBar setTintColor:RGBACOLOR(57, 127, 198, 1)];
            self.window.rootViewController = nav2;
        }
        if ([[[UserModel currentUser] userKind] length]&&[[[UserModel currentUser] userKind] isEqualToString:@"1"]) {
            //安装工
            /**************  安装工页面  *************/
            UINavigationController*nav = [mainStoryboard instantiateViewControllerWithIdentifier:@"rootNav"];
            [nav.navigationBar setTintColor:RGBACOLOR(57, 127, 198, 1)];
            self.window.rootViewController = nav;
        }
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)autoLogin {
    NSMutableDictionary*parameters = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parameters setObject:[UserModel currentUser].mobile forKey:@"username"];
    [parameters setObject:[QBTools md5:[UserModel currentUser].pswStr] forKey:@"password"];
    
    MBProgressHUD * hud=[QBTools mbHudLoadingOfView:self.window];
    [HttpRequestManager POST:LOGIN parameters:parameters block:^(BOOL isSucceed, id responseObject, NSError *error) {
        [hud hide:YES];
        if (!error) {
            if ([[responseObject valueForKey:@"code"] integerValue] == 0) {
                NSDictionary * userDic = [responseObject objectForKey:@"user"];
                [UserModel initWithDic:userDic];
                [UserModel currentUser].isLogin = YES;
                [[UserModel currentUser] saveUserInfo];
            }else{
                [QBTools JustShowWithType:NO withStatus:[responseObject valueForKey:@"msg"]];
            }
        }else{
            [QBTools JustShowWithType:NO withStatus:error.description];
        }
    }];
}

@end
