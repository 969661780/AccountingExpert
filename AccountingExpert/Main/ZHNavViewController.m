//
//  ZHNavViewController.m
//  AccountingExpert
//
//  Created by mt y on 2018/6/19.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "ZHNavViewController.h"
#import "UIBarButtonItem+Extension.h"

@interface ZHNavViewController ()

@end

@implementation ZHNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+ (void)initialize {
    [self setupNavigationBar];
    [self setupBarBtnItem];
}

+ (void)setupNavigationBar {
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"Navigation-Bar"] forBarMetrics:UIBarMetricsDefault];
    //移除导航栏黑线
    navBar.translucent = NO;
    [navBar  setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[[UIImage alloc] init]];
    // title
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSForegroundColorAttributeName] = ZHTitleColor;
    attrDict[NSFontAttributeName] = ZHFontSize(18);
    [navBar setTitleTextAttributes:attrDict];
}

+(void)setupBarBtnItem {
    UIBarButtonItem *barBtnItem = [UIBarButtonItem appearance];
    // nor
    NSMutableDictionary *norAttrDict = [NSMutableDictionary dictionary];
    norAttrDict[NSForegroundColorAttributeName] = ZHTitleColor;
    norAttrDict[NSFontAttributeName] = ZHFontSize(18);
    [barBtnItem setTitleTextAttributes:norAttrDict forState:UIControlStateNormal];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        // 默认每个push进来的控制器左右都有返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"返回" highImage:@"返回"];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > 0) {
            obj.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back" highImage:@"back"];
            obj.hidesBottomBarWhenPushed = YES;
        }
    }];
    [super setViewControllers:viewControllers animated:animated];
}
- (void)back
{
     [self popToRootViewControllerAnimated:YES];
}

@end
