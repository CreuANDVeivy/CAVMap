//
//  ChangeDestinationView.m
//  CAVmap
//
//  Created by Ibokan on 14-10-24.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "ChangeDestinationView.h"

@implementation ChangeDestinationView

@synthesize origin,endPoint;
@synthesize viewController;
@synthesize city;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        
        isMylocation = isSelectLocation = NO;
        
        // 从哪去哪
        AMBlurView *blueView = [[AMBlurView alloc]initWithFrame:self.bounds];
        blueView.blurTintColor = [UIColor whiteColor];
        [self addSubview:blueView];
        
        // 变换按钮
        UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom
                                           frame:kFrame(25, 25, 30, 30)
                                           image:[UIImage imageNamed:@"icon_route_change@2x"]
                                           title:nil
                                          target:self
                                       andAction:@selector(changeBtnAction:)];
        [self addSubview:changeBtn];
        
        // 分割线
        [self addSubview:[UIImageView addSeparateLineWithFrame:kFrame(60, 40, kScreenWidth-60, 1)]];
        
        //
        NSArray *imageArr = @[[UIImage imageNamed:@"icon_route_location"],[UIImage imageNamed:@"icon_indoorDetail_min"]];
        NSArray *textArr = @[@"我的位置",@"输入终点"];
        
        for (int i = 0; i < textArr.count; i++)
        {
            UIView *btnView = [[UIView alloc]initWithFrame:kFrame(65, 40*i, kScreenWidth-75, 40)];
            btnView.tag = 101+i;
            
            UILabel *label = [[UILabel alloc]initWithFrame:kFrame(20, 10, 200, 20)];
            label.text = textArr[i];
            label.font = [UIFont systemFontOfSize:16];
            label.textColor = [UIColor colorWithRed:10/255.0 green:95/255.0 blue:254/255.0 alpha:1];
            
            i == 1 ? (label.textColor = [UIColor grayColor]) : nil;
            i == 0 ? (upRect = btnView.frame) : (downRect = btnView.frame);
            
            UITapGestureRecognizer *tap;
            tap = i == 0 ? ([[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelOneTapAction:)]) : ([[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTwoTapAction:)]) ;
            [btnView addGestureRecognizer:tap];
            
            [btnView addSubview:label];
            [self addSubview:btnView];
	
            
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:kFrame(0, 12.5, 15, 15)];
            imageV.image = imageArr[i];
            [btnView addSubview:imageV];
            
        }
        one = [MainViewController onlyOneMainViewController].currentLocation.location.coordinate;
        endPoint =  one;
        NSLog(@"origin === %f   %f",one.latitude,one.longitude);
        isMylocation = YES;
    }
    return self;
}

// 交换方法
- (void)changeBtnAction:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        for (int i = 0; i < 2; i++)
        {
            UIView *view = [self viewWithTag:101+i];
            view.frame.origin.y == downRect.origin.y ? (view.frame = upRect) : (view.frame = downRect);
            
            UILabel *label = view.subviews[0];
            
            if ([label.text isEqualToString:@"输入终点"])
            {
                label.text = @"输入起点";
            }
            else if ([label.text isEqualToString:@"输入起点"])
            {
                label.text = @"输入终点";
            }
        }
    }];
    

    if (isMylocation)
    {
        [self setImageViewWithTag:101 point:one];
    }
    if (isSelectLocation)
    {
        [self setImageViewWithTag:102 point:two];
    }
    NSLog(@"origin === %f   %f",origin.latitude,origin.longitude);
    NSLog(@"endPoint === %f   %f",endPoint.latitude,endPoint.longitude);
}

- (void)setImageViewWithTag:(int)tag point:(CLLocationCoordinate2D )coordinate
{
    UIView *view = [self viewWithTag:tag];
    UILabel *label = [view.subviews objectAtIndex:0];
    UIImageView *imageV = [view.subviews objectAtIndex:1];
    [self ifViewFrameWithSender:view YesBlocak:^{
        if (!isSelectLocation)
        {
            endPoint.latitude = 0;
            endPoint.longitude = 0;
        }
        origin = coordinate;
        
        tag == 101 ? ([label.text isEqualToString:@"我的位置"]) ? nil :(imageV.image = [UIImage imageNamed:@"icon_route_st@2x"]):(imageV.image = [UIImage imageNamed:@"icon_route_st@2x"]);
        
    } NoBlock:^{
        if (!isSelectLocation)
        {
            origin.latitude = 0;
            origin.longitude = 0;
        }
        
        endPoint = coordinate;
        tag == 101 ? ([label.text isEqualToString:@"我的位置"]) ? nil :(imageV.image = [UIImage imageNamed:@"icon_route_end@2x"]):(imageV.image = [UIImage imageNamed:@"icon_route_end@2x"]);
        ;
    }];
    
}

- (void)labelOneTapAction:(id)sender
{
    NSLog(@"101");
    UIView *view = [self viewWithTag:101];
    [self setLocationAction:view];
}

- (void)labelTwoTapAction:(id)sender
{
    NSLog(@"102");
    UIView *view = [self viewWithTag:102];
    [self setLocationAction:view];
}


// 选择地址
- (void)setLocationAction:(UIView *)sender
{
    RouteSearchViewController *search = [[RouteSearchViewController alloc]init];
    UIImageView *imageV = sender.subviews[1];
    [self ifViewFrameWithSender:sender YesBlocak:^{
        
        search.selectPointText = @"输入起点";
        
    } NoBlock:^{
        
        search.selectPointText = @"输入终点";
        
    }];

    [search realizeBlock:^(BMKReverseGeoCodeResult *result) {
        [self ifViewFrameWithSender:sender YesBlocak:^{
            imageV.image  = [UIImage imageNamed:@"icon_route_st@2x"];
            origin = result.location;
        } NoBlock:^{
            imageV.image  = [UIImage imageNamed:@"icon_route_end@2x"];
            endPoint = result.location;
        }];
        
        UIView *view = [self viewWithTag:101];
        if (sender == view)
        {
            isMylocation = YES;
            one = result.location;
        }
        else
        {
            isSelectLocation = YES;
            two = result.location;
        }
        UILabel *label = sender.subviews[0];
        label.textColor = [UIColor grayColor];
        label.text = result.address;
        
        city = result.addressDetail.city;
        NSLog(@"%@",city);
    }];
    
    [viewController.navigationController pushViewController:search animated:YES];
    
}

- (void)ifViewFrameWithSender:(UIView *)sender YesBlocak:(void(^)())yesBlock NoBlock:(void(^)())noBlock
{
    if (sender.frame.origin.y == upRect.origin.y)
        yesBlock();
    else
        noBlock();
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
