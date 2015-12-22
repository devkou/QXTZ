//
//  RegisterViewController.h
//  Water
//
//  Created by KouHao on 15/12/16.
//  Copyright © 2015年 KH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (nonatomic ,strong) UITableView * tableView;
@property (nonatomic ,strong) UIButton * registBtn;

@property (nonatomic ,strong ) UITextField * textFieldPhone;
@property (nonatomic ,strong ) UITextField * textFieldCode;
@property (nonatomic ,strong ) UITextField * textFieldPsw;
@property (nonatomic ,strong ) UITextField * textFieldName;

@property (nonatomic ,strong) UILabel * getCodeLab;
@property (nonatomic ,assign) int remainingTime;
@property (nonatomic ,retain) dispatch_source_t timer;


@end
