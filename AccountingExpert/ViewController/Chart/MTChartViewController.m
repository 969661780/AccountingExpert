//
//  MTChartViewController.m
//  AccountingExpert
//
//  Created by mt y on 2018/6/19.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "MTChartViewController.h"
#import "WSPieChart.h"
#import "MTMoneyMode.h"
#import "MTChartTableViewCell.h"
#import "MTChatBingTableViewCell.h"
#import "MTAddModeTool.h"
#import "MTFootView.h"
#import "PGGDropView.h"
#import <Masonry.h>
@interface MTChartViewController ()<UITableViewDelegate,UITableViewDataSource,PGGDropDelegate>
@property (weak, nonatomic) IBOutlet UIView *backBingView;
@property (weak, nonatomic) IBOutlet UILabel *topLable;
@property (weak, nonatomic) IBOutlet UILabel *leftLable;
@property (weak, nonatomic) IBOutlet UILabel *rightLable;
@property (weak, nonatomic) IBOutlet UITableView *mytableView;
@property (nonatomic, copy)NSString *balanceMoneyStr;//余额
@property (nonatomic, copy)NSString *allMoneyStr;//总额
@property (nonatomic, copy)NSString *incomeMoneyStr;//收入额
@property (nonatomic, copy)NSString *expenceMoneyStr;//支出额
@property (nonatomic, strong)NSMutableDictionary *catoryInComeDic;
@property (nonatomic, strong)NSMutableDictionary *catoryExpenceDic;
@property (nonatomic, strong)NSMutableDictionary *catoryAllDic;
@property (weak, nonatomic) IBOutlet UIButton *catgoreyBtn;
@property (nonatomic, strong)NSMutableDictionary *catoryMoeyComeDic;
@property (nonatomic, strong)NSMutableDictionary *catoryMoeyExpenceDic;
@property (nonatomic, assign)NSInteger moneyIncome;
@property (nonatomic, strong)NSMutableDictionary *goodImageDic;
@property (nonatomic, assign)NSInteger moneyExpence;
@property(strong,nonatomic)PGGDropView * dropView;
@property (nonatomic, strong)WSPieChart *pie;
@property (nonatomic, strong)UIView *noData;
@property (nonatomic, strong)UIImageView *imageVIew;
@property (nonatomic, strong)UILabel *abe;
@end

