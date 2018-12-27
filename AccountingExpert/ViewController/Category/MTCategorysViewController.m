//
//  MTCategorysViewController.m
//  AccountingExpert
//
//  Created by mt y on 2018/6/21.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "MTCategorysViewController.h"
#import "PGGDropView.h"
#import "MTCategoryTableViewCell.h"
#import <SVProgressHUD.h>
@interface MTCategorysViewController ()<PGGDropDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *selecedBtn;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property(strong,nonatomic)PGGDropView * dropView;
@property (nonatomic, strong)NSMutableDictionary *goodImageDic;
@property (nonatomic, strong)NSMutableDictionary *incomeDic;
@property (nonatomic, strong)NSMutableDictionary *expressDic;
@end

@implementation MTCategorysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Edit Category";
    [self.myTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MTCategoryTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MTCategoryTableViewCell class])];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button sizeToFit];
    button.frame = CGRectMake(10, 5, 100, 35);
    [button setTitle:@"Finish" forState:0];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    NSMutableDictionary *incomeDic = [[[NSUserDefaults standardUserDefaults] objectForKey:IncomeCategory] mutableCopy];
    NSMutableDictionary *expenceDic = [[[NSUserDefaults standardUserDefaults] objectForKey:ExpenceCategory] mutableCopy];
    if (incomeDic) {
        self.incomeDic = incomeDic;
    }else{
        self.incomeDic = self.goodImageDic;
    }
    if (expenceDic) {
        self.expressDic = expenceDic;
    }else{
        self.expressDic = self.goodImageDic;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)rightBack
{
     if (self.dropView.btncilke == 0) {
         [[NSUserDefaults standardUserDefaults] setObject:self.incomeDic forKey:IncomeCategory];
         [[NSUserDefaults standardUserDefaults] synchronize];
     }else{
         [[NSUserDefaults standardUserDefaults] setObject:self.expressDic forKey:ExpenceCategory];
         [[NSUserDefaults standardUserDefaults] synchronize];
     }
    [SVProgressHUD showSuccessWithStatus:@"Edited successfully"];
    [SVProgressHUD dismissWithDelay:2.0];
}
- (IBAction)btnSeleced:(UIButton *)sender {
    self.dropView = [[PGGDropView alloc] initWithFrame:CGRectMake(sender.x, sender.y+sender.height ,sender.width, 200) withTitleArray:@[@"Income",@"Expenses"]];
    [self.dropView beginAnimation];
    self.dropView.delegate = self;
    [self.view addSubview:self.dropView];
}
- (void)PGGDropView:(PGGDropView *)DropView didSelectAtIndex:(NSInteger )index{
    NSArray *arr = [NSArray arrayWithObjects:@"Income",@"Expenses", nil];
    [self.selecedBtn setTitle:arr[index-100] forState:UIControlStateNormal];
    [self.myTableView reloadData];
}
- (void)selecedBtn1:(UIButton *)btn
{
    NSArray *allKeys = self.goodImageDic.allKeys;
    if (self.dropView.btncilke == 0) {
        NSArray *incomeArr = self.incomeDic.allKeys;
        if ([incomeArr containsObject:allKeys[btn.tag - 10000]]) {
            [btn setBackgroundImage:[UIImage imageNamed:@"圆形未选中状态"] forState:UIControlStateNormal];
            [self.incomeDic removeObjectForKey:allKeys[btn.tag - 10000]];
        }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"圆形选中状态"] forState:UIControlStateNormal];
            [self.incomeDic setValue:self.goodImageDic[allKeys[btn.tag - 10000]] forKey:allKeys[btn.tag - 10000]];
        }
        
       
    }else{
         NSArray *incomeArr = self.expressDic.allKeys;
        if ([incomeArr containsObject:allKeys[btn.tag - 10000]]) {
            [btn setBackgroundImage:[UIImage imageNamed:@"圆形未选中状态"] forState:UIControlStateNormal];
            [self.expressDic removeObjectForKey:allKeys[btn.tag - 10000]];
        }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"圆形选中状态"] forState:UIControlStateNormal];
            [self.expressDic setValue:self.goodImageDic[allKeys[btn.tag - 10000]] forKey:allKeys[btn.tag - 10000]];
        }
       
    }
}
#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.goodImageDic.allKeys.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MTCategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MTCategoryTableViewCell class]) forIndexPath:indexPath];
    cell.goodImageView.image = [UIImage imageNamed:self.goodImageDic.allValues[indexPath.row]];
    cell.nameLable.text = self.goodImageDic.allKeys[indexPath.row];
    cell.btnSeleced.tag = 10000 + indexPath.row;
    NSArray *allKeys = self.goodImageDic.allKeys;
    if (self.dropView.btncilke == 0) {
        NSArray *incomeArr = self.incomeDic.allKeys;
        if ([incomeArr containsObject:allKeys[indexPath.row]]) {
            [cell.btnSeleced setBackgroundImage:[UIImage imageNamed:@"圆形选中状态"] forState:UIControlStateNormal];
        }else{
            [cell.btnSeleced setBackgroundImage:[UIImage imageNamed:@"圆形未选中状态"] forState:UIControlStateNormal];
        }
    }else{
        NSArray *incomeArr = self.expressDic.allKeys;
        if ([incomeArr containsObject:allKeys[indexPath.row]]) {
            [cell.btnSeleced setBackgroundImage:[UIImage imageNamed:@"圆形选中状态"] forState:UIControlStateNormal];
        }else{
            [cell.btnSeleced setBackgroundImage:[UIImage imageNamed:@"圆形未选中状态"] forState:UIControlStateNormal];
        }
    }
    [cell.btnSeleced addTarget:self action:@selector(selecedBtn1:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
#pragma mark -getter
- (NSMutableDictionary *)goodImageDic
{
    if (!_goodImageDic) {
        _goodImageDic = [[NSMutableDictionary alloc] initWithObjects:@[@"组1",@"组2",@"组3",@"组4",@"组5",@"组6",@"组7",@"组8",@"组9",@"组10",@"组11",@"组12",@"组13",@"组14",@"组15",@"组16",@"组17",@"组18",@"组19"] forKeys:@[@"Daily",@"Catering",@"Shopping",@"Car",@"Apparel",@"Beauty",@"Entertainment",@"Sports",@"Home",@"Fruit",@"Vegetables",@"Books",@"Snacks",@"Party",@"Holidays",@"Electronics",@"Kids",@"Elders",@" Friends"]];
    }
    return _goodImageDic;
}
- (NSMutableDictionary *)incomeDic
{
    if (!_incomeDic) {
        _incomeDic = [NSMutableDictionary new];
    }
    return _incomeDic;
}
- (NSMutableDictionary *)expressDic
{
    if (!_expressDic) {
        _expressDic = [NSMutableDictionary new];
    }
    return _expressDic;
}
@end
