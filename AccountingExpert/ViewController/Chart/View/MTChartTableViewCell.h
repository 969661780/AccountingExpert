//
//  MTChartTableViewCell.h
//  AccountingExpert
//
//  Created by mt y on 2018/6/20.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTChartTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *topLable;
@property (weak, nonatomic) IBOutlet UILabel *moneyLable;
@property (weak, nonatomic) IBOutlet UIProgressView *ProgressVIew;

@end
