//
//  WorkerListCell.h
//  Water
//
//  Created by KouHao on 15/12/17.
//  Copyright © 2015年 KH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkerListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNumLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *peopleNameLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UIButton *scanButton;

@end
