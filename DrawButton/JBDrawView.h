//
//  JBDrawView.h
//  DrawButton
//
//  Created by Mac on 14-3-11.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JBDrawView : UIView

- (void)updateProgressCircle:(CGFloat)progress;

//设置进度条的颜色
- (void)setCircleColor:(UIColor*)color;

//设置进度条的背景色
- (void)setCircleBgColor:(CGColorRef)cgColor;

//设置Button的背景图片
- (void)setButtonImage:(NSString*)imageName;

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
@end
