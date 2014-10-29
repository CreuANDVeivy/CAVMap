//
//  MainViewController.h
//  CAVmap
//
//  Created by 3024 on 14-10-18.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "BaseViewController.h"
#import "KeyWordSearchModel.h"
#import "NavigationTipsView.h"

@interface MainViewController : BaseViewController<BMKGeneralDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BMKMapManager *mapManager;  // 地图管理者
    BMKMapView *mapV;  // 地图视图
    UIButton *locationBtn; // 定位按钮
    UIView *menuView; // 菜单视图
    UIButton *tabBarBtn; // tabBar动画按钮
    NavigationTipsView *tipsView; // 提示框
    BMKPinAnnotationView *tipsAnnotation; // 大头针view
}

@property (retain, nonatomic) UIView *searchBarView;  // 搜
@property (retain, nonatomic) AMBlurView *tabBarView; // tabBarView
@property (retain, nonatomic) AMBlurView *navBarView; // navBarView
@property (retain, nonatomic) BMKLocationService *locationService;  // 定位服务
@property (retain, nonatomic) BMKUserLocation *currentLocation;  // 当前位置
@property (copy, nonatomic) NSString *cityName;  // 城市名字

+ (MainViewController *)onlyOneMainViewController;  // 单例

@end
