//
//  NavigationTipsView.h
//  CAVmap
//
//  Created by Ibokan on 14-10-23.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationTipsView : UIView

@property (strong, nonatomic) BMKMapPoi *mapP;
@property (strong, nonatomic) UILabel *title;
@property (assign, nonatomic) CLLocationCoordinate2D location;

- (id)initWithMapPoi:(BMKMapPoi *)mapPoi;

@end
