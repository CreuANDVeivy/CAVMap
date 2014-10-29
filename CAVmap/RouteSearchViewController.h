//
//  RouteSearchViewController.h
//  CAVmap
//
//  Created by Ibokan on 14-10-24.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "BaseViewController.h"
#import "MapSelectPointViewController.h"

typedef void(^addressBlock)(BMKReverseGeoCodeResult *result);

@interface RouteSearchViewController : BaseViewController<UITextFieldDelegate,BMKGeoCodeSearchDelegate>
{
    addressBlock block;
}

@property (strong, nonatomic) NSString *selectPointText;  // 提示文本
@property (assign, nonatomic) CLLocationCoordinate2D selectLocation;
@property (strong, nonatomic) BaseTextField *textfield;

- (void)realizeBlock:(addressBlock)sender;

@end
