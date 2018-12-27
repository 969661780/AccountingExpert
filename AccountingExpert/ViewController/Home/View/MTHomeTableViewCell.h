//
//  MTHomeTableViewCell.h
//  AccountingExpert
//
//  Created by mt y on 2018/6/20.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTHomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *incomeLable;
@property (weak, nonatomic) IBOutlet UILabel *exoensesLable;

@end
