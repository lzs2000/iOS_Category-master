//
//  LoadAnimationButton.m
//  点击变菊花再变按钮的按钮
//
//  Created by 车德平 on 16/3/28.
//  Copyright © 2016年 车德平. All rights reserved.
//

#import "AnimationButton.h"

#define kSelfborderColor [UIColor redColor]
#define kYellowColor [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]
#define kSelfCornerRadius 8
@implementation AnimationButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        originalFrame = frame; // 记录原坐标
        animationsBegin = NO;
        
        self.layer.cornerRadius = kSelfCornerRadius;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor clearColor] CGColor];
         originalBackgroundColor = self.backgroundColor;
        //[self addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

//- (void)btnClick {
//    originalTitle = self.titleLabel.text;
//    originalBackgroundColor = self.backgroundColor;
//    
//    [self activityIndicatorViewShow:YES];
//}

- (void)activityIndicatorViewShow:(BOOL)showType {
    if (showType) { // 显示动画
        // 屏蔽在加载动画显示时多次点击
        if (!animationsBegin) {
            animationsBegin = YES;
        }else {
            return;
        }
        CGRect frame = CGRectMake(self.frame.origin.x+(self.frame.size.width-self.frame.size.height)/2, self.frame.origin.y, self.frame.size.height, self.frame.size.height);
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView animateWithDuration:0.15 animations:^{
            self.frame = frame;
        } completion:^(BOOL finished) {
            [self setTitle:@"" forState:UIControlStateNormal];
            self.backgroundColor = [UIColor clearColor];
            self.layer.borderColor = [[UIColor clearColor] CGColor];

            // 画弧线
            [self drawHalfCircle];
            //旋转动画
            [self startAnimation];
        }];
    }else { // 关闭动画

        [loadingLayer removeFromSuperlayer];
        self.transform = CGAffineTransformIdentity;//取消形变
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView animateWithDuration:0.1 animations:^{
            //self.backgroundColor = originalBackgroundColor;
            //self.layer.borderColor = [kSelfborderColor CGColor];
            self.backgroundColor = [UIColor clearColor];
            self.layer.borderColor = [[UIColor clearColor] CGColor];
            [self setTitle:originalTitle forState:UIControlStateNormal];
            self.frame = originalFrame;
            self.layer.cornerRadius = kSelfCornerRadius;
            animationsBegin = NO;
        }];
    }
}

// 画弧线
- (void)drawHalfCircle {
    loadingLayer = [self drawCircle];
    
    // 这个是用于指定画笔的开始与结束点
    loadingLayer.strokeStart = 0.0;
    loadingLayer.strokeEnd = 0.75;
}

- (CAShapeLayer *)drawCircle {
    CGRect frame = CGRectMake(0, 0, self.frame.size.height, self.frame.size.height);
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    // 指定frame，只是为了设置宽度和高度
    circleLayer.frame = frame;
    // 设置居中显示
    circleLayer.position = CGPointMake(self.frame.size.height/2, self.frame.size.height/2);
    // 设置填充颜色
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    // 设置线宽
    circleLayer.lineWidth = 1;
    // 设置线的颜色
    circleLayer.strokeColor = kYellowColor.CGColor;
    // 使用UIBezierPath创建路径
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:frame];
    // 设置CAShapeLayer与UIBezierPath关联
    circleLayer.path = circlePath.CGPath;
    // 将CAShaperLayer放到某个层上显示
    [self.layer addSublayer:circleLayer];
    return circleLayer;
}
#pragma mark ====旋转动画======
- (void)startAnimation {
    if (!animationsBegin) {
        // 停止动画
        return;
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.01];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    self.transform = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    [UIView commitAnimations];
}

- (void)endAnimation {
    angle += 10;
    if (angle/360==1) {
        angle = 0;
    }
    [self startAnimation];
}
@end
