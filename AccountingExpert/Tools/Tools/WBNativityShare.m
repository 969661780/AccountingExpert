//
//  WBNativityShare.m
//  ToolFramework
//
//  Created by Apple on 2018/2/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "WBNativityShare.h"

@implementation WBNativityShare

/**
 *  par:是一个NSDictionary对象，其中包括()：
 *  shareTitle://标题--默认share
 *  shareImage://分享的图片名称--默认APPIcon
 *  shareUrl: 分享的链接 -- 默认@""
 *  PS:这三个par中对应的Key值可以全部传递
 
 **/
+ (void)WBSystemCallShareWithController:(UIViewController *)contorller par:(NSDictionary *)par
{
    //分享的标题
    NSString *textToShare = @"Record Expert";
    //分享的图片
    UIImage *imageToShare = [UIImage imageNamed:@"AppIcon"];
    //分享的url
    NSURL *urlToShare = [NSURL URLWithString:@""];
    
    if ([par objectForKey:@"shareTitle"]) {
        textToShare = [par objectForKey:@"shareTitle"];
    }
    if ([par objectForKey:@"shareImage"]) {
        imageToShare = [UIImage imageNamed:[par objectForKey:@"shareImage"]];
    }
    if ([par objectForKey:@"shareUrl"]) {
        urlToShare = [NSURL URLWithString:[par objectForKey:@"shareUrl"]];;
    }
    
    
    
    
    //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
    NSArray *activityItems = @[textToShare, urlToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    //不出现在活动项目
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    //
    [contorller presentViewController:activityVC animated:YES completion:nil];
    // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            NSLog(@"completed");
            //分享 成功
        } else  {
            NSLog(@"cancled");
            //分享 取消
        }
    };
    
    NSLog(@"activityItems:%@",activityItems);
}

@end
