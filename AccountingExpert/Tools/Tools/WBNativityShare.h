//
//  WBNativityShare.h
//  ToolFramework
//
//  Created by Apple on 2018/2/6.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  iOS原生分享
 **/

@interface WBNativityShare : NSObject

/**
 *  par:是一个NSDictionary对象，其中包括()：
 *  shareTitle://标题--默认Share
 *  shareImage://分享的图片名称--默认APPIcon
 *  shareUrl: 分享的链接 -- 默认@""
 *  PS:这三个par中对应的Key值可以不全部传递
 
 **/
+ (void)WBSystemCallShareWithController:(UIViewController *)contorller par:(NSDictionary *)par;

@end
