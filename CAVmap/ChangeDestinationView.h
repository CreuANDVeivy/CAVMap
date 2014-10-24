//
//  ChangeDestinationView.h
//  CAVmap
//
//  Created by Ibokan on 14-10-24.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RouteSearchViewController.h"

@interface ChangeDestinationView : UIView
{
    CGRect upRect, downRect;
    CGRect upPoi, downPoi;
}
@property (strong, nonatomic) UIViewController *viewController;
@property (assign, nonatomic) CLLocationCoordinate2D myLocation;
@property (assign, nonatomic) CLLocationCoordinate2D selectPoint;

@end
