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
    BOOL isMylocation,isSelectLocation;
    CLLocationCoordinate2D one, two;
}
@property (strong, nonatomic) UIViewController *viewController;
@property (assign, nonatomic) CLLocationCoordinate2D origin;
@property (assign, nonatomic) CLLocationCoordinate2D endPoint;
@property (nonatomic) NSString *city;

@end
