//
//  MTHomeViewController.m
//  AccountingExpert
//
//  Created by mt y on 2018/6/19.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "MTHomeViewController.h"
#import "MTHomeTableViewCell.h"
#import "MTHomeDateTableViewCell.h"
#import "MTFootView.h"
#import "MTAddModeTool.h"
#import "MTMoneyMode.h"
#import <Masonry.h>
@interface MTHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *BalanceLable;
@property (weak, nonatomic) IBOutlet UILabel *InconmeLable;
@property (weak, nonatomic) IBOutlet UILabel *ExpenseLable;
@property (weak, nonatomic) IBOutlet UILabel *leftLable;
@property (weak, nonatomic) IBOutlet UILabel *centerLable;
@property (weak, nonatomic) IBOutlet UILabel *rightLable;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIButton *totleMoeyBtn;
@property (weak, nonatomic) IBOutlet UIButton *incomeMoneyBtn;
@property (weak, nonatomic) IBOutlet UIButton *expenceMoneyBtn;
@property (weak, nonatomic) IBOutlet UILabel *leftTLable;
@property (weak, nonatomic) IBOutlet UILabel *centerClable;
@property (weak, nonatomic) IBOutlet UILabel *rightELable;

@property (nonatomic, strong)NSMutableDictionary *catoryInComeDic;
@property (nonatomic, strong)NSMutableDictionary *catoryExpenceDic;
@property (nonatomic, strong)NSMutableDictionary *catoryAllDic;
@property (nonatomic, assign)NSInteger btnSeleced;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentddd;
@property (nonatomic, copy)NSString *balanceMoneyStr;//余额
@property (nonatomic, copy)NSString *allMoneyStr;//总额
@property (nonatomic, copy)NSString *incomeMoneyStr;//收入额
@property (nonatomic, copy)NSString *expenceMoneyStr;//支出额
@property (nonatomic, strong)NSMutableDictionary *goodImageDic;
@property (nonatomic, strong)UIView *noData;
@property (nonatomic, strong)UIImageView *imageVIew;
@property (nonatomic, strong)UILabel *abe;
@end

