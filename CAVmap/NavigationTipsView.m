//
//  NavigationTipsView.m
//  CAVmap
//
//  Created by Ibokan on 14-10-23.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "NavigationTipsView.h"

@implementation NavigationTipsView

@synthesize location;
@synthesize title;
@synthesize mapP;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithMapPoi:(BMKMapPoi *)mapPoi
{
    self = [super init];
    if (self)
    {
        mapP = mapPoi;
        
        self.frame = kFrame(-kScreenWidth, kScreenHeight-145, kScreenWidth-45, 100);
        
        
        self.layer.shadowOffset = CGSizeMake(0, 3); //设置阴影的偏移量
        self.layer.shadowRadius = 5.0;  //设置阴影的半径
        self.layer.shadowColor = [UIColor blackColor].CGColor; //设置阴影的颜色为黑色
        self.layer.shadowOpacity = 0.2; //设置阴影的不透明度
        
        [UIView setLayerWithView:self];
        
        [self addSubview:[UIImageView addSeparateLineWithFrame:kFrame(0, 70, kScreenWidth-45, 1)]];
        
        UIImageView *separa = [[UIImageView alloc]initWithFrame:kFrame((kScreenWidth-45)/2, 75, 1, 20)];
        separa.image = [UIImage imageNamed:@"Aboutpage_SeparatorLine_Vertical@2x"];
        [self addSubview:separa];
        
        title = [[UILabel alloc]initWithFrame:kFrame(10, 10, 200, 15)];
        title.textColor = [UIColor blackColor];
        title.text = mapPoi.text;
        title.font = [UIFont fontWithName:@"Bodoni 72 Smallcaps" size:15];
        [self addSubview:title];
        
        NSArray *imageArr = @[[UIImage imageNamed:@"icon_open_route"],[UIImage imageNamed:@"iconNearbyButton@2x"]];
        NSArray *textArr = @[@"搜周边",@"到这去"];
        for (int i = 0; i < imageArr.count; i++)
        {
            UIButton *btn = [UIButton packageButtonWithImage:imageArr[i] Title:textArr[i] Frame:kFrame(0, 0, (kScreenWidth-45)/2, 30)];
            btn.frame = kFrame((kScreenWidth-45)/2*i, 70, (kScreenWidth-45)/2, 30);
            [self addSubview:btn];
        }
        
    }
    
    return self;
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
