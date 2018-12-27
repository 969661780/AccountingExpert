//
//  PGGDropView.m
//  PGGdrop-down menu PGGDropdownMenu
//
//  Created by 陈鹏 on 2017/11/12.
//  Copyright © 2017年 penggege.CP. All rights reserved.
//代码地址 https://github.com/penghero/PGGdrop-down-menu-PGGDropdownMenu.git

#import "PGGDropView.h"
#define IMG_TAG 110
#define    kScreen_Width [UIScreen mainScreen].bounds.size.width
#define    kScreen_Height [UIScreen mainScreen].bounds.size.height

@interface PGGDropView ()

@property(nonatomic,strong)NSArray *array;

@property(nonatomic,assign)CGRect bgFrame;

@property(nonatomic,strong)UIScrollView *bgView;

@end

@implementation PGGDropView

- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray<NSString *> *)array
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    if (self)
        {
        self.array      = array;
        self.bgFrame    = frame;
        [self configView];
        }
    return self;
}

- (void)configView
{
    if (self.bgFrame.size.height > 40 * self.array.count + 15)
        {
        self.bgFrame            = CGRectMake(self.bgFrame.origin.x, self.bgFrame.origin.y, self.bgFrame.size.width, 40 * self.array.count + 15);
        }
        //    默认高度
    CGFloat height              = 40;
    UIImageView *imageView      = [[UIImageView alloc]initWithFrame:self.bgFrame];
    imageView.tag               = IMG_TAG;
    UIImage *image              = [UIImage imageNamed:@"orderBlack"];
    imageView.image             = [image stretchableImageWithLeftCapWidth:40 topCapHeight:40];
    [self addSubview:imageView];
    
    self.bgView                 = [[UIScrollView alloc]initWithFrame:self.bgFrame];
    self.bgView.backgroundColor = ZHBackgroundColor;
    self.bgView.contentSize     = CGSizeMake(self.bgFrame.size.width, height * self.array.count + 15);
    [self addSubview:_bgView];
    
    [self.array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn           = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame               = CGRectMake(self.bgFrame.size.width, idx * height + 15, self.bgFrame.size.width - 20, height - 0.3);
        btn.titleLabel.font     = [UIFont systemFontOfSize:16];
        btn.tag                 = idx + 100;
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.titleEdgeInsets     = UIEdgeInsetsMake(0, 10, 0, 0);
//        [btn setBackgroundColor:[UIColor blueColor]];
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:btn];
        
        UIView *line            = [[UIView alloc]initWithFrame:CGRectMake(self.bgFrame.size.width, idx * height + 39.7 + 15, self.bgFrame.size.width - 20, 0.3)];
        line.tag                = idx + 200;
        line.backgroundColor    = [UIColor whiteColor];
        [_bgView addSubview:line];
    }];
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    UIImageView *imageView      = [self viewWithTag:IMG_TAG];
    imageView.image = image;
}

- (void)btnClick:(UIButton *)btn
{
//    点击回调
     self.btncilke = btn.tag - 100;
    if ([self.delegate respondsToSelector:@selector(PGGDropView:didSelectAtIndex:)]) {
        [self.delegate PGGDropView:self didSelectAtIndex:btn.tag];
       
    }
    [self dismiss];
}

- (void)beginAnimation
{
    [self.array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn           = [_bgView viewWithTag:idx + 100];
        UIView   *line          = [_bgView viewWithTag:idx + 200];
        btn.frame               = CGRectMake(self.bgFrame.size.width, idx * 40 + 15, self.bgFrame.size.width, 39.7);
        line.frame              = CGRectMake(self.bgFrame.size.width, idx * 40 + 15 + 39.7, self.bgFrame.size.width - 20, 0.3);
        [UIView animateWithDuration:0.3 + 0.05 * idx
                              delay:0.1
             usingSpringWithDamping:0.9
              initialSpringVelocity:1
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             btn.frame      = CGRectMake(10, idx * 40 + 15, 130, 40 - 0.3);
                             line.frame     = CGRectMake(10, idx * 40 + 39.7 + 15, self.bgFrame.size.width - 20, 0.3);
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    }];
    UIImageView *imageView      = [self viewWithTag:IMG_TAG];
    imageView.frame             = CGRectMake(self.bgFrame.origin.x, self.bgFrame.origin.y, self.bgFrame.size.width, 20);
    
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:0.9
          initialSpringVelocity:1
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         imageView.frame = self.bgFrame;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

- (void)dismiss
{
    [self.array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn           = [self viewWithTag:idx + 100];
        UIView *line            = [self viewWithTag:idx + 200];
        [UIView animateWithDuration:0.3 - 0.02 * idx
                              delay:0
             usingSpringWithDamping:0.9
              initialSpringVelocity:1
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             btn.frame      = CGRectMake(self.bgFrame.size.width, idx * 40 + 15, 130, 40 - 0.3);
                             line.frame     = CGRectMake(self.bgFrame.size.width, idx * 40 + 39.7 + 15, 130, 0.3);
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    }];
    
    UIImageView *imageView      = [self viewWithTag:IMG_TAG];
    [UIView animateWithDuration:0.2
                          delay:0.2
         usingSpringWithDamping:1
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         imageView.frame = CGRectMake(self.bgFrame.origin.x , self.bgFrame.origin.y, self.bgFrame.size.width, 2);
                         imageView.alpha = 0.1;
                     }
                     completion:^(BOOL finished) {
                         imageView.alpha = 1;
                         [self removeFromSuperview];
                     }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
