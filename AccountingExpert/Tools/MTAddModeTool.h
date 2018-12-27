//
//  MTAddModeTool.h
//  AccountingExpert
//
//  Created by mt y on 2018/6/21.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTAddModeTool : NSObject
+ (NSMutableArray *)getAddIncomeMode;
+(void)putArrIncomeTo:(NSArray *)arr;
+ (NSMutableArray *)getAddExpenceMode;
+(void)putArrExpenceeTo:(NSArray *)arr;
@end
