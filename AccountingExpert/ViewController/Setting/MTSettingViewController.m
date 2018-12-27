//
//  MTSettingViewController.m
//  AccountingExpert
//
//  Created by mt y on 2018/6/19.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "MTSettingViewController.h"

#import "MTCategorysViewController.h"
#import "WBNativityShare.h"
#import <Social/Social.h>
#import <SVProgressHUD.h>

@interface MTSettingViewController ()

@end

@implementation MTSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Setting";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)oneBtn:(id)sender {
    [self.navigationController pushViewController:[MTCategorysViewController new] animated:YES];
}
- (IBAction)twoBtn:(id)sender {
}
- (IBAction)threeBtn:(id)sender {
//    // 设置分享内容
//    NSString *text = @"分享内容";
//    NSArray *activityItems = @[text];
//
//    // 服务类型控制器
//    UIActivityViewController *activityViewController =
//    [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
//    activityViewController.modalInPopover = true;
//    [self presentViewController:activityViewController animated:YES completion:nil];
//
//    // 选中分享类型
//    [activityViewController setCompletionWithItemsHandler:^(NSString * __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError){
//
//        // 显示选中的分享类型
//        NSLog(@"act type %@",activityType);
//
//        if (completed) {
//            [SVProgressHUD showSuccessWithStatus:@"share OK"];
//
//        }else {
//           [SVProgressHUD showSuccessWithStatus:@"share OK"];
//        }
//
//    }];
    
//    1402682615
    NSString *appid = @"1402682615";
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",appid];
    
    
    NSDictionary *par = @{@"shareUrl":url};
    [WBNativityShare WBSystemCallShareWithController:self par:par];
    
}
- (IBAction)fomeBtn:(id)sender {
}

@end
