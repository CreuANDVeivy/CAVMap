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
    navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
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
