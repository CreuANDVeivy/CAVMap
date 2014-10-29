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
    NSArray *navBarImageArr;  // 图片视图
    NSInteger selectNavBtn; // 选中的导航按钮  1.bus  2. car  3.foot
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
    [self initView]; // 初始化视图
    selectNavBtn = 1;
    
    
    /*
     *百度请求
    CLLocationCoordinate2D location = {23.135927,113.256316};
    [[KeyWordSearchModel keyWordModel]requestDataWith:@"雷达" currentLocation:location block:^(id result)
    {

        BMKPoiResult *poi = (BMKPoiResult *)result;

        for (BMKPoiInfo *info in poi.poiInfoList)
        {
            NSLog(@"%@",info.address);

        }
        
        
    }];*/
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
}

#pragma mark - 初始化视图

- (void)initView
{
    // 搜索按钮
    UIButton *searchBtn = [UIButton blueSystemButtonWithButtonType:UIButtonTypeRoundedRect title:@"搜索" frame:kFrame(kScreenWidth-45, 27.5, 40, 25)];
    [searchBtn addTarget:self action:@selector(searchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    // 起点终点
    change = [[ChangeDestinationView alloc]initWithFrame:kFrame(0, 60, kScreenWidth, 80)];
    change.viewController = self;
    [self.view addSubview:change];
    
    [self.view addSubview:[UIImageView addSeparateLineWithFrame:kFrame(0, 140, kScreenWidth, 1)]];
    
    // 回家或者去公司视图
    HomeAndCompenyView *homeView = [HomeAndCompenyView onlyHomeAndCompenyView];
    homeView.currenViewController = self;
    homeView.frame = kFrame(10, 160, kScreenWidth-20, 80);
    [self.view addSubview:homeView];
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
                                           frame:kFrame(((kScreenWidth-125)/2)+50*i, 25, 25, 25)
                                           image:navBarImageArr[i]
                                           title:nil
                                          target:self
                                       andAction:@selector(navBarBtnAction:)];
        if (i == 0)
        {
            [btn setImage:navBarImageArr[3] forState:UIControlStateNormal];
        }
        
        btn.tag = 101+i;
        [self.view addSubview:btn];
    }
}

#pragma mark - ButtonClicksAction
// navBar按钮方法
- (void)navBarBtnAction:(UIButton *)sender
{
    if (selectNavBtn != sender.tag-100)
    {
        UIButton *btn = (UIButton *)[self.view viewWithTag:selectNavBtn+100];
        [btn setImage:navBarImageArr[selectNavBtn-1] forState:UIControlStateNormal];
        selectNavBtn = sender.tag-100;
        [sender setImage:navBarImageArr[selectNavBtn+3-1] forState:UIControlStateNormal];
    }
    
}

- (void)searchBtnAction:(id)sender
{
    BMKPlanNode *start = [[BMKPlanNode alloc]init];
    start.pt = change.origin;
    BMKPlanNode *end = [[BMKPlanNode alloc]init];
    end.pt = change.endPoint;
    NSLog(@"%f --- %f   ||||||   %f --- %f      ||||||   %@",start.pt.latitude,start.pt.longitude,end.pt.latitude,end.pt.longitude,change.city);
    [[KeyWordSearchModel keyWordModel] requearRouteSearchWithStartPoint:start endPoint:end city:change.city andBlock:^(id result)
    {
        
        BMKTransitRouteResult *data = (BMKTransitRouteResult *)result;
        for (BMKTransitRouteLine *routeline in data.routes)
        {
            NSLog(@"*---------------*%@",routeline.steps);
            NSLog(@"%d ..  %@",routeline.distance,routeline.duration);
            for (int i = 0; i < routeline.steps.count ; i++)
            {
                
                if ([routeline.steps[i] isKindOfClass:[BMKWalkingStep class]])
                {
                    BMKWalkingStep *transit = routeline.steps[i];
                    NSLog(@"换乘说明--： %@",transit.instruction);
                    NSLog(@"换乘说明-entrace-： %@",transit.entraceInstruction);
                    NSLog(@"换乘说明-exit-： %@",transit.exitInstruction);
                    
                }
                else if ([routeline.steps[i] isKindOfClass:[BMKDrivingStep class]])
                {
                    
                }
                
                if ([routeline.steps[i] isKindOfClass:[BMKTransitStep class]])
                {
                    BMKTransitStep *transit = routeline.steps[i];
                    NSLog(@"换乘说明--： %@",transit.instruction);
                    NSLog(@"公交名--： %@  站数%d",transit.vehicleInfo.uid ,transit.vehicleInfo.passStationNum);
                }
            }
        }
    }];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
