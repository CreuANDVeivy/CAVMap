//
//  DrivingNavgationViewController.m
//  CAVmap
//
//  Created by 3024 on 14-10-24.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "DrivingNavgationViewController.h"
#import "HomeAndCompenyView.h"

@interface DrivingNavgationViewController ()

@end


#define Margin 10  // 页边空白距离
#define NavHeight 60  // 导航栏的高度

@implementation DrivingNavgationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    /*
    // 初始化导航SDK引擎
    [BNCoreServices_Instance initServices:@"Ip0w2mkmc7lZmBbulpx8MpFR"];
    
    //开启引擎，传入默认的TTS类
    [BNCoreServices_Instance startServicesAsyn:nil fail:nil SoundService:[BNaviSoundManager getInstance]];
   */
    // 设置背景
    self.view.backgroundColor =  [UIColor colorWithWhite:0.8 alpha:1.0];
    
    // 初始化导航SDK引擎
    [BNCoreServices_Instance initServices:@"Ip0w2mkmc7lZmBbulpx8MpFR"];
    
    //开启引擎，传入默认的TTS类
    [BNCoreServices_Instance startServicesAsyn:nil fail:nil SoundService:[BNaviSoundManager getInstance]];

    [self addSearchButton];
    
    [self initDestinationSearchBar];
  
    
}


#pragma mark - Init Search
- (void)initDestinationSearchBar
{
    // 搜索的整个按钮
    BaseButton *destinationInputView = [BaseButton buttonWithType:UIButtonTypeCustom];
    destinationInputView.frame = kFrame(Margin, NavHeight + Margin, kScreenWidth - 2*Margin, 40);
    // 设置边框风格
    [self setBorderStyle:destinationInputView];

    // 添加输入按钮防方法
    [destinationInputView addTarget:self action:@selector(inputClicksAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:destinationInputView];
    // 图片
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_searchbox_magnifier_2"] highlightedImage:[UIImage imageNamed:@"common_icon_searchbox_magnifier_2"]];
    imageView.frame = kFrame(2 * Margin, 11, 18, 18);
    [destinationInputView addSubview:imageView];
    // 文本
    UILabel *tipsText = [[UILabel alloc] initWithFrame:kFrame(4 * Margin + 5, Margin, 150, 20)];
    tipsText.text = @"输入目的地";
    tipsText.font = [UIFont systemFontOfSize:13];
    [destinationInputView addSubview:tipsText];
    
    // 公司  家 地址设置视图
    HomeAndCompenyView *home = [HomeAndCompenyView onlyHomeAndCompenyView];
    home.frame = kFrame(Margin, 120, kScreenWidth - 2 * Margin, 80);
    [self.view addSubview:home];
    
    // 驾车助手视图
    UIView *driveAssistantView = [[UIView alloc] initWithFrame:kFrame(Margin, 210, kScreenWidth -2 * Margin, 80)];
    // 设置边框风格
    [self setBorderStyle:driveAssistantView];
    [self.view addSubview:driveAssistantView];
    // 添加分隔线
    [driveAssistantView addSubview:[UIImageView addSeparateLineWithFrame:kFrame(0, 30, kScreenWidth - Margin*2 , 1)]];
    // 驾车助手
    UILabel *assisant = [[UILabel alloc] initWithFrame:kFrame(8, Margin/2, 80, 20)];
    assisant.text = @"驾车助手";
    assisant.font = [UIFont systemFontOfSize:13];
    [driveAssistantView addSubview:assisant];
    
  
}


#pragma mark - SetBorderStytle

- (void)setBorderStyle:(id)sender
{
    UIView *view = (UIView *)sender;
    view.backgroundColor =  [UIColor colorWithWhite:1 alpha:0.98];
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.4].CGColor;
}


#pragma mark - ButtonClickAction

- (void)inputClicksAction:(BaseButton *)sender
{
    NSLog(@"输入目的地");
}

- (void)searchButtonClicksAction:(UIButton *)sender
{
    [self startNavi];
}

// 开始导航
- (void)startNavi
{
    NSMutableArray *nodesArray = [[NSMutableArray alloc]initWithCapacity:2];
    //起点 传入的是原始的经纬度坐标，若使用的是百度地图坐标，可以使用BNTools类进行坐标转化
    BNRoutePlanNode *startNode = [[BNRoutePlanNode alloc] init];
    startNode.pos = [[BNPosition alloc] init];
    startNode.pos.x = 116.30142;
    startNode.pos.y = 40.05087;
    startNode.pos.eType = BNCoordinate_OriginalGPS;
    [nodesArray addObject:startNode];
    
    //也可以在此加入1到3个的途经点
    
    BNRoutePlanNode *midNode = [[BNRoutePlanNode alloc] init];
    midNode.pos = [[BNPosition alloc] init];
    midNode.pos.x = 116.12;
    midNode.pos.y = 39.08087;
    midNode.pos.eType = BNCoordinate_OriginalGPS;
    [nodesArray addObject:midNode];
    
    //终点
    BNRoutePlanNode *endNode = [[BNRoutePlanNode alloc] init];
    endNode.pos = [[BNPosition alloc] init];
    endNode.pos.x = 116.39750;
    endNode.pos.y = 39.90882;
    endNode.pos.eType = BNCoordinate_OriginalGPS;
    [nodesArray addObject:endNode];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [BNCoreServices_RoutePlan startNaviRoutePlan:BNRoutePlanMode_Recommend naviNodes:nodesArray time:nil delegete:self userInfo:dict];
    
    
}


#pragma mark - BNNaviRoutePlanDelegate
//算路成功回调
-(void)routePlanDidFinished:(NSDictionary *)userInfo
{

    //路径规划成功，开始导航
    [BNCoreServices_UI showNaviUI:BN_NaviTypeReal delegete:self isNeedLandscape:YES];
}

//算路失败回调
- (void)routePlanDidFailedWithError:(NSError *)error andUserInfo:(NSDictionary *)userInfo
{
    NSLog(@"算路失败");
    if ([error code] == BNRoutePlanError_LocationFailed) {
        NSLog(@"获取地理位置失败");
    }
    else if ([error code] == BNRoutePlanError_LocationServiceClosed)
    {
        NSLog(@"定位服务未开启");
    }
}

//算路取消回调
-(void)routePlanDidUserCanceled:(NSDictionary*)userInfo {
    NSLog(@"算路取消");
}

#pragma mark - BNNaviUIManagerDelegate

//退出导航回调
-(void)onExitNaviUI:(NSDictionary*)extraInfo
{
    NSLog(@"退出导航");
}

//退出导航声明页面回调
- (void)onExitexitDeclarationUI:(NSDictionary*)extraInfo
{
    NSLog(@"退出导航声明页面");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
