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

// 添加去地图的方法
- (void)addRightMapButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = kFrame(kScreenWidth - 70, 25, 60, 28);
    [btn addTarget:self action:@selector(transformToMapView:) forControlEvents:UIControlEventTouchUpInside];  // 添加方法
    btn.layer.borderWidth = 0.5;
    btn.layer.borderColor = [UIColor grayColor].CGColor;
    // 设置圆角
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = NO;
    [navView addSubview:btn];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topbar_view_map.png"] highlightedImage:[UIImage imageNamed:@"topbar_view_map.png"]];
    imageView.frame = kFrame(5, 2.5, 20, 20);
    [btn addSubview:imageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:kFrame(27.5, 3, 30, 20)];
    titleLabel.text = @"地图";
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.textColor = [UIColor colorWithRed:10/255.0 green:95/255.0 blue:254/255.0 alpha:1];
    [btn addSubview:titleLabel];
    
}

// 添加搜索按钮
- (void)addSearchButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = kFrame(kScreenWidth - 50, 25, 40, 26);
    [btn addTarget:self action:@selector(searchButtonClicksAction:) forControlEvents:UIControlEventTouchUpInside];  // 添加方法
    btn.layer.borderWidth = 0.5;
    btn.layer.borderColor = [UIColor colorWithRed:10/255.0 green:95/255.0 blue:254/255.0 alpha:1].CGColor;
    // 设置圆角
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = NO;
    [navView addSubview:btn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:kFrame(0, 0, 40, 26)];
    titleLabel.text = @"搜索";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.textColor = [UIColor colorWithRed:10/255.0 green:95/255.0 blue:254/255.0 alpha:1];
    [btn addSubview:titleLabel];
}

#pragma mark - 点击方法

// 切换到地图视图的方法
- (void)transformToMapView:(UIButton *)sender
{
    // 去地图的方法
    NSLog(@"切换到地图视图");
}

// 点击搜索的方法
- (void)searchButtonClicksAction:(UIButton *)sender
{
    NSLog(@"点击搜索的方法");
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
