//
//  BaseNavgationViewController.m
//  SeeDoctorGuide
//
//  Created by 3024 on 14-9-26.
//  Copyright (c) 2014年 ibokan. All rights reserved.
//

#import "BaseNavgationViewController.h"
//#import "UIImage+Redraw.h"
#import "BaseLabel.h"

@interface BaseNavgationViewController ()

@end

@implementation BaseNavgationViewController

@synthesize navView,backButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBar.hidden = YES;  // 隐藏自带的导航栏
    
    [self initCustomNavgationBar];  // 自定义导航栏
    
//    NSDictionary *attribute = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
//    self.navigationBar.titleTextAttributes = attribute;  // 设置标题的颜色
//    self.navigationBar.tintColor = [UIColor whiteColor];  // 设置导航栏系统自带图标颜色
    
//    [self.navigationBar setBackgroundImage:[UIImage redraw:[UIImage imageNamed:@"btn_seg_right_nor@2x"] Frame:CGRectMake(0, 0, ScreenWidth + 20, 64)] forBarMetrics:UIBarMetricsDefault];

}


- (void)initCustomNavgationBar
{
    navView = [[UIView alloc] initWithFrame:CGRectMake(-2, -2, kScreenWidth + 4, 62)];  //
    //
    navView.backgroundColor = [UIColor whiteColor];  // 测试
    
    navView.layer.borderWidth = 0.3;
    navView.layer.borderColor = [UIColor grayColor].CGColor;
    
    backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 60 - 30, 20, 20)];  // 按钮的frame
    [backButton addTarget:self action:@selector(backButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];  // 添加返回的方法
//    backButton.backgroundColor = [UIColor redColor];  // 测试
    [backButton setImage:[UIImage imageNamed:@"mini_webview_back"] forState:0];  // 设置图片
    
    [navView addSubview:backButton];   // 将按钮加载到视图
    
    [self.view addSubview:navView];
}

- (void)backButtonClickAction:(UIButton *)sender
{
    NSLog(@"返回按钮按了");
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
