//
//  UIView+Extension.m
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setLeft:(CGFloat)left
{
    self.x = left;
}

- (CGFloat)left
{
    return self.x;
}

- (void)setTop:(CGFloat)top
{
    self.y = top;
}

- (CGFloat)top
{
    return self.y;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return CGRectGetMaxY(self.frame);
}

+ (UIView *)addLineWithFrame:(CGRect)frame WithView:(UIView *)view
{
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = ZHLineColor;
    [view addSubview:lineView];
    
    return lineView;
}

+ (UIView *)addLineBackGroundWithFrame:(CGRect)frame color:(UIColor*)color WithView:(UIView *)view
{
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = color;
    [view addSubview:lineView];
    
    return lineView;
}

///创建一个view的对象
+(UIView*)CreateViewWithFrame:(CGRect)frame BackgroundColor:(UIColor*)color InteractionEnabled:(BOOL)enabled{
    
    UIView * view=[[UIView alloc]initWithFrame:frame];
    view.backgroundColor=color;
    view.userInteractionEnabled=enabled;
    return view;
}

- (void)showNoDataImageInView:(UIView *)view withImage:(NSString *)imageName title:(NSString *)title{
    
    [self removeImageView:view];
    
    view.backgroundColor = ZHBackgroundColor;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, ZHFit(115), ZHFit(150), ZHFit(150))];
    imageView.size = CGSizeMake(ZHFit(150), ZHFit(150));
    imageView.centerX = view.centerX;
    imageView.image=[UIImage imageNamed:imageName];
    [view addSubview:imageView];
    imageView.tag=1000;
    
    UILabel *lable = [[UILabel alloc] init];
    lable.text = imageName;
    lable.tag = 1000;
    lable.textColor = ZHSubTitleColor;
    lable.font = ZHFontSize(18);
    [lable sizeToFit];
    lable.centerX = view.centerX;
    lable.centerY = imageView.bottom + ZHFit(15);
    [view addSubview:lable];
    
    UILabel *subLabel = [[UILabel alloc] init];
    subLabel.text = title;
    subLabel.tag = 1000;
    subLabel.textColor = [UIColor lightGrayColor];
    subLabel.font = ZHFontSize(15);
    [subLabel sizeToFit];
    subLabel.centerX = view.centerX;
    subLabel.centerY = lable.bottom + ZHFit(20);
    [view addSubview:subLabel];

}

- (void)hideNoDataImageInView:(UIView *)view{
    
    [self removeImageView:view];
    
}

- (void)removeImageView:(UIView *)view{
    
    //按照tag值进行移除
    for (UIImageView *subView in view.subviews) {
        
        if (subView.tag == 1000) {
            
            [subView removeFromSuperview];
        }
    }
}


@end
