//
//  AppDelegate.m
//  AccountingExpert
//
//  Created by mt y on 2018/6/19.
//  Copyright © 2018年 mt y. All rights reserved.
//

#import "AppDelegate.h"

#import "MTAddViewController.h"
#import "MTHomeViewController.h"
#import "MTCardsViewController.h"
#import "MTChartViewController.h"
#import "MTSettingViewController.h"
#import "ZHNavViewController.h"
#import <IQKeyboardManager.h>
#import "LLTabBar.h"

@interface AppDelegate ()<LLTabBarDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    ZHNavViewController *nav1 = [[ZHNavViewController alloc] initWithRootViewController:[MTHomeViewController new]];
    ZHNavViewController *nav2 = [[ZHNavViewController alloc] initWithRootViewController:[MTChartViewController new]];
    ZHNavViewController *nav4 = [[ZHNavViewController alloc] initWithRootViewController:[MTCardsViewController new]];
    ZHNavViewController *nav5 = [[ZHNavViewController alloc] initWithRootViewController:[MTSettingViewController new]];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[nav1, nav2, nav4, nav5];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    LLTabBar *tabBar = [[LLTabBar alloc] initWithFrame:tabBarController.tabBar.bounds];
    
    tabBar.tabBarItemAttributes = @[@{kLLTabBarItemAttributeTitle : @"Home", kLLTabBarItemAttributeNormalImageName : @"1", kLLTabBarItemAttributeSelectedImageName : @"1xz", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                    @{kLLTabBarItemAttributeTitle : @"Chart", kLLTabBarItemAttributeNormalImageName : @"2", kLLTabBarItemAttributeSelectedImageName : @"2xz", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                    @{kLLTabBarItemAttributeTitle : @"Add", kLLTabBarItemAttributeNormalImageName : @"加号", kLLTabBarItemAttributeSelectedImageName : @"加号", kLLTabBarItemAttributeType : @(LLTabBarItemRise)},
                                    @{kLLTabBarItemAttributeTitle : @"Cards", kLLTabBarItemAttributeNormalImageName : @"3", kLLTabBarItemAttributeSelectedImageName : @"3xz", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                    @{kLLTabBarItemAttributeTitle : @"Setting", kLLTabBarItemAttributeNormalImageName : @"4", kLLTabBarItemAttributeSelectedImageName : @"4xz", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)}];
    tabBar.delegate = self;
    [tabBarController.tabBar addSubview:tabBar];
    //5. 集成键盘库
    [self setKeyBoard];
    
    self.window.rootViewController = tabBarController;
    return YES;
}
#pragma mark -键盘
- (void)setKeyBoard
{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    keyboardManager.shouldShowTextFieldPlaceholder = YES; // 是否显示占位文字
    
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
    
    
}
- (void)tabBarDidSelectedRiseButton {
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    ZHNavViewController *viewController = tabBarController.selectedViewController;
    MTAddViewController *con = [MTAddViewController new];
    [viewController pushViewController:con animated:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
