//
//  ReservationTableVC.m
//  Water
//
//  Created by JW on 15/12/12.
//  Copyright © 2015年 KH. All rights reserved.
//

#import "ReservationTableVC.h"
#import "ReservationCell.h"
#import "QBTools.h"

@interface ReservationTableVC ()<UITextFieldDelegate>

@property (nonatomic ,strong) UITextField * textFieldName;
@property (nonatomic ,strong) UITextField * textFieldPhone;
@property (nonatomic ,strong) UITextField * textFieldAddress;
@property (nonatomic ,strong) UITextField * textFieldDetailAddress;

@end

@implementation ReservationTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    
    [self.OKButton setBackgroundColor:RGBACOLOR(57, 127, 198, 1)];
    [self.OKButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.OKButton.clipsToBounds = YES;
    self.OKButton.layer.cornerRadius = 4;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

- (IBAction)selcsct:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)okClcik:(UIButton *)sender {
    //确定 订单 确定 订单
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row<=3) {
        ReservationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReservationCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textField.delegate = self;
        if (indexPath.row==0) {
            cell.titleLab.text = @"联系人姓名";
            cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            self.textFieldName = cell.textField;
        }
        if (indexPath.row==1) {
            cell.titleLab.text = @"联系电话";
            cell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            self.textFieldPhone = cell.textField;
        }
        if (indexPath.row==2) {
            cell.titleLab.text = @"安装地址";
            cell.textField.placeholder = @"点击选择所在地区";
            self.textFieldAddress = cell.textField;
        }
        if (indexPath.row==3) {
            [cell.titleLab setHidden:YES];
            cell.textField.placeholder = @"输入您的详细地址";
            self.textFieldDetailAddress = cell.textField;
        }
        return cell;
    }else {
        static NSString *cellIdentify = @"CellIdentify";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        return cell;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
