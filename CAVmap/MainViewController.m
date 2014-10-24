//
//  MainViewController.m
//  CAVmap
//
//  Created by 3024 on 14-10-18.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "MainViewController.h"
#import "NearByViewController.h"
#import "RouteViewController.h"
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>

@interface MainViewController ()
{
    int selectType;
    BOOL isTouchLocationBtn;
    NSArray *typeImageArr;
    UIImage *follow, *compass;
}
@end

@implementation MainViewController

@synthesize searchBarView;
@synthesize locationService;
@synthesize currentLocation;
@synthesize tabBarView;
@synthesize navBarView;

+ (MainViewController *)onlyOneMainViewController
{
    static MainViewController *mainV;
    if (!mainV)
    {
        mainV = [[MainViewController alloc]init];
    }
    
    return mainV;
}

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
    
    // 跟随图片，罗盘图片初始化
    follow = [UIImage redraw:[UIImage imageNamed:@"main_icon_follow"] Frame:kFrame(0, 0, 30, 30)];
    compass = [UIImage redraw:[UIImage imageNamed:@"main_icon_compass"] Frame:kFrame(0, 0, 30, 30)];
    
    [self initMapView];  // 初始化地图视图
    [self initButtonView];  // 初始化按钮视图
    [self initTabBarAndNavBar]; // 初始化tabBar和navBar视图
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
    [mapV viewWillAppear];
    // 地图比例尺
    mapV.showMapScaleBar = YES;
    mapV.mapScaleBarPosition = CGPointMake(kScreenWidth-200,kScreenHeight-60);
    
    mapV.zoomLevel = 15;// 地图尺寸
    
    [mapV setCompassPosition:CGPointMake(10,70)];  // 指南针位置
    mapV.mapType = BMKMapTypeStandard; // 地图类型 ： 标准地图
    selectType = 2;

    [self.view addSubview:mapV];
    
}

#pragma mark - 初始化菜单视图
- (void)initMenuView
{
    // 菜单视图
    menuView = [[UIView alloc]initWithFrame:kFrame(kScreenWidth-5, 105, 0, 210)];
    menuView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.98];
    menuView.layer.cornerRadius = 1;
    menuView.layer.masksToBounds = NO;
    menuView.autoresizesSubviews = YES;
    

    // 地图类型图片数组
    typeImageArr = @[[UIImage imageNamed:@"maplayer_manager_sate"],
                              [UIImage imageNamed:@"maplayer_manager_2d"],
                              [UIImage imageNamed:@"maplayer_manager_3d"],
                              [UIImage imageNamed:@"maplayer_manager_sate_hl"],
                              [UIImage imageNamed:@"maplayer_manager_2d_hl"],
                              [UIImage imageNamed:@"maplayer_manager_3d_hl"]];
    
    NSArray *imageArr = @[[UIImage imageNamed:@"map_layer_fav"],
                          [UIImage imageNamed:@"map_layer_hot"],
                          [UIImage imageNamed:@"map_layer_indoor"]];

    NSArray *textArr = @[@"卫星图",@"2D平面图",@"3D俯视图",@"收藏点",@"热力图",@"室内图"];
    
    void(^labelBlock)(UILabel *,int) = ^(UILabel *label,int a){
        label.text = textArr[a];
        label.textAlignment = a > 2 ? NSTextAlignmentLeft : NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        [menuView addSubview:label];
    };
    
    for (int i = 0; i < 3; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = kFrame(20+95*i, 15, (kScreenWidth-80)/3, 50);
        [btn setImage:typeImageArr[i] forState:UIControlStateNormal];
        if (i == 1)
        {
            [btn setImage:typeImageArr[i+3] forState:UIControlStateNormal];
        }
        
        btn.tag = 141+i;
        [btn addTarget:self action:@selector(setMapTypeWithBtn:) forControlEvents:UIControlEventTouchUpInside];
        [menuView addSubview:btn];
        
        UILabel *label = [[UILabel alloc]initWithFrame:kFrame(20+95*i, 70, 80, 15)];
        labelBlock(label,i);
        UILabel *label2 = [[UILabel alloc]initWithFrame:kFrame(60, 90+(40-15)/2+40*i, 60, 15)];
        labelBlock(label2,i+3);
        
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:kFrame(20, 95+40*i, 35, 30)];
        imageV.image = imageArr[i];
        [menuView addSubview:imageV];
        
        UIImageView *separaLine = [[UIImageView alloc]initWithFrame:kFrame(0, 90+40*i, kScreenWidth-10, 1)];
        separaLine.image = [UIImage imageNamed:@"sendtocar_dotted_line"];
        [menuView addSubview:separaLine];
        
        UISwitch *switchView = [[UISwitch alloc]initWithFrame:kFrame(kScreenWidth-80, 95+40*i-2, 20, 20)];
        [menuView addSubview:switchView];
        
    }

    [self.view addSubview:menuView];
}

