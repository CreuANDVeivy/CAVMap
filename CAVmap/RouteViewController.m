//
//  RouteViewController.m
//  CAVmap
//
//  Created by Ibokan on 14-10-22.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "RouteViewController.h"
#import "KeyWordSearchModel.h"

@interface RouteViewController ()
{
    NSArray *navBarImageArr;//图片视图
}
@end

@implementation RouteViewController

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
    
    [self initNavBarView]; // 初始化navBar视图
    
    
    CLLocationCoordinate2D location = {23.135927,113.256316};
    [[KeyWordSearchModel keyWordModel]requestDataWith:@"小吃" currentLocation:location block:^(id result)
    {

        BMKPoiResult *poi = (BMKPoiResult *)result;

        for (BMKPoiInfo *info in poi.poiInfoList)
        {
            NSLog(@"%@",info.address);
            [[KeyWordSearchModel keyWordModel]requestBaiduDetailDataWithUid:info.uid andBlock:^(id detail) {
               
                BMKPoiDetailResult *poiDetail = (BMKPoiDetailResult *)detail;
                NSLog(@"综合评分 ： %f",poiDetail.tasteRating);
            }];
        }
        
        
    }];
}

#pragma mark - 初始化navBar视图

- (void)initNavBarView
{
    navBarImageArr = [NSArray arrayWithObjects:[UIImage imageNamed:@"common_topbar_route_bus_normal"],
                      [UIImage imageNamed:@"common_topbar_route_car_normal"],
                      [UIImage imageNamed:@"common_topbar_route_foot_normal"],
                      [UIImage imageNamed:@"common_topbar_route_bus_pressed"],
                      [UIImage imageNamed:@"common_topbar_route_car_pressed"],
                      [UIImage imageNamed:@"common_topbar_route_foot_pressed"], nil];
    
    for (int i = 0; i < 3; i ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom
                                           frame:kFrame(85+60*i, 25, 25, 25)
                                           image:navBarImageArr[i]
                                           title:nil
                                          target:self
                                       andAction:@selector(navBarBtnAction:)];
        btn.tag = 101+i;
        [self.view addSubview:btn];
    }
    
}

#pragma mark - ButtonClicksAction
// navBar按钮方法
- (void)navBarBtnAction:(id)sender
{
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
