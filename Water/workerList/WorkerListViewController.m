//
//  WorkerListViewController.m
//  Water
//
//  Created by KouHao on 15/12/17.
//  Copyright © 2015年 KH. All rights reserved.
//

#import "WorkerListViewController.h"
#import "WorkerListCell.h"
#import "QBTools.h"
#import "MJRefresh.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ScanViewController.h"
#import "LoginViewController.h"
#import "HttpRequestManager.h"
#import "UserModel.h"

@interface WorkerListViewController ()

@end

@implementation WorkerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.titleView = [QBTools getNavBarTitleLabWithStr:@"我的派单" stringColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MYWIDTH, CGFLOAT_MIN)];
    [self setupRefresh];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (IBAction)gogogo:(UIBarButtonItem *)sender {
    //退出登陆 清理用户数据
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController*loginNav = [mainStoryboard instantiateViewControllerWithIdentifier:@"loginNav"];
    loginNav.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController presentViewController:loginNav animated:YES completion:nil];
}

- (void)setupRefresh
{
    [self homeRefresh];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)homeRefresh
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    [header.arrowView setHidden:YES];
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    self.tableView.mj_footer = footer;
}

-(void)headerRefreshing
{
    self.tableView.mj_footer.hidden = NO;
//    self.nowPage = 1;
    [self request];
}

- (void)footerRereshing
{
//    self.nowPage ++;
    [self request];
}

-(void)stopRereshing{
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
    
}

- (void)request{
    //请求
    [self stopRereshing];
    NSMutableDictionary*parameters = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parameters setObject:[UserModel currentUser].nickName forKey:@"nickName"];

    [HttpRequestManager POST:WORKER_ORDER_LIST parameters:parameters block:^(BOOL isSucceed, id responseObject, NSError *error) {
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
//    // 变为没有更多数据的状态
//    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)scanButtonClick:(UIButton*)btn{
    //扫码安装
    NSLog(@"扫码安装 扫码安装 %d",btn.tag);
    ScanViewController*scanVC = [[ScanViewController alloc] init];
    [self.navigationController pushViewController:scanVC animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"WorkerListCell";
    WorkerListCell *cell = (WorkerListCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"WorkerListCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
        cell = (WorkerListCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    cell.orderNumLab.text = @"2015A1B1333322226666C609";
    cell.timeLab.text = [NSString stringWithFormat:@"预定时间%@",[QBTools getDateForStringTime:@"195738674" withFormat:@"yyyy-MM-dd"]];
    cell.addressLab.text = @"浙江省杭州市江干区市民中心5楼30321室";
    cell.peopleNameLab.text = [NSString stringWithFormat:@"联系人：%@",@"豪哥V5"];
    cell.phoneLab.text = [NSString stringWithFormat:@"联系电话：%@",@"13868685555"];
    [cell.imgV sd_setImageWithURL:[NSURL URLWithString:@"http://online.sccnn.com/img2/5890/p151210-15.png"] placeholderImage:[UIImage imageNamed:@"header"]];
    [cell.scanButton addTarget:self action:@selector(scanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.scanButton.tag = indexPath.section;
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

@end
