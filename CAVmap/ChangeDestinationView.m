//
//  ChangeDestinationView.m
//  CAVmap
//
//  Created by Ibokan on 14-10-24.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "ChangeDestinationView.h"

@implementation ChangeDestinationView

@synthesize myLocation,selectPoint;
@synthesize viewController;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
        
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
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect
                                                         frame:kFrame(80, 10+40*i, 80, 20)
                                                         image:nil
                                               title:textArr[i] target:self andAction:@selector(setLocationAction:)];
            
            btn.tag = 101+i;
            [self addSubview:btn];
            
            i == 1 ? ([btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal]):nil;
            i == 0 ? (upRect = btn.frame) : (downRect = btn.frame);
            
            
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:kFrame(65, 12.5+40*i, 15, 15)];
            imageV.image = imageArr[i];
            imageV.tag = 111+i;
            [self addSubview:imageV];
            i == 0 ? (upPoi = imageV.frame) : (downPoi = imageV.frame);
            
        }
        
    }
    return self;
}

// 交换方法
- (void)changeBtnAction:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        for (int i = 0; i < 2; i++)
        {
            UIButton *btn = (UIButton *)[self viewWithTag:101+i];
            btn.frame.origin.y == downRect.origin.y ? (btn.frame = upRect) : (btn.frame = downRect);
            
            UIImageView *imageV = (UIImageView *)[self viewWithTag:111+i];
            imageV.frame.origin.y == upPoi.origin.y ? (imageV.frame = downPoi) : (imageV.frame = upPoi);

        }
    }];
}


- (void)setLocationAction:(id)sender
{
    RouteSearchViewController *serarch = [[RouteSearchViewController alloc]init];
    
    [viewController.navigationController pushViewController:serarch animated:YES];
    
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
