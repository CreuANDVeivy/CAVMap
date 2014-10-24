//
//  BaseViewController.h
//  CAVmap
//
//  Created by 3024 on 14-10-18.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (retain, nonatomic) AMBlurView *navView; // 导航栏视图
@property (retain, nonatomic) UIButton *backButton;  // 返回按钮

// 初始化自定义导航栏的方法
- (void)initCustomNavgationBar;
// 返回按钮的方法
- (void)backButtonClickAction:(UIButton *)sender;

// 添加右边的地图按钮
- (void)addRightMapButton;
// 切换到地图视图的方法
- (void)transformToMapView:(UIButton *)sender;

// 添加搜索按钮
- (void)addSearchButton;
// 点击搜索时的方法
- (void)searchButtonClicksAction:(UIButton *)sender;

@end
