//
//  ViewController.m
//  BtnSubmit
//
//  Created by 刘璐璐 on 16/8/26.
//  Copyright © 2016年 刘璐璐. All rights reserved.
//

#import "ViewController.h"
#import "AnimationButton.h"

@interface ViewController ()
{
    AnimationButton *loadBtn;
    NSInteger i;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    i = 1;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(([[UIScreen mainScreen] bounds].size.width - 150) / 2, 200, 150, 40);
     [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitle:@"" forState:UIControlStateSelected];
   // btn.selected = YES;
    btn.backgroundColor = [UIColor colorWithRed:0.9895 green:0.4347 blue:0.032 alpha:1.0];
    [btn setTitleColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(loadAnimationAction:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 5;
    btn.clipsToBounds = YES;
    [self.view addSubview:btn];
    
    loadBtn = [[AnimationButton alloc] initWithFrame:CGRectMake((150 - 30)/ 2, 5, 30, 30)];
    loadBtn.backgroundColor = [UIColor clearColor];
    //loadBtn.center = btn.center;
    [btn.layer addSublayer:loadBtn.layer];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)loadAnimationAction:(UIButton *)btn {
    if (i % 2 == 0) {
        [loadBtn activityIndicatorViewShow:YES];
    btn.selected = YES;
    } else {
        [loadBtn activityIndicatorViewShow:NO];
        btn.selected = NO;
        
    }
    i++;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