#pragma mark - 初始化按钮视图
- (void)initButtonView
{
    // 路况、地图菜单按钮初始化
    NSArray *menuBtnImageArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"main_icon_maplayers"],[UIImage imageNamed:@"main_icon_roadcondition_off"],[UIImage imageNamed:@"main_map_icon_streetscape"], nil];
    
    for (int i = 0; i < 3; i++)
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
    
    // 放大缩小按钮初始化
    NSArray *btnImageArr = [NSArray arrayWithObjects:[UIImage redraw:[UIImage imageNamed:@"main_icon_zoomin"] Frame:kFrame(0, 0, 20, 20)],[UIImage redraw:[UIImage imageNamed:@"main_icon_zoomout"] Frame:kFrame(0, 0, 20, 20)], nil];

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
    locationBtn.frame = kFrame(kScreenWidth-40, kScreenHeight-80, 40, 40);
    [locationBtn setBackgroundImage:[UIImage imageNamed:@"main_bottombar_background"] forState:UIControlStateNormal];
    [locationBtn setImage:[UIImage imageNamed:@"navi_idle_gps_unlocked"] forState:UIControlStateNormal];
    [locationBtn addTarget:self action:@selector(loactionBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:locationBtn];
    
    // 是否单击locationBtn
    isTouchLocationBtn = NO;
    
}

#pragma mark - 初始化tabBar和navBar视图
- (void)initTabBarAndNavBar
{
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
    isTouchLocationBtn = YES;
    [self setMapViewRegionWith:currentLocation.location.coordinate];

    // 转换定位方式
    if ([[sender imageForState:UIControlStateNormal]isEqual:compass] || [[sender imageForState:UIControlStateNormal]isEqual:[UIImage imageNamed:@"navi_idle_gps_unlocked"]])
    {
        mapV.userTrackingMode = BMKUserTrackingModeNone;
        mapV.userTrackingMode = BMKUserTrackingModeFollow;
        [sender setImage:follow forState:UIControlStateNormal];
    }
    else if ([[sender imageForState:UIControlStateNormal]isEqual:follow])
    {
        mapV.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
        [sender setImage:compass forState:UIControlStateNormal];
        
    }
    
    mapV.showsUserLocation = YES;
    isTouchLocationBtn = NO;
}

// tabBar按钮
- (void)tabBarBtnAction:(UIButton*)sender
{
    switch (sender.tag)
    {
        case 111:
        {
            [self.navigationController pushViewController:[NearByViewController new] animated:YES];
        }
            break;
            
        case 112:
        {
            [self.navigationController pushViewController:[RouteViewController new] animated:YES];
        }
            break;
            
        case 113:
        {
            
        }
            break;
            
        case 114:
        {
            
        }
            break;
            
        default:
            break;
    }
    
}

