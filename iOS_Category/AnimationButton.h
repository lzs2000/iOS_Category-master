//
//  LoadAnimationButton.h
//  点击变菊花再变按钮的按钮
//
//  Created by 车德平 on 16/3/28.
//  Copyright © 2016年 车德平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationButton : UIButton
{
    CGRect originalFrame;               // 原frame
    NSString *originalTitle;            // 原title
    UIColor *originalBackgroundColor;   // 原背景色
    BOOL animationsBegin;               // 动画是否已加载
    CAShapeLayer *loadingLayer;         // 绘制的弧线
    double angle;                       // 用作旋转角度
}
- (void)activityIndicatorViewShow:(BOOL)showType; // 显示/关闭转圈加载动画

@end
