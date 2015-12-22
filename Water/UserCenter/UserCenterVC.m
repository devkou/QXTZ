//
//  UserCenterVC.m
//  Water
//
//  Created by JW on 15/12/13.
//  Copyright © 2015年 KH. All rights reserved.
//

#import "UserCenterVC.h"
#import "UserCenterFirstCell.h"
#import <UIImageView+WebCache.h>
#import "QBTools.h"
#import "LoginViewController.h"
#import "UserModel.h"

@interface UserCenterVC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic ,strong) UIImageView * headerImageV;
@property (nonatomic ,strong) UIButton * goOutBtn;


@end

@implementation UserCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.scrollEnabled = NO;
    
    _goOutBtn = [[UIButton alloc] initWithFrame:CGRectMake(12, MYHEIGHT - 64 - 52, MYWIDTH-24, 44)];
    [_goOutBtn setBackgroundColor:RGBACOLOR(57, 127, 198, 1)];
    [_goOutBtn addTarget:self action:@selector(goOutBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_goOutBtn setTitle:@"退出登陆" forState:UIControlStateNormal];
    [_goOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_goOutBtn];
    
    _goOutBtn.clipsToBounds = YES;
    _goOutBtn.layer.cornerRadius = 4;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

- (void)getHeader{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [actionSheet showInView:self.view];
}


- (void)goOutBtn:(UIButton*)sender{
    //退出登陆 清理用户数据
    [[UserModel currentUser] deleteSavedUserInfo];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController*loginNav = [mainStoryboard instantiateViewControllerWithIdentifier:@"loginNav"];
    loginNav.navigationBar.tintColor = [UIColor whiteColor];
//    [UIApplication sharedApplication].keyWindow.rootViewController = loginNav;
    [self.navigationController presentViewController:loginNav animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        UserCenterFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCenterFirstCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        [cell.headImgV sd_setImageWithURL:[NSURL URLWithString:@"http://v1.qzone.cc/avatar/201308/22/10/36/521579394f4bb419.jpg!200x200.jpg"] placeholderImage:[UIImage imageNamed:@"header.png"]];
        
        UITapGestureRecognizer * headerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getHeader)];
        [cell.headImgV addGestureRecognizer:headerTap];
        [cell.headImgV setUserInteractionEnabled:YES];
        self.headerImageV = cell.headImgV;
        
        cell.nameLab.text = [UserModel currentUser].realName;
        cell.phoneLab.text =[NSString stringWithFormat:@"手机号码:%@",[UserModel currentUser].mobile];
        
        return cell;
    }else{
        static NSString *cellIdentify = @"CellIdentify";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
        if (!cell)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.textLabel.text = @"我的订单";
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        
        return cell;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 60;
    }else return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return CGFLOAT_MIN;
    }
    else return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}


- (IBAction)select:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark  UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        
    }
    
    switch (buttonIndex)
    {
        case 0:  //打开本地相册
            [self takePhoto];
            break;
        case 1:  //打开照相机拍照
            [self LocalPhoto];
            break;
    }
}

//开始拍照
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        // [self presentModalViewController:picker animated:YES];
        [self presentViewController:picker animated:YES completion:^{}];
    }else
    {
        //  NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

//打开本地相册
-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    // [self presentModalViewController:picker animated:YES];
    [self presentViewController:picker animated:YES completion:^{}];
}

#pragma mark UIImagePickerControllerDelegate UINavigationControllerDelegate

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];

        
        NSData *data= UIImageJPEGRepresentation(image, 0.1);
        
        
        //图片保存的路径
        //这里将图片放在沙盒的documents文件夹中
        NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        //文件管理器
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
        [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
        //得到选择后沙盒中图片的完整路径
        // filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];
        
        //关闭相册界面
        self.headerImageV.image = image;
        [picker dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    // NSLog(@"您取消了选择图片");
    //  [picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:^{}];
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