@implementation MTHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Record Expert";
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MTHomeTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MTHomeTableViewCell class])];
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MTHomeDateTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MTHomeDateTableViewCell class])];
    [self.myTableView registerClass:[MTFootView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([MTFootView class])];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.btnSeleced = 0;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.contentddd.constant = 200;
    }
}
- (void)addNoDateView
{
    CHKit_WeakSelf
//    self.noData.frame = CGRectMake(self.myTableView.x, self.myTableView.y, ZHScreenW, self.myTableView.height);
    [self.view addSubview:self.noData];
    [self.noData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.myTableView);
        make.width.bottom.equalTo(self.view);
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
- (IBAction)btnttt:(id)sender {
    self.tabBarController.selectedIndex = 1;
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
        if (mode.addName) {
            [expenceKeysArr addObject:mode.addName];
        }else{
            [incomeKeysArr addObject:@"Daily"];
        }
        
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
                [valuArr addObject:mode1];
            }
        }];
        [addExpenceCategoryArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            MTMoneyMode *mode1 = (MTMoneyMode *)obj;
            if ([mode1.addName isEqualToString:mode]) {
                [valuArr addObject:mode1];
            }
        }];
        [self.catoryAllDic setValue:valuArr forKey:mode];
    }
    
    self.BalanceLable.text = self.balanceMoneyStr;
    self.InconmeLable.text = self.incomeMoneyStr;
    self.ExpenseLable.text = self.expenceMoneyStr;
    self.leftLable.text = self.allMoneyStr;
    self.rightLable.text = self.expenceMoneyStr;
    self.centerLable.text = self.incomeMoneyStr;
    if (self.catoryAllDic.count == 0 || !self.catoryAllDic.count) {
        [self renoveDataView];
        [self addNoDateView];
    }else{
        [self renoveDataView];
    }
    [self.myTableView reloadData];
}
#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_btnSeleced == 0) {
      return  self.catoryAllDic.count;
    }else if (_btnSeleced == 1){
        return self.catoryInComeDic.count;
    }else{
        return self.catoryExpenceDic.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_btnSeleced == 0) {
        NSArray *allKeys = [self.catoryAllDic allKeys];
        NSArray *arr = [self.catoryAllDic objectForKey:allKeys[section]];
        return  arr.count + 1;
    }else if (_btnSeleced == 1){
        NSArray *allKeys = [self.catoryInComeDic allKeys];
        NSArray *arr = [self.catoryInComeDic objectForKey:allKeys[section]];
        return  arr.count + 1;
    }else{
        NSArray *allKeys = [self.catoryExpenceDic allKeys];
        NSArray *arr = [self.catoryExpenceDic  objectForKey:allKeys[section]];
        return  arr.count + 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MTHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTHomeTableViewCell class]) forIndexPath:indexPath];
        if (_btnSeleced == 0) {
            NSArray *allKeys = [self.catoryAllDic allKeys];
            cell.goodImage.image = [UIImage imageNamed:self.goodImageDic[allKeys[indexPath.section]]];
            __block NSInteger moneyInAll = 0;
            __block NSInteger moneyExAll = 0;
            [self.catoryInComeDic.allValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                for (MTMoneyMode *modee in obj) {
                    if ([modee.addName isEqualToString:allKeys[indexPath.section]]) {
                        moneyInAll += [modee.addMoney integerValue];
                    }
                }
            }];
            [self.catoryExpenceDic.allValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                for (MTMoneyMode *modee in obj) {
                    if ([modee.addName isEqualToString:allKeys[indexPath.section]]) {
                        moneyExAll += [modee.addMoney integerValue];
                    }
                }
            }];
            cell.nameLable.text = allKeys[indexPath.section];
            cell.incomeLable.text = [NSString stringWithFormat:@"+%ld",moneyInAll];
            cell.exoensesLable.text = [NSString stringWithFormat:@"-%ld",moneyExAll];
        }else if (_btnSeleced == 1){
             __block NSInteger moneyInAll = 0;
            [self.catoryInComeDic.allValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                for (MTMoneyMode *modee in obj) {
                    if ([modee.addName isEqualToString:self.catoryInComeDic.allKeys[indexPath.section]]) {
                        moneyInAll += [modee.addMoney integerValue];
                    }
                }
            }];
            cell.goodImage.image = [UIImage imageNamed:self.goodImageDic[self.catoryInComeDic.allKeys[indexPath.section]]];
            cell.nameLable.text = self.catoryInComeDic.allKeys[indexPath.section];
            cell.incomeLable.text = [NSString stringWithFormat:@"+%ld",moneyInAll];
            cell.exoensesLable.text = [NSString stringWithFormat:@"-%d",0];
        }else{
             __block NSInteger moneyExAll = 0;
            [self.catoryExpenceDic.allValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                for (MTMoneyMode *modee in obj) {
                    if ([modee.addName isEqualToString:self.catoryExpenceDic.allKeys[indexPath.section]]) {
                        moneyExAll += [modee.addMoney integerValue];
                    }
                    
                }
            }];
            cell.goodImage.image = [UIImage imageNamed:self.goodImageDic[self.catoryExpenceDic.allKeys[indexPath.section]]];
            cell.nameLable.text = self.catoryExpenceDic.allKeys[indexPath.section];
            cell.incomeLable.text = [NSString stringWithFormat:@"+%d",0];
            cell.exoensesLable.text = [NSString stringWithFormat:@"-%ld",moneyExAll];
        }
        
        return cell;
    }else{
        MTHomeDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTHomeDateTableViewCell class]) forIndexPath:indexPath];
        if (_btnSeleced == 0) {
            NSArray *allKeys = [self.catoryAllDic allKeys];
            [self.catoryInComeDic.allValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                for (MTMoneyMode *modee in obj) {
                    if ([modee.addName isEqualToString:allKeys[indexPath.section]]) {
                        cell.dataLable.text = [self.catoryAllDic[allKeys[indexPath.section]][indexPath.row-1] addDate];
                        cell.moneyLable.text = [NSString stringWithFormat:@"+%@",[self.catoryAllDic[allKeys[indexPath.section]][indexPath.row-1] addMoney]];
                    }
                }
            }];
            [self.catoryExpenceDic.allValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                for (MTMoneyMode *modee in obj) {
                    if ([modee.addName isEqualToString:allKeys[indexPath.section]]) {
                        for (MTMoneyMode *modeee in self.catoryExpenceDic[modee.addName]) {
                            if ([modeee.addMoney isEqualToString:[self.catoryAllDic[allKeys[indexPath.section]][indexPath.row-1] addMoney]]) {
                                cell.dataLable.text = [self.catoryAllDic[allKeys[indexPath.section]][indexPath.row-1] addDate];
                                cell.moneyLable.text = [NSString stringWithFormat:@"-%@",[self.catoryAllDic[allKeys[indexPath.section]][indexPath.row-1] addMoney]];
                            }
                        }
                      
                    }
                }
            }];
           
        }else if (_btnSeleced == 1){
            NSArray *allKeys = [self.catoryInComeDic allKeys];
            NSArray *arr = self.catoryInComeDic[allKeys[indexPath.section]];
            MTMoneyMode *mode = arr[indexPath.row - 1];
            cell.dataLable.text = mode.addDate;
            cell.moneyLable.text = [NSString stringWithFormat:@"+%@",mode.addMoney];
        }else{
            NSArray *allKeys = [self.catoryExpenceDic allKeys];
            NSArray *arr = self.catoryExpenceDic[allKeys[indexPath.section]];
            MTMoneyMode *mode = arr[indexPath.row - 1];
            cell.dataLable.text = mode.addDate;
            cell.moneyLable.text = [NSString stringWithFormat:@"-%@",mode.addMoney];
        }
        return cell;
    }
}
#pragma mark -UITableViewDelegate
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
#pragma mark -touchs
- (IBAction)biliBtn:(id)sender {
    
}
- (IBAction)lookBtn:(id)sender {
    
}
- (IBAction)totalBtn:(id)sender {
    self.btnSeleced = 0;
    if (self.catoryAllDic.count == 0 || !self.catoryAllDic) {
        [self renoveDataView];
        [self addNoDateView];
    }else{
        [self renoveDataView];
    }
    [sender setBackgroundColor:UIColorWithRGB(0xF3FDFF)];
    [self.incomeMoneyBtn setBackgroundColor:[UIColor whiteColor]];
    [self.expenceMoneyBtn setBackgroundColor:[UIColor whiteColor]];
    self.leftLable.textColor = UIColorWithRGB(0x43C0DE);
    self.leftTLable.textColor = UIColorWithRGB(0x43C0DE);
    self.centerLable.textColor = UIColorWithRGB(0x999999);
    self.centerClable.textColor = UIColorWithRGB(0x999999);
    self.rightLable.textColor = UIColorWithRGB(0x999999);
    self.rightELable.textColor = UIColorWithRGB(0x999999);
    [self.myTableView reloadData];
}
- (IBAction)incomeBtn:(id)sender {
    self.btnSeleced = 1;
    if (self.catoryInComeDic.count == 0 || !self.catoryAllDic) {
        [self renoveDataView];
        [self addNoDateView];
    }else{
        [self renoveDataView];
    }
     [sender setBackgroundColor:UIColorWithRGB(0xF3FDFF)];
    [self.totleMoeyBtn setBackgroundColor:[UIColor whiteColor]];
    [self.expenceMoneyBtn setBackgroundColor:[UIColor whiteColor]];
    self.leftLable.textColor = UIColorWithRGB(0x999999);
    self.leftTLable.textColor = UIColorWithRGB(0x999999);
    self.centerLable.textColor = UIColorWithRGB(0x43C0DE);
    self.centerClable.textColor = UIColorWithRGB(0x43C0DE);
    self.rightLable.textColor = UIColorWithRGB(0x999999);
    self.rightELable.textColor = UIColorWithRGB(0x999999);
    [self.myTableView reloadData];
    
}
- (IBAction)expenseBtn:(id)sender {
    self.btnSeleced = 2;
    if (self.catoryExpenceDic.count == 0 || !self.catoryAllDic) {
        [self renoveDataView];
        [self addNoDateView];
    }else{
        [self renoveDataView];
    }
     [sender setBackgroundColor:UIColorWithRGB(0xF3FDFF)];
    [self.incomeMoneyBtn setBackgroundColor:[UIColor whiteColor]];
    [self.totleMoeyBtn setBackgroundColor:[UIColor whiteColor]];
    self.leftLable.textColor = UIColorWithRGB(0x999999);
    self.leftTLable.textColor = UIColorWithRGB(0x999999);
    self.centerLable.textColor = UIColorWithRGB(0x999999);
    self.centerClable.textColor = UIColorWithRGB(0x999999);
    self.rightLable.textColor = UIColorWithRGB(0x43C0DE);
    self.rightELable.textColor = UIColorWithRGB(0x43C0DE);
    [self.myTableView reloadData];
}
#pragma mark -getter
- (UIView *)noData{
    if (!_noData) {
        _noData = [UIView new];
        _noData.backgroundColor = ZHBackgroundColor;
         self.imageVIew= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1313"]];
       
//        imageVIew.frame = CGRectMake(self.myTableView.width/2 - 54, self.myTableView.height/2 - 32, 128, 84);
        [_noData addSubview:self.imageVIew];
         self.abe= [UILabel new];
        self.abe.text = @"No Data";
        self.abe.textColor = [UIColor grayColor];
      
//        abe.frame = CGRectMake(imageVIew.x+ 15, imageVIew.y+imageVIew.height + 10, imageVIew.width, 50);
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
- (NSMutableDictionary *)goodImageDic
{
    if (!_goodImageDic) {
        _goodImageDic = [[NSMutableDictionary alloc] initWithObjects:@[@"组1",@"组2",@"组3",@"组4",@"组5",@"组6",@"组7",@"组8",@"组9",@"组10",@"组11",@"组12",@"组13",@"组14",@"组15",@"组16",@"组17",@"组18",@"组19"] forKeys:@[@"Daily",@"Catering",@"Shopping",@"Car",@"Apparel",@"Beauty",@"Entertainment",@"Sports",@"Home",@"Fruit",@"Vegetables",@"Books",@"Snacks",@"Party",@"Holidays",@"Electronics",@"Kids",@"Elders",@" Friends"]];
    }
    return _goodImageDic;
}
@end
