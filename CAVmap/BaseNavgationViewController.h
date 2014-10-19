//
//  BaseNavgationViewController.h
//  SeeDoctorGuide
//
//  Created by 3024 on 14-9-26.
//  Copyright (c) 2014年 ibokan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseNavgationViewController : UINavigationController



@property (retain, nonatomic) UIView *navView; // 导航栏视图
@property (retain, nonatomic) UIButton *backButton;  // 返回按钮

// 初始化自定义导航栏的方法
- (void)initCustomNavgationBar;
// 返回按钮的方法
- (void)backButtonClickAction:(UIButton *)sender;


@end