@implementation MTChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Chart";
    [self.mytableView registerNib:[UINib nibWithNibName:NSStringFromClass([MTChartTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MTChartTableViewCell class])];
    [self.mytableView registerNib:[UINib nibWithNibName:NSStringFromClass([MTChatBingTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MTChatBingTableViewCell class])];
    self.mytableView.delegate = self;
    self.mytableView.dataSource = self;

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSMutableArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:cardMoney];
    if (arr) {
        self.balanceMoneyStr = [NSString stringWithFormat:@"+%ld",[arr[4] integerValue]];
    }else{
        self.balanceMoneyStr = @"+0";
    }
    
    NSMutableArray *addIncomeCategoryArr = [MTAddModeTool getAddIncomeMode];
    NSMutableArray *addExpenceCategoryArr = [MTAddModeTool getAddExpenceMode];
    
    NSMutableSet *incomeKeysArr = [NSMutableSet new];
    NSMutableSet *expenceKeysArr = [NSMutableSet new];
    NSMutableSet *allKeysArr = [NSMutableSet new];
    __block NSInteger incomeMoney = 0 ;
    __block NSInteger expenceMoney = 0 ;
    [addIncomeCategoryArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MTMoneyMode *mode = (MTMoneyMode *)obj;
        if (mode.addName) {
            [incomeKeysArr addObject:mode.addName];
            [allKeysArr addObject:mode.addName];
        }else{
            [incomeKeysArr addObject:@"Daily"];
            [allKeysArr addObject:@"Daily"];
        }
       
        incomeMoney += [mode.addMoney integerValue];
    }];
    self.incomeMoneyStr = [NSString stringWithFormat:@"+%ld",incomeMoney];
    [addExpenceCategoryArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MTMoneyMode *mode = (MTMoneyMode *)obj;
        [expenceKeysArr addObject:mode.addName];
        [allKeysArr addObject:mode.addName];
        expenceMoney += [mode.addMoney integerValue];
    }];
    self.expenceMoneyStr = [NSString stringWithFormat:@"-%ld",expenceMoney];
    if ((incomeMoney - expenceMoney) > 0) {
        self.allMoneyStr = [NSString stringWithFormat:@"+%ld",(incomeMoney - expenceMoney)];
    }else{
        self.allMoneyStr = [NSString stringWithFormat:@"-%ld",(expenceMoney - incomeMoney)];
    }
    for (NSString *mode1 in incomeKeysArr) {
        NSMutableArray *valuArr = [NSMutableArray new];
        [addIncomeCategoryArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MTMoneyMode *mode = (MTMoneyMode *)obj;
            if ([mode.addName isEqualToString:mode1]) {
                [valuArr addObject:mode];
            }
        }];
        [self.catoryInComeDic setValue:valuArr forKey:mode1];
    }
    for (NSString *mode1 in expenceKeysArr) {
        NSMutableArray *valuArr = [NSMutableArray new];
        [addExpenceCategoryArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MTMoneyMode *mode = (MTMoneyMode *)obj;
            if ([mode.addName isEqualToString:mode1]) {
                [valuArr addObject:mode];
            }
        }];
        [self.catoryExpenceDic setValue:valuArr forKey:mode1];
    }
    for (NSString *mode in allKeysArr) {
        NSMutableArray *valuArr = [NSMutableArray new];
        [addIncomeCategoryArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MTMoneyMode *mode1 = (MTMoneyMode *)obj;
            if ([mode1.addName isEqualToString:mode]) {
                [valuArr addObject:mode];
            }
        }];
        [addExpenceCategoryArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MTMoneyMode *mode1 = (MTMoneyMode *)obj;
            if ([mode1.addName isEqualToString:mode]) {
                [valuArr addObject:mode];
            }
        }];
        [self.catoryAllDic setValue:valuArr forKey:mode];
    }
    
    self.topLable.text = self.balanceMoneyStr;
    self.leftLable.text = self.allMoneyStr;
    self.rightLable.text = self.expenceMoneyStr;
    self.moneyIncome = 0;
    for (int i= 0; i< self.catoryInComeDic.allKeys.count; i++) {
        __block NSInteger moneyInAll = 0;
        [self.catoryInComeDic.allValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            for (MTMoneyMode *modee in obj) {
                if ([modee.addName isEqualToString:self.catoryInComeDic.allKeys[i]]) {
                    moneyInAll += [modee.addMoney integerValue];
                }
            }
        }];
        self.moneyIncome += moneyInAll;
        [self.catoryMoeyComeDic setValue:@(moneyInAll) forKey:self.catoryInComeDic.allKeys[i]];
    }
    if (self.catoryAllDic.count == 0 || !self.catoryAllDic.count) {
        [self renoveDataView];
        [self addNoDateView];
    }else{
        [self renoveDataView];
        [self.pie removeFromSuperview];
        
    }
    [self.mytableView reloadData];
}
- (void)addNoDateView
{
    CHKit_WeakSelf
    self.noData.frame = CGRectMake(0, self.catgoreyBtn.y+self.catgoreyBtn.height, ZHScreenW, ZHScreenH);
    [self.view addSubview:self.noData];
    [self.noData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.mytableView);
        make.top.equalTo(self.mytableView).offset(20);
        make.bottom.equalTo(self.view);
    }];
    [self.imageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weak_self.noData);
        make.centerY.equalTo(weak_self.noData).offset(-15);
    }];
    [self.abe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weak_self.noData);
        make.top.equalTo(self.imageVIew.mas_bottom);
    }];
    
}
- (void)renoveDataView
{
    [self.noData removeFromSuperview];
}
- (IBAction)incomeBtn:(UIButton *)sender {
    self.dropView = [[PGGDropView alloc] initWithFrame:CGRectMake(sender.x, sender.y+sender.height ,sender.width, 200) withTitleArray:@[@"Income",@"Expenses"]];
    [self.dropView beginAnimation];
    self.dropView.delegate = self;
    [self.view addSubview:self.dropView];
}
- (void)PGGDropView:(PGGDropView *)DropView didSelectAtIndex:(NSInteger )index{
    NSArray *arr = [NSArray arrayWithObjects:@"Income",@"Expenses", nil];
    [self.catgoreyBtn setTitle:arr[index-100] forState:UIControlStateNormal];
    if (index == 100) {
        self.moneyIncome = 0;
        for (int i= 0; i< self.catoryInComeDic.allKeys.count; i++) {
            __block NSInteger moneyInAll = 0;
            [self.catoryInComeDic.allValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                for (MTMoneyMode *modee in obj) {
                    if ([modee.addName isEqualToString:self.catoryInComeDic.allKeys[i]]) {
                        moneyInAll += [modee.addMoney integerValue];
                    }
                }
            }];
            self.moneyIncome += moneyInAll;
            [self.catoryMoeyComeDic setValue:@(moneyInAll) forKey:self.catoryInComeDic.allKeys[i]];
        }
//        [self.mytableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//        [self.pie removeFromSuperview];
//         [self.backBingView addSubview:self.pie];
//        self.pie.valueArr = self.catoryMoeyComeDic.allValues;
//        self.pie.descArr = self.catoryMoeyComeDic.allKeys;
//         self.pie.showDescripotion = YES;
//        [self.pie showAnimation];
    }else{
        self.moneyExpence = 0;
        for (int i= 0; i< self.catoryExpenceDic.allKeys.count; i++) {
            __block NSInteger moneyInAll = 0;
            [self.catoryExpenceDic.allValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                for (MTMoneyMode *modee in obj) {
                    if ([modee.addName isEqualToString:self.catoryExpenceDic.allKeys[i]]) {
                        moneyInAll += [modee.addMoney integerValue];
                    }
                }
            }];
            self.moneyExpence += moneyInAll;
            [self.catoryMoeyExpenceDic setValue:@(moneyInAll) forKey:self.catoryExpenceDic.allKeys[i]];
        }
        
