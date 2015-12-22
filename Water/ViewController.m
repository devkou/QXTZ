//
//  ViewController.m
//  Water
//
//  Created by gs on 15/12/10.
//  Copyright © 2015年 KH. All rights reserved.
//

#import "ViewController.h"
#import "QBTools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    self.navigationItem.titleView = [QBTools getNavBarTitleLabWithStr:@"首页" stringColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen  mainScreen].bounds.size.width, [UIScreen  mainScreen].bounds.size.height-64-45-14 )];
    self.webView.scalesPageToFit = YES;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL  URLWithString:@"http://h.hiphotos.baidu.com/image/pic/item/8d5494eef01f3a2982fc03349d25bc315c607c10.jpg"]];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [self.webView loadRequest:request];
    //禁止回弹
    [(UIScrollView *)[[self.webView subviews] objectAtIndex:0] setBounces:NO];
    [self.view addSubview: self.webView];
    
    [self.button setBackgroundColor:RGBACOLOR(57, 127, 198, 1)];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.button.clipsToBounds = YES;
    self.button.layer.cornerRadius = 4;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
