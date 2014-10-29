//
//  RouteSearchViewController.m
//  CAVmap
//
//  Created by Ibokan on 14-10-24.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "RouteSearchViewController.h"

@interface RouteSearchViewController ()
{
    UIView *activity;
}
@end

@implementation RouteSearchViewController

@synthesize selectPointText;
@synthesize textfield;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initTextField];  // 初始化textfieldd
    [self initView];  // 初始化视图
}

- (void)initView
{
    UIView *view = [[UIView alloc]initWithFrame:kFrame(10, 70, kScreenWidth-20, 40)];
    [UIView setLayerWithView:view];
    [self.view addSubview:view];
    
    // 分割线
    UIImageView *separa = [[UIImageView alloc]initWithFrame:kFrame((kScreenWidth-20)/2, 10, 1, 20)];
    separa.image = [UIImage imageNamed:@"Aboutpage_SeparatorLine_Vertical@2x"];
    [view addSubview:separa];
    
    NSArray *imageArr = @[[UIImage imageNamed:@"route_selptfrom_map"],[UIImage imageNamed:@"route_selptfrom_fav"]];
    NSArray *titleArr = @[@"地图选点",@"选点收藏"];
    
    for (int i = 0; i < imageArr.count; i++)
    {
        UIButton *btn = [UIButton packageButtonWithImage:imageArr[i]
                                                   Title:titleArr[i]
                                                   Frame:kFrame(0,0 , (kScreenWidth-20)/2, 20)];
        btn.frame = kFrame((kScreenWidth-20)/2*i-10, 10, (kScreenWidth-20)/2, 20);
        btn.tag = 101+i;
        [btn addTarget:self action:@selector(pointOrCollection:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    
    
}

- (void)pointOrCollection:(UIButton *)sender
{
    if (sender.tag == 101)
    {
        MapSelectPointViewController *map = [[MapSelectPointViewController alloc]init];
        // 获取坐标
        [map realizeBlock:^(CLLocationCoordinate2D *coordinate) {
            NSLog(@"%f   %f",coordinate->longitude,coordinate->latitude);
            //初始化地理编码类
            //注意：必须初始化地理编码类
            BMKGeoCodeSearch *_geoCodeSearch = [[BMKGeoCodeSearch alloc]init];
            _geoCodeSearch.delegate = self;
            //初始化逆地理编码类
            BMKReverseGeoCodeOption *reverseGeoCodeOption= [[BMKReverseGeoCodeOption alloc] init];
            //需要逆地理编码的坐标位置
            reverseGeoCodeOption.reverseGeoPoint = *(coordinate);
            [_geoCodeSearch reverseGeoCode:reverseGeoCodeOption];
            activity = [UIView creatCustomActivity];
            [self.view addSubview:activity];
            
        }];
        [self.navigationController pushViewController:map animated:YES];
    }
    else
    {
        
    }
}

#pragma mark - 初始化textfieldd

// nav搜索栏
- (void)initTextField
{
    textfield = [[BaseTextField alloc] initWithFrame:kFrame(50, 25, kScreenWidth-100, 30)];
    textfield.placeholder = selectPointText;
    textfield.font = [UIFont systemFontOfSize:14];
    [textfield becomeFirstResponder];
    textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    textfield.leftViewMode = UITextFieldViewModeAlways;
    textfield.delegate = self;
    textfield.returnKeyType = UIReturnKeySearch;
    UIView *sV = [[UIView alloc]initWithFrame:kFrame(10, 0, 30, 30)];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:kFrame(10,5, 18, 18)];
    imageV.image = [UIImage imageNamed:@"common_icon_searchbox_magnifier_2"];
    [sV addSubview:imageV];
    textfield.leftView = sV;
    textfield.backgroundColor = [UIColor colorWithWhite:1 alpha:0.98];
    textfield.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textfield];
    [textfield addKeyboardBtn];
    
    UIButton *searchBtn = [UIButton blueSystemButtonWithButtonType:UIButtonTypeRoundedRect title:@"搜索" frame:kFrame(kScreenWidth-45, 27.5, 40, 25)];
    [self.view addSubview:searchBtn];
    
    
}

#pragma mark - 地理编码

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
     //BMKReverseGeoCodeResult是编码的结果，包括地理位置，道路名称，uid，城市名等信息
    NSLog(@"%@  -- %@",result.address ,result.addressDetail);
    [activity removeFromSuperview];
    block(result);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)realizeBlock:(addressBlock)sender
{
    block = sender;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [textfield.keyBoardBtn setImage:[UIImage imageNamed:@"keyboard_btn_hide7@2x"] forState:UIControlStateNormal];
    return YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
