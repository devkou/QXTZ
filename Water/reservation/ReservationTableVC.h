//
//  ReservationTableVC.h
//  Water
//
//  Created by JW on 15/12/12.
//  Copyright © 2015年 KH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReservationTableVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *OKButton;

- (IBAction)selcsct:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
