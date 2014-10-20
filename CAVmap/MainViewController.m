//
//  MainViewController.m
//  CAVmap
//
//  Created by 3024 on 14-10-18.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "MainViewController.h"
#import "NearByViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize searchBarView;
@synthesize locationService;
@synthesize currentLocation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        mapManager = [[BMKMapManager alloc]init];
        // 如果要关注网络及授权验证事件，请设定generalDelegate参数
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
    // 初始化定位服务
    locationService = [[BMKLocationService alloc]init];
    [locationService startUserLocationService];  // 开启定位服务
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    mapV.delegate = self;  // 视图简要出现 设置地图代理
    locationService.delegate = self;  // 定位服务代理
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    mapV.delegate = nil;  // 视图将要消失 地图代理置nil
    locationService.delegate = self;
}

#pragma mark - 初始化地图视图
-(void)initMapView
{
    // 初始化地图
    mapV = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight)];
    mapV.mapType = BMKMapTypeStandard; // 地图类型 ： 标准地图
    [mapV updateConstraints];
    [self.view addSubview:mapV];
    
    
}

#pragma mark - 初始化按钮视图
- (void)initButtonView
{
    NSArray *btnImageArr = [NSArray arrayWithObjects:[UIImage redraw:[UIImage imageNamed:@"main_icon_zoomin"] Frame:kFrame(0, 0, 20, 20)],[UIImage redraw:[UIImage imageNamed:@"main_icon_zoomout"] Frame:kFrame(0, 0, 20, 20)], nil];
    
    for (int i = 0; i < 2; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = kFrame(kScreenWidth-40, kScreenHeight-150+i*30, 40, 40);
        btn.tag = 101+i;
        [btn setImage:btnImageArr[i] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"main_bottombar_background"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(zoomTransFormAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];;
    locationBtn.frame = kFrame(kScreenWidth-40, kScreenHeight-80, 40, 40);
    [locationBtn setBackgroundImage:[UIImage imageNamed:@"main_bottombar_background"] forState:UIControlStateNormal];
    [locationBtn setImage:[UIImage imageNamed:@"navi_idle_gps_unlocked"] forState:UIControlStateNormal];
    [locationBtn addTarget:self action:@selector(loactionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:locationBtn];
    
    
}

#pragma mark - ButtonClicksAction
// 放大缩小地图
- (void)zoomTransFormAction:(UIButton*)sender
{
    switch (sender.tag)
    {
        case 101:  // 放大按钮
        {
            if (mapV.zoomLevel != 18)
            {
                mapV.zoomLevel++;
            }
            
        }
            break;
            
        default:  // 缩小按钮
        {
            if (mapV.zoomLevel != 3)
            {
                mapV.zoomLevel--;
            }
        }
            break;
    }
}

// 开启定位
- (void)loactionBtnAction:(UIButton*)sender
{
    [self setMapViewRegion];
    if (![[sender imageForState:UIControlStateNormal]isEqual:[UIImage imageNamed:@"navi_idle_gps_unlocked"]])
    {
        mapV.userTrackingMode = BMKUserTrackingModeNone;
        [sender setImage:[UIImage imageNamed:@"navi_idle_gps_unlocked"] forState:UIControlStateNormal];
    }
    else
    {
        mapV.userTrackingMode = BMKUserTrackingModeFollow;
        [sender setImage:[UIImage redraw:[UIImage imageNamed:@"main_icon_follow"] Frame:kFrame(0, 0, 30, 30)] forState:UIControlStateNormal];
    }
    
    mapV.showsUserLocation = YES;
}


- (void)nearByClicksAction:(BaseButton *)sender
{
    [self.navigationController pushViewController:[NearByViewController new] animated:YES];
}

#pragma mark - MapView Delegate



#pragma mark - LocationService Delegate

// 处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"------");
}

// 处理位置坐标更新
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
//    NSLog(@"-+----");
    currentLocation = userLocation;
    if (!mapV.showsUserLocation)
    {
        [self setMapViewRegion];
    }
}

// 设定地图中心
- (void)setMapViewRegion
{
    NSLog(@"----------");
    // 显示定位图层
    mapV.showsUserLocation = YES;
    [mapV updateLocationData:currentLocation];
    BMKCoordinateRegion region = {currentLocation.location.coordinate};
    [mapV setRegion:region];
    KeyWordSearchModel *keyWord = [[KeyWordSearchModel alloc]init];
    [keyWord RequertDataWith:@"快餐" currentLocation:currentLocation block:^(BMKPoiResult *) {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
