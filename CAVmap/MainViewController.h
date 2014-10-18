//
//  MainViewController.h
//  CAVmap
//
//  Created by 3024 on 14-10-18.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "BaseViewController.h"

@interface MainViewController : BaseViewController<BMKGeneralDelegate>
{
    BMKMapManager *mapManager;
}
@property (retain, nonatomic) UIView *searchBarView;

@end
