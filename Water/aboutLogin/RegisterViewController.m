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

@property (nonatomic ,strong) UITableView * tableView;
@property (nonatomic ,strong) UIButton * registBtn;

@property (nonatomic ,strong ) UITextField * textFieldPhone;
@property (nonatomic ,strong ) UITextField * textFieldCode;
@property (nonatomic ,strong ) UITextField * textFieldPsw;
@property (nonatomic ,strong ) UITextField * textFieldName;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.titleView = [QBTools getNavBarTitleLabWithStr:@"注册" stringColor:[UIColor whiteColor]];

    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    UIView*view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MYWIDTH, 50)];
    view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = view;
    
    [self.registBtn addTarget:self action:@selector(registBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_registBtn];
}

#pragma mark - private
- (void)registBtnClick:(UIButton*)sendr {
    //注册
    [HttpRequestManager POST:GET_SMSCODE parameters:@{@"mobile":@"18606519116"} block:^(BOOL isSucceed, id responseObject, NSError *error) {
        
    }];
    //mobile  password  mobCode   generalize_code
    [HttpRequestManager POST:REGIST parameters:@{@"mobile":@"18606519116",@"password":@"123123",@"mobCode":@"874654",@"generalize_code":@"haodada"} block:^(BOOL isSucceed, id responseObject, NSError *error) {
        
    }];
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
    return YES;
}

#pragma mark - Other

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