// 显示或隐藏菜单
- (void)menuBtnAction:(UIButton*)sender
{
    switch (sender.tag)
    {
        case 121:
        {
            // 背景视图
            UIView *backView = [[UIView alloc]initWithFrame:kFrame(0, 0, kScreenWidth, kScreenHeight)];
            backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
            backView.tag = 131;
            
            // 菜单视图关闭按钮
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = kFrame(kScreenWidth-30, 80, 25, 25);
            [btn setImage:[UIImage redraw:[UIImage imageNamed:@"icon_cancel_normal"] Frame:kFrame(0, 0, 10, 10)] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor colorWithWhite:1 alpha:0.98];
            btn.layer.cornerRadius = 1;
            btn.layer.masksToBounds = NO;
            
            [btn addTarget:self action:@selector(remoVeMenuViewAction:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:btn];
            [self.view addSubview:backView];
            
            [self.view insertSubview:menuView atIndex:self.view.subviews.count];
            [UIView animateWithDuration:0.3 animations:^{
                menuView.frame = kFrame(5, 105, kScreenWidth-10, 210);
            }];
            
        }
            break;
            
        case 122:
        {
            if ([sender imageForState:UIControlStateNormal]==[UIImage imageNamed:@"main_icon_roadcondition_off"])
            {
                
                [sender setImage:[UIImage imageNamed:@"main_icon_roadcondition_on"] forState:UIControlStateNormal];
                if (mapV.mapType == BMKMapTypeStandard)
                {
                    mapV.mapType = BMKMapTypeTrafficOn;
                }
                else if (mapV.mapType == BMKMapTypeSatellite)
                {
                    mapV.mapType = BMKMapTypeTrafficAndSatellite;
                }
            }
            else
            {
                [sender setImage:[UIImage imageNamed:@"main_icon_roadcondition_off"] forState:UIControlStateNormal];
                if (mapV.mapType == BMKMapTypeTrafficOn)
                {
                    mapV.mapType = BMKMapTypeStandard;
                }
                else if (mapV.mapType == BMKMapTypeTrafficAndSatellite)
                {
                    mapV.mapType = BMKMapTypeSatellite;
                }
            }
        }
            break;
        case 123:
        {
            if ([sender imageForState:UIControlStateNormal] == [UIImage imageNamed:@"main_map_icon_streetscape_normal"])
            {
                [sender setImage:[UIImage imageNamed:@"main_map_icon_streetscape"] forState:UIControlStateNormal];
            }
            else
            {
                [sender setImage:[UIImage imageNamed:@"main_map_icon_streetscape_normal"] forState:UIControlStateNormal];
            }
            
        }
            break;
            
        default:
            break;
    }
    
}

// 移除菜单视图
- (void)remoVeMenuViewAction:(id)sender
{
    UIView *backView = [self.view viewWithTag:131];
    [backView removeFromSuperview];
    
    [UIView animateWithDuration:0.3 animations:^{
        menuView.frame = kFrame(kScreenWidth-5, 105, 0, 210);
    }];
    
}

// 设置地图样式
- (void)setMapTypeWithBtn:(UIButton*)sender
{
    if (sender.tag-140 != selectType)
    {
        UIButton *btn = (UIButton *)[menuView viewWithTag:selectType+140];
        [btn setImage:typeImageArr[selectType-1] forState:UIControlStateNormal];
        [self ifMapTypeAction:sender.tag-140];
        selectType = sender.tag-140;
        [sender setImage:typeImageArr[selectType+3-1] forState:UIControlStateNormal];
    }
}

// tabBar动画方法
- (void)hiddenTabBarAction:(id)sender
{
    if ([tabBarBtn imageForState:UIControlStateNormal] == [UIImage imageNamed:@"route_push_back_btn_normal"])
    {
        [tabBarBtn setImage:[UIImage imageNamed:@"route_push_back_btn_pressed"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            
            tabBarView.frame = kFrame(kScreenWidth, kScreenHeight-40, kScreenWidth, 41);
        }];
    }
    else
    {
        [tabBarBtn setImage:[UIImage imageNamed:@"route_push_back_btn_normal"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            
            tabBarView.frame = kFrame(0, kScreenHeight-40, kScreenWidth, 41);
        }];
    }
    
    
    
}

#pragma mark - funcation
// 判断地图类型
- (void)ifMapTypeAction:(int)tag
{
    switch (selectType)
    {
        case 1:
        {
            mapV.mapType = mapV.mapType == BMKMapTypeTrafficAndSatellite ? BMKMapTypeTrafficOn : BMKMapTypeStandard;
            if (tag == 3)
            {
                 mapV.overlooking = -45;
            }
            
        }
            break;
            
        case 2:
        {
            if (tag == 1)
            {
                mapV.mapType = mapV.mapType == BMKMapTypeStandard ? BMKMapTypeSatellite : BMKMapTypeTrafficAndSatellite;
            }
            else
            {
                mapV.overlooking = -45;
            }
            
        }
            break;
            
        case 3:
        {
            if (tag == 1)
            {
                mapV.mapType = mapV.mapType == BMKMapTypeStandard ? BMKMapTypeSatellite : BMKMapTypeTrafficAndSatellite;
            }
            mapV.overlooking = 0;
        }
            break;
            
        default:
            break;
    }
    
}

// 设定地图中心
- (void)setMapViewRegionWith:(CLLocationCoordinate2D )cordinate
{
    // 显示定位图层
    mapV.showsUserLocation = YES;
    [mapV updateLocationData:currentLocation];
    
    BMKCoordinateRegion region = {cordinate};
    [mapV setRegion:region animated:YES];
    
}

#pragma mark - MapView Delegate

// 地图内容改变时调用
-(void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (!animated)
    {
        mapV.userTrackingMode = BMKUserTrackingModeNone;
        [locationBtn setImage:[UIImage imageNamed:@"navi_idle_gps_unlocked"] forState:UIControlStateNormal];
    }
}

// 点击地图上的标注时调用
- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi *)mapPoi
{
    // 移除之前的大头针
    [mapV removeAnnotations:mapV.annotations];
    
    // 添加一个大头针
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = mapPoi.pt;
    [mapV addAnnotation:annotation];
    
    // 设为地图中心
    [self setMapViewRegionWith:mapPoi.pt];
    
    if (!tipsView)
    {
        // 创建tips
        tipsView = [[NavigationTipsView alloc]initWithMapPoi:mapPoi];
        [self.view addSubview:tipsView];
        
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        tipsView.frame = kFrame(5, kScreenHeight-145, kScreenWidth-45, 100);
    }];// 出现动画
    tipsView.mapP = mapPoi;
    tipsView.title.text = mapPoi.text;
    
}

