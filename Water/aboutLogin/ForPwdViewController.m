//
//  ForPwdViewController.m
//  Water
//
//  Created by gs on 15/12/22.
//  Copyright © 2015年 KH. All rights reserved.
//

#import "ForPwdViewController.h"
#import "RegisterCell.h"
#import "HttpRequestManager.h"

@interface ForPwdViewController ()<UITextFieldDelegate>

@end

@implementation ForPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (void)registBtnClick:(UIButton*)sendr {
    //    注册
    //mobile  password  mobCode   generalize_code
    NSMutableDictionary*parameters = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parameters setObject:self.textFieldPhone.text forKey:@"mobile"];
    [parameters setObject:[QBTools md5:self.textFieldPsw.text] forKey:@"password"];
    [parameters setObject:self.textFieldCode.text forKey:@"mobCode"];
    
    [HttpRequestManager POST:FORGET_PSW parameters:parameters block:^(BOOL isSucceed, id responseObject, NSError *error) {
        if (!error) {
            if ([[responseObject valueForKey:@"code"] integerValue] == 0) {
                [QBTools JustShowWithType:YES withStatus:[responseObject valueForKey:@"msg"]];
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
                
            }else{
                [QBTools JustShowWithType:NO withStatus:[responseObject valueForKey:@"msg"]];
            }
        }else{
            [QBTools JustShowWithType:NO withStatus:error.debugDescription];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"RegisterCell";
    RegisterCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell)
    {
        cell = [[RegisterCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentify];
        cell.textField.delegate = self;
    }
    
    switch (indexPath.row) {
        case 0: {
            self.textFieldPhone = cell.textField;
            
            cell.textField.placeholder = @"请输入手机号";
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        }
            break;
        case 1: {
            self.textFieldCode = cell.textField;
            
            cell.textField.placeholder = @"请输入验证码";
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            //            [cell.contentView addSubview:self.getCodeBtn];
            cell.textField.rightViewMode = UITextFieldViewModeAlways;
            cell.textField.rightView =self.getCodeLab ;
        }
            break;
        case 2: {
            self.textFieldPsw = cell.textField;
            
            cell.textField.placeholder = @"请设置新密码";
            cell.textField.secureTextEntry = YES;
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}


@end
