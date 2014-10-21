//
//  BaseViewController.m
//  CAVmap
//
//  Created by 3024 on 14-10-18.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize navView,backButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;  // 隐藏自带的导航栏
    [self initCustomNavgationBar];  // 自定义导航栏
}



// 自定义导航栏
- (void)initCustomNavgationBar
{
    navView = [[AMBlurView alloc] initWithFrame:CGRectMake(-2, -2, kScreenWidth + 4, 62)];  //
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

// 返回按钮事件
- (void)backButtonClickAction:(UIButton *)sender
{
    //    NSLog(@"返回按钮按了");
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
