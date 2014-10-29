//
//  MapSelectPointViewController.h
//  CAVmap
//
//  Created by Ibokan on 14-10-25.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "BaseViewController.h"
#import "MainViewController.h"

typedef void(^selectLocationBlock)(CLLocationCoordinate2D *coordinate);

@interface MapSelectPointViewController : BaseViewController <BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKMapView *mapV;  // mapView
    BMKPinAnnotationView *tipsAnnotation;  // 大头针view
    selectLocationBlock block;
}

@property (assign, nonatomic) CLLocationCoordinate2D selectLocation;  //选择位置

// 实现块
- (void)realizeBlock:(selectLocationBlock)sender;

@end
