//
//  MTAddViewController.m
//  AccountingExpert
//
//  Created by mt y on 2018/6/19.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "MTAddViewController.h"
#import "MTAddCollectionViewCell.h"
#import "PGGDropView.h"
#import "MTAddModeTool.h"
#import "MTMoneyMode.h"
#import <SVProgressHUD.h>
@interface MTAddViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,PGGDropDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property(strong,nonatomic)PGGDropView * dropView;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (nonatomic, strong)NSMutableDictionary *goodImageDic;
@property (nonatomic, strong)NSMutableDictionary *incomeDic;
@property (nonatomic, strong)NSMutableDictionary *expressDic;
@property (weak, nonatomic) IBOutlet UITextField *inputText;
@property (nonatomic, copy)NSString *selecedStr;
@property (nonatomic, strong)NSMutableArray *addIncomeArr;
@property (nonatomic, strong)NSMutableArray *addExpenseArr;
@end

@implementation MTAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Add";
    [self.myCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MTAddCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MTAddCollectionViewCell class])];
    self.myCollectionView.dataSource = self;
    self.myCollectionView.delegate = self;
    
    NSMutableDictionary *incomeDic = [[[NSUserDefaults standardUserDefaults] objectForKey:IncomeCategory] mutableCopy];
    NSMutableDictionary *expenceDic = [[[NSUserDefaults standardUserDefaults] objectForKey:ExpenceCategory] mutableCopy];
    NSMutableArray *addIncomeCategoryArr = [MTAddModeTool getAddIncomeMode];
    NSMutableArray *addExpenceCategoryArr = [MTAddModeTool getAddExpenceMode];
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
    if (addIncomeCategoryArr) {
        self.addIncomeArr = addIncomeCategoryArr;
    }
    if (addExpenceCategoryArr) {
        self.addExpenseArr = addExpenceCategoryArr;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 
- (IBAction)btnSelected:(UIButton *)sender {
    self.dropView = [[PGGDropView alloc] initWithFrame:CGRectMake(sender.x, sender.y+sender.height ,sender.width, 200) withTitleArray:@[@"Income",@"Expenses"]];
    [self.dropView beginAnimation];
    self.dropView.delegate = self;
    [self.view addSubview:self.dropView];
}
- (void)PGGDropView:(PGGDropView *)DropView didSelectAtIndex:(NSInteger )index{
    NSArray *arr = [NSArray arrayWithObjects:@"Income",@"Expenses", nil];
    [self.selectBtn setTitle:arr[index-100] forState:UIControlStateNormal];
    [self.myCollectionView reloadData];
}
- (IBAction)finishBtn:(UIButton *)sender {
    if (self.inputText.text && [self.inputText.text integerValue] != 0) {
        MTMoneyMode *mode = [MTMoneyMode new];
        mode.addMoney = self.inputText.text;
        self.inputText.text = @"";
        mode.addName = self.selecedStr;
        mode.addDate = [self getCurrentTimes];
        if (self.dropView.btncilke == 0) {
            [self.addIncomeArr addObject:mode];
            [MTAddModeTool putArrIncomeTo:self.addIncomeArr];
        }else{
            [self.addExpenseArr addObject:mode];
            [MTAddModeTool putArrExpenceeTo:self.addExpenseArr];
        }
        [SVProgressHUD showSuccessWithStatus:@"Successful record"];
        [SVProgressHUD dismissWithDelay:2.0];
        [self.inputText endEditing:YES];
    }
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.dropView.btncilke == 0) {
        return self.incomeDic.count;
    }else{
        return self.expressDic.count;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MTAddCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MTAddCollectionViewCell class]) forIndexPath:indexPath];
    if (self.dropView.btncilke == 0) {
        NSArray *nameKeys = self.incomeDic.allKeys;
        NSArray *nameVlales = self.incomeDic.allValues;
        cell.imgeView.image = [UIImage imageNamed:nameVlales[indexPath.row]];
        cell.nameLable.text = nameKeys[indexPath.row];
    }else{
        NSArray *nameKeys = self.expressDic.allKeys;
        NSArray *nameVlales = self.expressDic.allValues;
        cell.imgeView.image = [UIImage imageNamed:nameVlales[indexPath.row]];
        cell.nameLable.text = nameKeys[indexPath.row];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(80, 60);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dropView.btncilke == 0) {
        NSArray *nameKeys = self.incomeDic.allKeys;
        self.inputText.placeholder = nameKeys[indexPath.row];
        self.selecedStr = nameKeys[indexPath.row];
    }else{
        NSArray *nameKeys = self.expressDic.allKeys;
        self.inputText.placeholder = nameKeys[indexPath.row];
        self.selecedStr = nameKeys[indexPath.row];
    }
}
-(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
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
- (NSMutableArray *)addIncomeArr
{
    if (!_addIncomeArr) {
        _addIncomeArr = [NSMutableArray new];
    }
    return _addIncomeArr;
}
- (NSMutableArray *)addExpenseArr
{
    if (!_addExpenseArr) {
        _addExpenseArr = [NSMutableArray new];
    }
    return _addExpenseArr;
}
@end
