//
//  UIView+Extension.h
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

/** 控件最左边那根线的位置(minX的位置) */
@property (nonatomic, assign) CGFloat left;

/** 控件最右边那根线的位置(maxX的位置) */
@property (nonatomic, assign) CGFloat right;

/** 控件最顶部那根线的位置(minY的位置) */
@property (nonatomic, assign) CGFloat top;

/** 控件最底部那根线的位置(maxY的位置) */
@property (nonatomic, assign) CGFloat bottom;

//添加一根线
+ (UIView *)addLineWithFrame:(CGRect)frame WithView:(UIView *)view;

/**
 添加一个背景色可变的宽线
 */
+ (UIView *)addLineBackGroundWithFrame:(CGRect)frame color:(UIColor*)color WithView:(UIView *)view;

/**  没有数据时的显示的图片 */
- (void)showNoDataImageInView:(UIView *)view withImage:(NSString *)imageName title:(NSString *)title;
- (void)hideNoDataImageInView:(UIView *)view;

///创建一个view的对象
+(UIView*)CreateViewWithFrame:(CGRect)frame BackgroundColor:(UIColor*)color InteractionEnabled:(BOOL)enabled;

@end