// 点击地图空白处时调用
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    [mapV removeAnnotations:mapV.annotations];
    
    [UIView animateWithDuration:0.3 animations:^{
        tipsView.frame = kFrame(-kScreenWidth, kScreenHeight-145, kScreenWidth-45, 100);
    }];
    
    
}

// 定义大头针
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    
    NSString *AnnotationViewID = @"tips";
    
    tipsAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    
    // 设置颜色
    tipsAnnotation.pinColor = BMKPinAnnotationColorPurple;
    // 从天上掉下效果
//    tipsAnnotation.animatesDrop = YES;
    // 设置可拖拽
//    ((BMKPinAnnotationView*)newAnnotation).draggable = YES;
    //设置大头针图标
    tipsAnnotation.image = [UIImage imageNamed:@"icon_openmap_focuse_mark"];
    /*
    UIView *popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
    //设置弹出气泡图片
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"game_detail_header_bg"]];
    image.frame = CGRectMake(0, 0, 100, 60);
    [popView addSubview:image];
    
    //自定义显示的内容
    UILabel *driverName = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 100, 20)];
    driverName.text = @"张前海老家";
    driverName.backgroundColor = [UIColor clearColor];
    driverName.font = [UIFont systemFontOfSize:14];
    driverName.textColor = [UIColor blackColor];
    driverName.textAlignment = NSTextAlignmentCenter;
    [popView addSubview:driverName];
    
    BMKActionPaopaoView *pView = [[BMKActionPaopaoView alloc]initWithCustomView:popView];
    pView.frame = CGRectMake(0, 0, 100, 60);
    tipsAnnotation.paopaoView = nil;
    tipsAnnotation.paopaoView = pView;
    */
    return tipsAnnotation;
    
}

- (void)updateLocationViewWithParam:(BMKLocationViewDisplayParam*)locationViewDisplayParam
{

}

#pragma mark - LocationService Delegate

// 处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    
}

// 处理位置坐标更新
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{

    currentLocation = userLocation;
    if (!mapV.showsUserLocation)
    {
        [self setMapViewRegionWith:userLocation.location.coordinate];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
