//
//  MainViewController.m
//  CAVmap
//
//  Created by 3024 on 14-10-18.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController


@synthesize searchBarView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        mapManager = [[BMKMapManager alloc]init];
        // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
        BOOL ret = [mapManager start:kBDAppKey generalDelegate:self];
        if (!ret)
        {
            NSLog(@"地图管理者开启失败");
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initMapView];  // 初始化地图视图
    [self initButtonView];  // 初始化按钮视图
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    mapV.delegate = self;  // 视图简要出现 设置地图代理
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    mapV.delegate = nil;  // 视图将要消失 地图代理置nil
    
}

#pragma mark - 初始化地图视图
-(void)initMapView
{
    mapV = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight)];
    mapV.mapType = BMKMapTypeStandard; // 地图类型 ： 标准地图
    [self.view addSubview:mapV];
}

#pragma mark - 初始化按钮视图
- (void)initButtonView
{
    NSArray *btnImageArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"zoomin_idle_tool"],[UIImage imageNamed:@"zoomin_idle_tool_hl"],[UIImage imageNamed:@"zoomout_idle_tool"],[UIImage imageNamed:@"zoomout_idle_tool_hl"], nil];  // 加减按钮图片数组
    
    int temp = 0;
    for (int i = 0; i < 2; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = kFrame(kScreenWidth-40, kScreenHeight-120+i*30, 30, 30);
        [btn setImage:btnImageArr[temp] forState:UIControlStateNormal];
        temp ++;
        [btn setImage:btnImageArr[temp] forState:UIControlStateHighlighted];
        temp ++;
        
        [self.view addSubview:btn];
    }
}

#pragma mark - MapView Delegate


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
