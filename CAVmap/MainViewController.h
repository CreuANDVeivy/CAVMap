//
//  MainViewController.h
//  CAVmap
//
//  Created by 3024 on 14-10-18.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "BaseViewController.h"
#import "KeyWordSearchModel.h"

@interface MainViewController : BaseViewController<BMKGeneralDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKMapManager *mapManager;  // 地图管理者
    BMKMapView *mapV;  // 地图视图
    UIButton *locationBtn;
}

@property (retain, nonatomic) UIView *searchBarView;  // 搜
@property (retain, nonatomic) AMBlurView *tabBarView; // tabBarView
@property (retain, nonatomic) AMBlurView *navBarView; // navBarView
@property (retain, nonatomic) BMKLocationService *locationService;  // 定位服务
@property (retain, nonatomic) BMKUserLocation *currentLocation;  // 当前位置

@end
