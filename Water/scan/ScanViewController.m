//
//  ScanViewController.m
//  assistant
//
//  Created by QEEMO on 14/12/24.
//  Copyright (c) 2014年 QEEMO. All rights reserved.
//

#import "ScanViewController.h"
#import "QBTools.h"

@interface ScanViewController ()<UIAlertViewDelegate>

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"扫一扫";
    // Do any additional setup after loading the view from its nib.
//    [self initView];

}

- (void)initView
{
    
    self.view.backgroundColor = RGBACOLOR(40, 46, 56, 1.0);
//    UIButton * scanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [scanButton setTitle:@"取消" forState:UIControlStateNormal];
////    [scanButton setTintColor:[TableBar getColor:@"30acc8"]];
//    scanButton.frame = CGRectMake(100, 420, 120, 40);
//    [scanButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:scanButton];
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(0, 275+20, MYWIDTH, 50)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.numberOfLines=2;
    labIntroudction.textColor = RGBACOLOR(189, 197, 208, 1.0);
    labIntroudction.text=@"将二维码放入框内，即可自动扫描";
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.font = [UIFont systemFontOfSize:14.0];
//    labIntroudction.textColor = [UIColor iOS7blueGradientStartColor];
    [self.view addSubview:labIntroudction];
    
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(MYWIDTH/2-110, 50+20, 220, 220)];
    imageView.image = [UIImage imageNamed:@"scanFrame"];
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake((MYWIDTH - 217)/2.0, 60+20, 217, 2)];
    _line.image = [UIImage imageNamed:@"scanLine"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.02f target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
}


-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake((MYWIDTH - 217)/2.0, 60+20+2*num, 217, 2);
        if (2*num == 200) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake((MYWIDTH - 217)/2.0, 60+20+2*num, 217, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}
-(void)backAction
{
    
//    [self dismissViewControllerAnimated:YES completion:^{
//        [timer invalidate];
//    }];
    [timer invalidate];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView*view in self.view.subviews) {
        [view removeFromSuperview];
    }
    [self initView];
    [self setUpCamera];
}

-(void)setUpCamera
{
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    self.output = [[AVCaptureMetadataOutput alloc]init];
//    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
//     self.outPut.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    //限制扫描区域（上左下右）
    [_output setRectOfInterest:CGRectMake(70/MYHEIGHT,((MYWIDTH-220)/2)/MYWIDTH,220/MYHEIGHT,220/MYWIDTH)];
//    [_output setRectOfInterest:CGRectMake(114,(MYWIDTH-220)/2,220/MYHEIGHT,220/MYWIDTH)];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    self.session = [[AVCaptureSession alloc]init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:self.input])
    { [self.session addInput:self.input]; }
    if ([self.session canAddOutput:self.output])
    { [self.session addOutput:self.output]; }
    
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = self.view.layer.bounds;//CGRectMake(MYWIDTH/2-110,50,220,220);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    [self.session startRunning];
    if ([self.output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
        
//        self.output.metadataObjectTypes = [NSArray arrayWithObject:AVMetadataObjectTypeQRCode];//只扫描二维码
        self.output.metadataObjectTypes = [NSArray arrayWithObjects:AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code,nil];//二维码 条形码均可扫描
        
        
        
    }
//    self.output.metadataObjectTypes = [NSArray arrayWithObjects:AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code,nil];
}

- (void)setupCamera//扫描条形码时候添加的方法  不需要条形码功能注释即可
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeAztecCode];
//availableMetadataObjectTypes
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = self.view.layer.bounds;//CGRectMake(20,110,280,280);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    // Start
    [_session startRunning];
}


#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        NSLog(@"stringValue ___ %@",stringValue);
        UIAlertView*altV = [[UIAlertView alloc] initWithTitle:@"扫描结果" message:stringValue delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认安装", nil];

        [altV show];
    
        [timer invalidate];
    }
    [_session stopRunning];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_output setMetadataObjectsDelegate:nil queue:dispatch_get_main_queue()];
    self.view=nil;
//    _preview=nil;
//    _session=nil;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        //确认安装
    }
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
