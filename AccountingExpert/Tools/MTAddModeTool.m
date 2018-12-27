//
//  MTAddModeTool.m
//  AccountingExpert
//
//  Created by mt y on 2018/6/21.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "MTAddModeTool.h"

@implementation MTAddModeTool
+ (NSMutableArray *)getAddIncomeMode
{
    NSData *arrData = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/AddIncomeCategory.plist"]];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:arrData];
    NSArray *DataArr = [unarchiver decodeObjectForKey:AddIncomeCategoryarchiver];
    NSMutableArray *myDataAr = [NSMutableArray arrayWithArray:DataArr];
    return myDataAr;
}
+(void)putArrIncomeTo:(NSArray *)arr
{
    NSMutableData *mudata = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mudata];
    [archiver encodeObject:arr forKey:AddIncomeCategoryarchiver];
    [archiver finishEncoding];
    [mudata writeToFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/AddIncomeCategory.plist"] atomically:YES];
}
+ (NSMutableArray *)getAddExpenceMode
{
    NSData *arrData = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/AddExpenceCategory.plist"]];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:arrData];
    NSArray *DataArr = [unarchiver decodeObjectForKey:AddExpenceCategoryarchiver];
    NSMutableArray *myDataAr = [NSMutableArray arrayWithArray:DataArr];
    return myDataAr;
}
+(void)putArrExpenceeTo:(NSArray *)arr
{
    NSMutableData *mudata = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mudata];
    [archiver encodeObject:arr forKey:AddExpenceCategoryarchiver];
    [archiver finishEncoding];
    [mudata writeToFile:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/AddExpenceCategory.plist"] atomically:YES];
}
@end
