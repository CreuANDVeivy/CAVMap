//
//  HomeAndCompenyView.m
//  CAVmap
//
//  Created by Ibokan on 14-10-24.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "HomeAndCompenyView.h"

@implementation HomeAndCompenyView

@synthesize home,compeny;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (id)onlyHomeAndCompenyView
{
    static HomeAndCompenyView *homeAndCompeny;
    if (!homeAndCompeny)
    {
        homeAndCompeny = [[HomeAndCompenyView alloc]init];
    }
    
    return homeAndCompeny;
}

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.98];
        self.frame = kFrame(0, 0, kScreenWidth-10, 80);
        
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.4].CGColor;
        self.layer.cornerRadius = 2;
        self.layer.masksToBounds = NO;
        
        NSArray *icon = @[[UIImage imageNamed:@"icon_home@2x.png"],[UIImage imageNamed:@"icon_company@2x.png"]];
        NSArray *text = @[@"回家",@"去公司"];
        
        void(^labelBlock)(UILabel *) = ^(UILabel *label){
            label.text = @"点击设置";
            label.textColor = [UIColor grayColor];
            label.font = [UIFont systemFontOfSize:14];
            label.userInteractionEnabled = NO;
        };
        
        for (int i = 0 ; i < icon.count; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom
                                               frame:kFrame(0, i*40, kScreenWidth-20, 40)
                                               image:[UIImage imageNamed:@"game_detail_header_bg.jpg"]
                                               title:nil
                                              target:self
                                           andAction:@selector(homeOrCompanyAction:)];
            btn.tag = 101+i;
            btn.imageView.layer.opacity = 0.1;
            [self addSubview:btn];
            
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:kFrame(10, 10, 20, 20)];
            imageV.image = icon[i];
            [btn addSubview:imageV];
            
            
            UILabel *label = [[UILabel alloc]initWithFrame:kFrame(40, 10, 40+i*20, 20)];
            label.text = text[i];
            label.userInteractionEnabled = NO;
            label.font = [UIFont systemFontOfSize:14];
            [btn addSubview:label];
            
            if (i == 0)
            {
                home = [[UILabel alloc]initWithFrame:kFrame(80, 10, 260, 20)];
                labelBlock(home);
                [btn addSubview:home];

            }
            else
            {
                compeny = [[UILabel alloc]initWithFrame:kFrame(100, 10, 240, 20)];
                labelBlock(compeny);
                [btn addSubview:compeny];
                
            }
            
        }
        // 添加分隔线
        [self addSubview:[UIImageView addSeparateLineWithFrame:kFrame(0, 40, kScreenWidth-20, 1)]];
        
        
    }
    return self;
}

- (void)homeOrCompanyAction:(UIButton *)sender
{
    if (sender.tag == 101)
    {
        
        
    }
    else
    {
        
    }
    
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