//        [self.pie removeFromSuperview];
//         [self.backBingView addSubview:self.pie];

//         self.pie.showDescripotion = YES;
//        [self.pie showAnimation];
    }
    
    [self.mytableView reloadData];
}
#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     if (self.dropView.btncilke == 0) {
         return self.catoryMoeyComeDic.allKeys.count+1;
     }else{
         return self.catoryMoeyExpenceDic.allKeys.count+1;
     }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.row == 0) {
         MTChatBingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTChatBingTableViewCell class]) forIndexPath:indexPath];
        [cell addSubview:self.pie];
        if (self.dropView.btncilke == 0) {
            self.pie.valueArr = self.catoryMoeyComeDic.allValues;
            self.pie.descArr = self.catoryMoeyComeDic.allKeys;
        }else{
            self.pie.valueArr = self.catoryMoeyExpenceDic.allValues;
            self.pie.descArr = self.catoryMoeyExpenceDic.allKeys;
        }
        self.pie.showDescripotion = YES;
        [self.pie showAnimation];
        return cell;
    }else{
         MTChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTChartTableViewCell class]) forIndexPath:indexPath];
        if (self.dropView.btncilke == 0) {
            cell.leftImageView.image = [UIImage imageNamed:self.goodImageDic[self.catoryMoeyComeDic.allKeys[indexPath.row-1]]] ;
            cell.topLable.text = self.catoryMoeyComeDic.allKeys[indexPath.row-1];
            cell.moneyLable.text = [NSString stringWithFormat:@"+%ld",[self.catoryMoeyComeDic.allValues[indexPath.row-1] integerValue]];
            cell.ProgressVIew.tintColor = self.pie.colorArr[(indexPath.row-1)%self.pie.colorArr.count];
            cell.ProgressVIew.progress = [self.catoryMoeyComeDic.allValues[indexPath.row-1] floatValue]/self.moneyIncome;
            
        }else{
            cell.leftImageView.image = [UIImage imageNamed:self.goodImageDic[self.catoryMoeyExpenceDic.allKeys[indexPath.row-1]]] ;
            cell.topLable.text = self.catoryMoeyExpenceDic.allKeys[indexPath.row-1];
            cell.moneyLable.text = [NSString stringWithFormat:@"-%ld",[self.catoryMoeyExpenceDic.allValues[indexPath.row-1] integerValue]];
            cell.ProgressVIew.tintColor = self.pie.colorArr[(indexPath.row-1)%self.pie.colorArr.count];
            cell.ProgressVIew.progress = [self.catoryMoeyExpenceDic.allValues[indexPath.row-1] floatValue]/self.moneyExpence;
        }
        return cell;
    }
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 300;
    }
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        MTFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([MTFootView class])];
        footView.backgroundColor = ZHBackgroundColor;
        return footView;
    }
    return nil;
}
#pragma mark -getter
- (UIView *)noData{
    if (!_noData) {
        _noData = [UIView new];
        _noData.backgroundColor = ZHBackgroundColor;
        self.imageVIew = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1313"]];
//        imageVIew.frame = CGRectMake(ZHScreenW/2 - 74, (ZHScreenH-120)/2 - 100, 128, 84);
        [_noData addSubview:self.imageVIew];
        self.abe = [UILabel new];
        self.abe.text = @"No Data";
        self.abe.textColor = [UIColor grayColor];
//        self.abe.frame = CGRectMake(imageVIew.x+ 30, imageVIew.y+imageVIew.height, imageVIew.width, 50);
        [_noData addSubview:self.abe];
    }
    return _noData;
}
- (NSMutableDictionary *)catoryInComeDic
{
    if (!_catoryInComeDic) {
        _catoryInComeDic = [NSMutableDictionary new];
    }
    return _catoryInComeDic;
}
- (NSMutableDictionary *)catoryExpenceDic
{
    if (!_catoryExpenceDic) {
        _catoryExpenceDic = [NSMutableDictionary new];
    }
    return _catoryExpenceDic;
}
- (NSMutableDictionary *)catoryAllDic
{
    if (!_catoryAllDic) {
        _catoryAllDic = [NSMutableDictionary new];
    }
    return _catoryAllDic;
}
- (NSMutableDictionary *)catoryMoeyComeDic
{
    if (!_catoryMoeyComeDic) {
        _catoryMoeyComeDic = [NSMutableDictionary new];
    }
    return _catoryMoeyComeDic;
}
- (NSMutableDictionary *)catoryMoeyExpenceDic
{
    if (!_catoryMoeyExpenceDic) {
        _catoryMoeyExpenceDic = [NSMutableDictionary new];
    }
    return _catoryMoeyExpenceDic;
}
- (WSPieChart *)pie
{
    if (!_pie) {
        _pie = [[WSPieChart alloc] initWithFrame:CGRectMake(0 , 20, ZHScreenW, 270)];
        _pie.showDescripotion = NO;
        _pie.backgroundColor = [UIColor whiteColor];
       
    }
    return _pie;
}
- (NSMutableDictionary *)goodImageDic
{
    if (!_goodImageDic) {
        _goodImageDic = [[NSMutableDictionary alloc] initWithObjects:@[@"组1",@"组2",@"组3",@"组4",@"组5",@"组6",@"组7",@"组8",@"组9",@"组10",@"组11",@"组12",@"组13",@"组14",@"组15",@"组16",@"组17",@"组18",@"组19"] forKeys:@[@"Daily",@"Catering",@"Shopping",@"Car",@"Apparel",@"Beauty",@"Entertainment",@"Sports",@"Home",@"Fruit",@"Vegetables",@"Books",@"Snacks",@"Party",@"Holidays",@"Electronics",@"Kids",@"Elders",@" Friends"]];
    }
    return _goodImageDic;
}
@end
