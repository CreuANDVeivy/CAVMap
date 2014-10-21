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
{
    int selectType;
    NSArray *typeImageArr;
}
@end

@implementation MainViewController

@synthesize searchBarView;
@synthesize locationService;
@synthesize currentLocation;
@synthesize tabBarView;
@synthesize navBarView;

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
    [self initMenuView];  // 初始化菜单视图
    
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
- (void)initMapView
{
    // 初始化地图
    mapV = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight+22)];
    mapV.mapType = BMKMapTypeStandard; // 地图类型 ： 标准地图
    selectType = 2;
    [mapV updateConstraints];
    [self.view addSubview:mapV];
    
}

#pragma mark - 初始化菜单视图
- (void)initMenuView
{
    NSArray *btnImageArr = [NSArray arrayWithObjects:[UIImage redraw:[UIImage imageNamed:@"main_icon_zoomin.png"] Frame:kFrame(0, 0, 20, 20)],[UIImage redraw:[UIImage imageNamed:@"main_icon_zoomout.png"] Frame:kFrame(0, 0, 20, 20)], nil];
    
    for (int i = 0; i < 2; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = kFrame(kScreenWidth-40, kScreenHeight-150+i*30, 40, 40);
        [btn setImage:btnImageArr[i] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"main_bottombar_background"] forState:UIControlStateNormal];
        
        btn.tag = 101+i;
        [btn addTarget:self action:@selector(zoomTransFormAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    // 定位按钮初始化
    locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];;
    locationBtn.frame = kFrame(kScreenWidth-40, kScreenHeight-85, 40, 40);
    [locationBtn setBackgroundImage:[UIImage imageNamed:@"main_bottombar_background"] forState:UIControlStateNormal];
    [locationBtn setImage:[UIImage imageNamed:@"navi_idle_gps_unlocked"] forState:UIControlStateNormal];
    [locationBtn addTarget:self action:@selector(loactionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:locationBtn];
    
    // tabBar视图初始化
    tabBarView = [[AMBlurView alloc]initWithFrame:kFrame(0, kScreenHeight-40, kScreenWidth, 41)];
    tabBarView.blurTintColor = [UIColor whiteColor];
    [self.view addSubview:tabBarView];
    
    // tabBar按钮初始化
    NSArray *tabBarBtnImageArr =  [NSArray arrayWithObjects:[UIImage imageNamed:@"main_icon_nearby"],[UIImage imageNamed:@"main_icon_route"],[UIImage imageNamed:@"main_icon_nav"],[UIImage imageNamed:@"main_icon_mine"], nil];
    NSArray *tabBarBtnTitleArr = @[@"附近",@"路线",@"导航",@"我的"];
    for (int i = 0; i < 4; i++)
    {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom
                                           frame:kFrame(10+i*75, 10, 60, 20)
                                           image:tabBarBtnImageArr[i]
                                           title:tabBarBtnTitleArr[i]
                                          target:self
                                          action:@selector(tabBarBtnAction:)];
        btn.tag = 111+i;
        [tabBarView addSubview:btn];
    }
    tabBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tabBarBtn.frame = kFrame(kScreenWidth-30, kScreenHeight-30, 20, 20);
    tabBarBtn.backgroundColor = [UIColor whiteColor];

    [tabBarBtn setImage:[UIImage imageNamed:@"route_push_back_btn_normal"] forState:UIControlStateNormal];
    [tabBarBtn addTarget:self action:@selector(hiddenTabBarAction:) forControlEvents:UIControlEventTouchUpInside];
    
    tabBarBtn.layer.cornerRadius = 10;
    tabBarBtn.layer.masksToBounds = NO;
    tabBarBtn.layer.borderColor = [UIColor grayColor].CGColor;
    tabBarBtn.layer.borderWidth = 0.5;
    
    [self.view addSubview:tabBarBtn];
    
    // 路况、地图菜单按钮初始化
    NSArray *menuBtnImageArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"main_icon_maplayers"],[UIImage imageNamed:@"main_icon_roadcondition_off"], nil];
    
    for (int i = 0; i < 2; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = kFrame(kScreenWidth - 30, 80+40*i, 25, 25);
        [btn setImage:menuBtnImageArr[i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = NO;
        
        btn.tag = 121+i;
        [btn addTarget:self action:@selector(menuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    
    // naviBar初始化
    navBarView = [[AMBlurView alloc]initWithFrame:kFrame(0, 0, kScreenWidth, 60)];
    navBarView.transform = CGAffineTransformMakeRotation(M_PI);
    [self.view addSubview:navBarView];
    
    UIImageView *navImageView = [[UIImageView alloc]initWithFrame:kFrame(10, 25, kScreenWidth-20, 30)];
    navImageView.image = [UIImage imageNamed:@"game_detail_header_bg"];
    navImageView.userInteractionEnabled = YES;
    
    navImageView.layer.borderWidth  = 1;
    navImageView.layer.borderColor = [UIColor colorWithWhite:0.1 alpha:0.1].CGColor;
    navImageView.layer.cornerRadius = 5;
    navImageView.layer.masksToBounds = NO;
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = kFrame(5, 2.5, 25, 25);
    [searchBtn setImage:[UIImage imageNamed:@"userinfo_tabicon_search"] forState:UIControlStateNormal];
    [navImageView addSubview:searchBtn];
    
    UILabel *searchLabel = [[UILabel alloc]initWithFrame:kFrame(30, 5, 200, 20)];
    searchLabel.text = @"搜索";
    searchLabel.textColor = [UIColor colorWithWhite:0.1 alpha:0.5];
    searchLabel.font = [UIFont systemFontOfSize:15];
    [navImageView addSubview:searchLabel];
    
    [self.view addSubview:navImageView];
    
    
}

#pragma mark - ButtonClicksAction
// 放大缩小地图
- (void)zoomTransFormAction:(UIButton*)sender
{
    switch (sender.tag)
    {
        case 101:  // 放大按钮
        {
            if (mapV.zoomLevel != 19)
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

//tabBar按钮
- (void)tabBarBtnAction:(UIButton*)sender
{
    [self.navigationController pushViewController:[NearByViewController new] animated:YES];
}

#pragma mark - funcation

- (void)ifMapTypeAction
{
    if (mapV.mapType == BMKMapTypeStandard || mapV.mapType == BMKMapTypeSatellite)
    {
        
        mapV.mapType = mapV.mapType == BMKMapTypeStandard ? BMKMapTypeSatellite : BMKMapTypeStandard;
    }
    else
    {
        mapV.mapType = mapV.mapType == BMKMapTypeTrafficOn ? BMKMapTypeTrafficAndSatellite : BMKMapTypeTrafficOn;
    }
    
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
    
    /*
    KeyWordSearchModel *keyWord = [[KeyWordSearchModel alloc]init];
    [keyWord requestDataWith:@"xiaochi" currentLocation:currentLocation block:^(BMKPoiResult *poiResultList) {
        //在此处理正常结果
        for (BMKPoiInfo *info in poiResultList.poiInfoList)
        {
            NSLog(@"name = %@ \n address = %@",info.name,info.address);
            
        }
    }];
    
    [keyWord requestDataWith:@"v1/business/find_businesses" params:@"city=北京&region=海淀区&category=火锅&has_coupon=1&sort=2&limit=5" block:^(id result)
    {
        NSLog(@"%@",result);
       
        
    }
    errorBlock:^(id error)
    {
        NSLog(@"%@",error);
    }];
    */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
