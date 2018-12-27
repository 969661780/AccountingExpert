//
//  MTCardsTableViewCell.h
//  AccountingExpert
//
//  Created by mt y on 2018/6/20.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTCardsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UITextField *myMoney;
@property (weak, nonatomic) IBOutlet UILabel *myLable;

@end
