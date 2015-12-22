//
//  RegisterViewController.m
//  Water
//
//  Created by KouHao on 15/12/16.
//  Copyright © 2015年 KH. All rights reserved.
//

#import "RegisterViewController.h"
#import "QBTools.h"
#import "RegisterCell.h"
#import "HttpRequestManager.h"

@interface RegisterViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.titleView = [QBTools getNavBarTitleLabWithStr:@"注册" stringColor:[UIColor whiteColor]];

    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    UIView*view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MYWIDTH, 0)];
    view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = view;
    
    [self.registBtn addTarget:self action:@selector(registBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registBtn];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _timer = nil;
}

#pragma mark - private
- (void)registBtnClick:(UIButton*)sendr {
//    注册
    //mobile  password  mobCode   generalize_code
    NSMutableDictionary*parameters = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parameters setObject:self.textFieldPhone.text forKey:@"mobile"];
    [parameters setObject:[QBTools md5:self.textFieldPsw.text] forKey:@"password"];
    [parameters setObject:self.textFieldCode.text forKey:@"mobCode"];
    [parameters setObject:self.textFieldName.text forKey:@"generalize_code"];

    [HttpRequestManager POST:REGIST parameters:parameters block:^(BOOL isSucceed, id responseObject, NSError *error) {
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

- (void)geCodeBtnClick {
    //获取验证码
    if (![QBTools checkMoblePhoneNum:self.textFieldPhone.text])
    {
        [QBTools showTipInView:self.view andMessage:@"请输入正确的手机号"];
        return;
    }else{
        _getCodeLab.userInteractionEnabled=NO;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self requestVerificationCode];
        });
    }
}

- (void)requestVerificationCode {
    [self startTime];
    NSMutableDictionary*parameters = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parameters setObject:self.textFieldPhone.text forKey:@"mobile"];
    [HttpRequestManager POST:GET_SMSCODE parameters:parameters block:^(BOOL isSucceed, id responseObject, NSError *error) {
        if (!error) {
            if ([[responseObject valueForKey:@"code"] integerValue] == 0) {
                [QBTools JustShowWithType:YES withStatus:[responseObject valueForKey:@"msg"]];
            }else{
                [QBTools JustShowWithType:NO withStatus:[responseObject valueForKey:@"msg"]];
            }
        }else{
            [QBTools JustShowWithType:NO withStatus:error.debugDescription];
        }
    }];
}

-(void)startTime{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout==0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                _getCodeLab.text = @"重新获取";
                _getCodeLab.userInteractionEnabled=YES;
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%d",timeout);
                _getCodeLab.text = [NSString stringWithFormat:@"(%d)重新获取",timeout];
                _getCodeLab.userInteractionEnabled = NO;
                
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}

#pragma mark - properties
- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 0, MYWIDTH, MYHEIGHT);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIButton *)registBtn {
    if (!_registBtn) {
        _registBtn = [[UIButton alloc] initWithFrame:CGRectMake(12, MYHEIGHT -50, MYWIDTH-24, 44)];
        [_registBtn setBackgroundColor:RGBACOLOR(57, 127, 198, 1)];
        [_registBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _registBtn.clipsToBounds = YES;
        _registBtn.layer.cornerRadius = 4;
    }
    return _registBtn;
}

- (UILabel *)getCodeLab {
    if (!_getCodeLab) {
        _getCodeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [_getCodeLab setBackgroundColor:RGBACOLOR(57, 127, 198, 1)];
        _getCodeLab.text = @"获取验证码";
        _getCodeLab.font = [UIFont systemFontOfSize:14];
        _getCodeLab.userInteractionEnabled=YES;
        _getCodeLab.textAlignment = NSTextAlignmentCenter;
        _getCodeLab.textColor = [UIColor whiteColor];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(geCodeBtnClick)];
        [_getCodeLab addGestureRecognizer:tap];

    }
    return _getCodeLab;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
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

            cell.textField.placeholder = @"请设置登陆密码";
            cell.textField.secureTextEntry = YES;
        }
            break;
        case 3: {
            self.textFieldName = cell.textField;

            cell.textField.placeholder = @"您的姓名";
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *toString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    
    if (textField == _textFieldPhone) {
        //手机号码
        if (toString && [toString length] > 11)
        {
            [textField resignFirstResponder];
            textField.text = [toString substringToIndex:11];
        }
    }else if (textField == _textFieldCode) {
        //验证码
    }else if (textField == _textFieldPsw) {
        //密码
    }else if (textField == _textFieldName) {
        //姓名
    }
    return YES;
}

#pragma mark - Other

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
