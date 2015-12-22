//
//  LoginViewController.m
//  Water
//
//  Created by KouHao on 15/12/16.
//  Copyright © 2015年 KH. All rights reserved.
//

#import "LoginViewController.h"
#import "QBTools.h"
#import "RegisterViewController.h"
#import "HttpRequestManager.h"
#import "UserModel.h"
#import "ForPwdViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) UITextField * lastAssignmentTextView;
@property (strong, nonatomic) UITextField * assignmentTextView;

@end

@implementation LoginViewController
{
    float myHeight;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginBtn.clipsToBounds = YES;
    self.loginBtn.layer.cornerRadius = 3;
    /*
    //增加监听，当键盘出现或改变时收出消息

    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(myKeyboardWillShow:)
     
                                                 name:UIKeyboardWillShowNotification
     
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(myKeyboardDidHide:)
     
                                                 name:UIKeyboardWillHideNotification
     
                                               object:nil];
     */
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (IBAction)login:(UIButton *)sender {
    [self.view endEditing:YES];
    
    NSMutableDictionary*parameters = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parameters setObject:self.phoneTextField.text forKey:@"username"];
    [parameters setObject:[QBTools md5:self.pswTestField.text] forKey:@"password"];
    
    MBProgressHUD * hud=[QBTools mbHudLoadingOfView:self.view];
    [HttpRequestManager POST:LOGIN parameters:parameters block:^(BOOL isSucceed, id responseObject, NSError *error) {
        [hud hide:YES];
        if (!error) {
            if ([[responseObject valueForKey:@"code"] integerValue] == 0) {
                NSDictionary * userDic = [responseObject objectForKey:@"user"];
                UserModel *user = [UserModel initWithDic:userDic];
                [UserModel currentUser].isLogin = YES;
                [[UserModel currentUser] saveUserInfo];

                //判断2种类型分别进入不同页面                //0 客户 1 安装工
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                if ([[[UserModel currentUser] userKind] length]&&[[[UserModel currentUser] userKind] isEqualToString:@"0"]) {
                    //用户
                    /**************  客户页面  *************/
                    UINavigationController*nav2 = [mainStoryboard instantiateViewControllerWithIdentifier:@"rootNav2"];
                    [nav2.navigationBar setTintColor:RGBACOLOR(57, 127, 198, 1)];
                    [self dismissViewControllerAnimated:YES completion:nil];
                    [UIApplication sharedApplication].keyWindow.rootViewController = nav2;
                }
                if ([[[UserModel currentUser] userKind] length]&&[[[UserModel currentUser] userKind] isEqualToString:@"1"]) {
                    //安装工
                    /**************  安装工页面  *************/
                    UINavigationController*nav = [mainStoryboard instantiateViewControllerWithIdentifier:@"rootNav"];
                    [nav.navigationBar setTintColor:RGBACOLOR(57, 127, 198, 1)];
                    [self dismissViewControllerAnimated:YES completion:nil];
                    [UIApplication sharedApplication].keyWindow.rootViewController = nav;
                }
            }else{
                [QBTools JustShowWithType:NO withStatus:[responseObject valueForKey:@"msg"]];
            }
        }else{
            [QBTools JustShowWithType:NO withStatus:error.description];
        }
    }];
}
- (IBAction)findPsw:(UIButton *)sender {
    //找回密码
    ForPwdViewController*forPwdVC = [[ForPwdViewController alloc] init];
    [self.navigationController pushViewController:forPwdVC animated:YES];
}
- (IBAction)regist:(UIButton *)sender {
    //注册
    RegisterViewController*registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
//    self.assignmentTextView=textField;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    self.lastAssignmentTextView=textField;
}
/*
int myprewTag ;
float myprewMoveY; //编辑的时候移动的高度


//当键盘出现或改变时调用

- (void)myKeyboardWillShow:(NSNotification *)notification

{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    myHeight = keyboardRect.size.height;
    
    
    ///////////
    
    float heigt = keyboardRect.size.height;
    if (heigt == 0){
        heigt = myHeight;
    }
    CGRect textFieldRect;
    if ([self.lastAssignmentTextView isFirstResponder]) {
        textFieldRect = [self.lastAssignmentTextView frame];
    }else {
        textFieldRect = [self.assignmentTextView frame];
    }
    
    float textY = textFieldRect.origin.y+textFieldRect.size.height;
    float bottomY = self.view.frame.size.height-textY;
    float moveY = myHeight-bottomY;
    myprewMoveY=moveY;
    if(bottomY>=myHeight)  //判断当前的高度是否已经有216，如果超过了就不需要再移动主界面的View高度
    {
        myprewTag = -1;
        return;
    }
    myprewTag=0;
    
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    frame.origin.y -=moveY;//view的Y轴上移
    frame.size.height +=moveY; //View的高度增加
    self.view.frame = frame;
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];//设置调整界面的动画效果
}

-(void)myKeyboardDidHide:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
    NSValue *avalue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [self.view convertRect:[avalue CGRectValue] fromView:nil];
    float heigt = keyboardRect.size.height;
    if (heigt == 0){
        heigt = myHeight;
    }
    
    float moveY ;
    NSTimeInterval animationDuration = 0.30f;
    CGRect frame = self.view.frame;
    if(myprewTag == -1) //当编辑的View不是需要移动的View
    {
        return;
    }else{
        moveY =  myprewMoveY;
        frame.origin.y +=moveY;
        frame.size. height -=moveY;
        self.view.frame = frame;
    }
    //self.view移回原位置
    [UIView beginAnimations:@"ResizeView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.view.frame = frame;
    [UIView commitAnimations];
}
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
