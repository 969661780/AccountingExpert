//
//  MTCardsViewController.m
//  AccountingExpert
//
//  Created by mt y on 2018/6/19.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "MTCardsViewController.h"
#import "MTCardsTableViewCell.h"

@interface MTCardsViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *moneyLable;
@property (nonatomic, strong)NSMutableArray *moneyArr;
@end

@implementation MTCardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationItem.title = @"Cards";
     [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MTCardsTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MTCardsTableViewCell class])];
    self.myTableView.rowHeight = 80;
    NSMutableArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:cardMoney];
    if (arr) {
        self.moneyArr = [arr mutableCopy];
        self.moneyLable.text = [NSString stringWithFormat:@"+%ld",[self.moneyArr[4] integerValue]];
    }else{
        self.moneyLable.text = @"+0";
    }
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTCardsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTCardsTableViewCell class]) forIndexPath:indexPath];
    cell.myMoney.delegate = self;
    cell.myMoney.tag = indexPath.row + 1000;
    switch (indexPath.row) {
        case 0:
            cell.backImageView.image = [UIImage imageNamed:@"1cards"];
            cell.myLable.text = @"Cash";
            if ([self.moneyArr[0] integerValue] == 0) {
                cell.myMoney.text = @"";
            }else{
                cell.myMoney.text = [NSString stringWithFormat:@"%ld",[self.moneyArr[0] integerValue]];
            }
            break;
        case 1:
            cell.backImageView.image = [UIImage imageNamed:@"2cards"];
            cell.myLable.text = @"Bank Card";
            if ([self.moneyArr[1] integerValue] == 0) {
                cell.myMoney.text = @"";
            }else{
                cell.myMoney.text = [NSString stringWithFormat:@"%ld",[self.moneyArr[1] integerValue]];
            }
            break;
        case 2:
            cell.backImageView.image = [UIImage imageNamed:@"3cards"];
            cell.myLable.text = @"VIP Card";
            if ([self.moneyArr[2] integerValue] == 0) {
                cell.myMoney.text = @"";
            }else{
                cell.myMoney.text = [NSString stringWithFormat:@"%ld",[self.moneyArr[2] integerValue]];
            }
            break;
        case 3:
            cell.backImageView.image = [UIImage imageNamed:@"4cards"];
            cell.myLable.text = @"Shopping Card";
            if ([self.moneyArr[3] integerValue] == 0) {
                cell.myMoney.text = @"";
            }else{
                cell.myMoney.text = [NSString stringWithFormat:@"%ld",[self.moneyArr[3] integerValue]];
            }
            break;
        default:
            break;
    }
    return cell;
}
- (void)textFieldDidEndEditing :(UITextField *)textField {
    
    NSString *text = [textField text];
    switch (textField.tag) {
        case 1000:
             [self.moneyArr replaceObjectAtIndex:0 withObject:@([text integerValue])];
            break;
        case 1001:
              [self.moneyArr replaceObjectAtIndex:1 withObject:@([text integerValue])];
            break;
        case 1002:
              [self.moneyArr replaceObjectAtIndex:2 withObject:@([text integerValue])];
            break;
        case 1003:
              [self.moneyArr replaceObjectAtIndex:3 withObject:@([text integerValue])];
            break;
        default:
            break;
    }
    
    __block NSInteger allmoney = 0;
    [self.moneyArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != 4) {
             allmoney += [obj integerValue];
        }
    }];
    self.moneyLable.text = [NSString stringWithFormat:@"+%ld",allmoney];
    [self.moneyArr setObject:@(allmoney) atIndexedSubscript:4];
    [[NSUserDefaults standardUserDefaults] setObject:self.moneyArr forKey:cardMoney];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark -getter
- (NSMutableArray *)moneyArr
{
    if (!_moneyArr) {
        _moneyArr = [[NSMutableArray alloc] initWithObjects:@0,@0,@0,@0,@0, nil];
    }
    return _moneyArr;
}
@end
