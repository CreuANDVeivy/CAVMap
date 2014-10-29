//
//  MapSelectPointViewController.m
//  CAVmap
//
//  Created by Ibokan on 14-10-25.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "MapSelectPointViewController.h"


@interface MapSelectPointViewController ()
{
    BOOL isClickMap;
}
@end

@implementation MapSelectPointViewController

@synthesize selectLocation;

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
    // Do any additional setup after loading the view from its nib.
    
    isClickMap = NO;  // 是否点击了map
    [self initMapView];  // 初始化地图
    [self initButtonView];  // 初始化按钮

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    mapV.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    mapV.delegate = nil;
}

#pragma mark - 初始化地图视图
- (void)initMapView
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:kFrame((kScreenWidth-200)/2, 25, 200, 30)];
    titleLabel.text = @"点击地图选点";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navView addSubview:titleLabel];
    
    // 初始化地图
    mapV = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 60, kScreenWidth,kScreenHeight-38)];
    [mapV viewWillAppear];
    
    // 地图比例尺
    mapV.showMapScaleBar = YES;
    mapV.mapScaleBarPosition = CGPointMake(10,kScreenHeight-100);
    
    [mapV setCompassPosition:CGPointMake(10,70)];  // 指南针位置
    mapV.mapType = BMKMapTypeStandard; // 地图类型 ： 标准地图
    mapV.zoomLevel = 15;// 地图尺寸
    
    
    if ([[MainViewController onlyOneMainViewController] currentLocation])
    {
        [mapV updateLocationData:[[MainViewController onlyOneMainViewController] currentLocation]];
        BMKCoordinateSpan span = {0.002,0.002};
        BMKCoordinateRegion region = {[[MainViewController onlyOneMainViewController] currentLocation].location.coordinate,span};
        [mapV setRegion:region animated:YES];
        mapV.showsUserLocation = YES;
    }
    else if ([kUserDictionary objectForKey:@"latitude"] && [kUserDictionary objectForKey:@"longitude"])
    {
        double a = [[kUserDictionary objectForKey:@"latitude"]doubleValue];
        double b = [[kUserDictionary objectForKey:@"longitude"]doubleValue];
        
        CLLocation *location = [[CLLocation alloc] initWithLatitude:a longitude:b];
        
        
//        NSLog(@"%@",[kUserDictionary objectForKey:@"latitude"]);
//        NSLog(@"%f",[[kUserDictionary objectForKey:@"latitude"]doubleValue]);
//        coor->latitude = [[kUserDictionary objectForKey:@"latitude"]doubleValue];
//        coor->longitude = [[kUserDictionary objectForKey:@"longitude"]doubleValue];

        BMKCoordinateSpan span = {0.002,0.002};
        BMKCoordinateRegion region = {location.coordinate,span};
        [mapV setRegion:region animated:YES];
        
    }
    
    
    [self.view addSubview:mapV];
    
}

#pragma mark - button init
- (void)initButtonView
{
    //  确定按钮
    UIButton *confirmBtn = [UIButton blueSystemButtonWithButtonType:UIButtonTypeRoundedRect title:@"确定" frame:kFrame(kScreenWidth-45, 27.5, 40, 25)];
    [confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    
    // 放大缩小按钮初始化
    NSArray *btnImageArr = [NSArray arrayWithObjects:[UIImage redraw:[UIImage imageNamed:@"main_icon_zoomin"] Frame:kFrame(0, 0, 20, 20)],[UIImage redraw:[UIImage imageNamed:@"main_icon_zoomout"] Frame:kFrame(0, 0, 20, 20)], nil];
    
    for (int i = 0; i < 2; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = kFrame(kScreenWidth-40, kScreenHeight-80+i*30, 40, 40);
        [btn setImage:btnImageArr[i] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"main_bottombar_background"] forState:UIControlStateNormal];
        
        btn.tag = 101+i;
        [btn addTarget:self action:@selector(zoomTransFormAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

#pragma mark - ButtonClicksAction
// 放大缩小地图
- (void)zoomTransFormAction:(UIButton*)sender
{
    if (sender.tag == 101)
    {
        if (mapV.zoomLevel != 19)
            mapV.zoomLevel++;
    }
    else
    {
        if (mapV.zoomLevel != 3)
            mapV.zoomLevel--;
    }
}
- (void)confirmAction:(id)sender
{
    if (isClickMap)
    {
        block(&selectLocation);
        [self.navigationController popViewControllerAnimated:NO];
    }
    else
    {
        [UIAlertView showAlertViewWithMessage:@"未选择地点" buttonTitles: nil];
    }
}


#pragma mark - mapView Delegate

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate
{
    [self addAnnotationWithCoordinate:coordinate];
}

- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi *)mapPoi
{
    [self addAnnotationWithCoordinate:mapPoi.pt];
}

- (void)addAnnotationWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    // 移除之前的大头针
    [mapV removeAnnotations:mapV.annotations];
    selectLocation = coordinate;
    // 添加一个大头针
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    annotation.coordinate = selectLocation;
    [mapV addAnnotation:annotation];
    isClickMap = YES;
}

// 定义大头针
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    NSString *AnnotationViewID = @"location";
    tipsAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
    
    // 设置颜色
    tipsAnnotation.pinColor = BMKPinAnnotationColorPurple;
    // 从天上掉下效果
//    tipsAnnotation.animatesDrop = YES;
    // 设置可拖拽
    tipsAnnotation.draggable = YES;
    // 设置大头针图标
    tipsAnnotation.image = [UIImage imageNamed:@"icon_openmap_focuse_mark"];
     
    return tipsAnnotation;
    
}

#pragma mark - 实现block
- (void)realizeBlock:(selectLocationBlock)sender
{
    block = sender;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
