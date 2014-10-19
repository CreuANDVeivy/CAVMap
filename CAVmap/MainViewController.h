//
//  MainViewController.h
//  CAVmap
//
//  Created by 3024 on 14-10-18.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "BaseViewController.h"

@interface MainViewController : BaseViewController<BMKGeneralDelegate,BMKMapViewDelegate>
{
    BMKMapManager *mapManager;//地图管理者
    BMKMapView *mapV;//地图视图
}

@property (retain, nonatomic) BaseButton *nearBy;  // 附近的按钮
@property (retain, nonatomic) UIView *searchBarView;//搜

@end
