//
//  MTCategoryTableViewCell.h
//  AccountingExpert
//
//  Created by mt y on 2018/6/21.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTCategoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UIButton *btnSeleced;
@end
