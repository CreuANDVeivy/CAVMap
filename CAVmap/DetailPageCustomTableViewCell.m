//
//  DetailPageCustomTableViewCell.m
//  CAVmap
//
//  Created by 3024 on 14-10-22.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "DetailPageCustomTableViewCell.h"

@implementation DetailPageCustomTableViewCell


@synthesize imageView_Dinner,titleLabel_Dinner,comment_Dinner,priceLabel_Dinner,storeType_Dinner,address_Dinner,distanceLabel_Dinner;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {

        [self.contentView addSubview:[self customTableViewCell_Dinner]];
    }
    return self;
}

#pragma mark - CustomTableViewCell

- (UIView *)customTableViewCell_Dinner
{
    UIView *view = [[UIView alloc] initWithFrame:kFrame(10, 0, kScreenWidth - 2*10, 120)];
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = [UIColor grayColor].CGColor;
    view.backgroundColor = [UIColor whiteColor];
    
    imageView_Dinner = [[UIImageView alloc] initWithFrame:kFrame(5, 5, 80, 80)];
    // 这里用SDWebImage请求图片
    imageView_Dinner.image = [UIImage imageNamed:@"dinner.png"];
    [view addSubview:imageView_Dinner];
    
    // 标题
    titleLabel_Dinner = [[UILabel alloc] initWithFrame:kFrame(90, 5, kScreenWidth - 70 - 20, 25)];
    titleLabel_Dinner.text = @"1.广州城市青年旅舍";
    titleLabel_Dinner.font = [UIFont systemFontOfSize:12];
    [view addSubview:titleLabel_Dinner];
    // 星评
    comment_Dinner = [[UIImageView alloc] initWithFrame:kFrame(90, 30 + 10,60, 10)];
    comment_Dinner.image = [UIImage imageNamed:@"indoor_loc_suc.png"];
    [view addSubview:comment_Dinner];
    
    // 价格
    priceLabel_Dinner = [[UILabel alloc] initWithFrame:kFrame(300 - 80 - 10, 30 + 10, 80, 15)];
    priceLabel_Dinner.text = @"￥54";
    priceLabel_Dinner.textAlignment = NSTextAlignmentRight;
    priceLabel_Dinner.textColor = [UIColor orangeColor];
    priceLabel_Dinner.font = [UIFont systemFontOfSize:10];
    [view addSubview:priceLabel_Dinner];
    
    // 店名
    storeType_Dinner = [[UILabel alloc] initWithFrame:kFrame(90, 50 + 15, (kScreenWidth - 90 - 20 - 80)/2, 15)];
    storeType_Dinner .text = @"青年旅舍";
    storeType_Dinner.textAlignment = NSTextAlignmentLeft;
    storeType_Dinner.font = [UIFont systemFontOfSize:10];
    [view addSubview:storeType_Dinner];
    
    // 地址
    address_Dinner = [[UILabel alloc] initWithFrame:kFrame(90 + (kScreenWidth - 90 - 20 - 80)/2 , 50 + 15, 100, 15)];
    address_Dinner .text = @"火车站";
    address_Dinner.textAlignment = NSTextAlignmentLeft;
    address_Dinner.font = [UIFont systemFontOfSize:10];
    [view addSubview:address_Dinner];
    
    // 距离
    distanceLabel_Dinner = [[UILabel alloc] initWithFrame:kFrame(300 - 10 - 80, 65,80, 15)];
    distanceLabel_Dinner.text = @"203 m";
    distanceLabel_Dinner.textAlignment = NSTextAlignmentRight;
    distanceLabel_Dinner.font = [UIFont systemFontOfSize:8];
    [view addSubview:distanceLabel_Dinner];
    
    
    // 导航视图
    NSArray *titleArray = @[@"到这里去",@"电话"];
    NSArray *imageArray = @[[UIImage imageNamed:@"icon_open_route"],[UIImage imageNamed:@"icon_open_telephone"]];
    UIView *navgationView = [self addNavgationViewWithTitleArray:titleArray ImageArray:imageArray];
    navgationView.center = CGPointMake(kScreenWidth/2 - 10, 105);
    
    [view addSubview:navgationView];
    
    return view;
}

/*
- (UIView *)customTableViewCell_Dinner
{
    UIView *view = [[UIView alloc] initWithFrame:kFrame(10, 0, kScreenWidth - 2*10, 120)];
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = [UIColor grayColor].CGColor;
    view.backgroundColor = [UIColor whiteColor];
    
    imageView_Dinner = [[UIImageView alloc] initWithFrame:kFrame(5, 5, 80, 80)];
    // 这里用SDWebImage请求图片
    
    [view addSubview:imageView_Dinner];
    // 标题
    titleLabel_Dinner = [[UILabel alloc] initWithFrame:kFrame(90, 5, kScreenWidth - 70 - 20, 25)];
    titleLabel_Dinner.text = @"1.广州城市青年旅舍";
    titleLabel_Dinner.font = [UIFont systemFontOfSize:12];
    [view addSubview:titleLabel_Dinner];
    // 星评
    comment_Dinner = [[UIImageView alloc] initWithFrame:kFrame(90, 30 + 10, (kScreenWidth - 70 - 20) - 80, 15)];
    comment_Dinner.image = [UIImage imageNamed:@"indoor_loc_suc.png"];
    [view addSubview:comment_Dinner];
    
    // 价格
    priceLabel_Dinner = [[UILabel alloc] initWithFrame:kFrame(kScreenWidth - 80 - 10, 30 + 10, 80, 15)];
    priceLabel_Dinner.text = @"￥54";
    priceLabel_Dinner.textAlignment = NSTextAlignmentCenter;
    priceLabel_Dinner.font = [UIFont systemFontOfSize:10];
    [view addSubview:priceLabel_Dinner];
    
    // 店名
    storeName_Dinner = [[UILabel alloc] initWithFrame:kFrame(90, 50 + 15, (kScreenWidth - 90 - 20 - 80)/2, 15)];
    storeName_Dinner .text = @"青年旅舍";
    storeName_Dinner.textAlignment = NSTextAlignmentLeft;
    storeName_Dinner.font = [UIFont systemFontOfSize:10];
    [view addSubview:storeName_Dinner];
    
    // 地址
    AndAddress_Dinner = [[UILabel alloc] initWithFrame:kFrame(90 + (kScreenWidth - 90 - 20 - 80)/2 , 50 + 15, (kScreenWidth - 70 - 20) - 80/2, 15)];
    AndAddress_Dinner .text = @"火车站";
    AndAddress_Dinner.textAlignment = NSTextAlignmentLeft;
    AndAddress_Dinner.font = [UIFont systemFontOfSize:10];
    [view addSubview:AndAddress_Dinner];
    
    // 距离
    distanceLabel_Dinner = [[UILabel alloc] initWithFrame:kFrame(kScreenWidth - 10 - 80, 45 + 15, 80, 15)];
    distanceLabel_Dinner.text = @"203 m";
    distanceLabel_Dinner.textAlignment = NSTextAlignmentCenter;
    distanceLabel_Dinner.font = [UIFont systemFontOfSize:8];
    [view addSubview:distanceLabel_Dinner];
    
    
    // 导航视图
    NSArray *titleArray = @[@"到这里去",@"电话"];
    NSArray *imageArray = @[[UIImage imageNamed:@"icon_open_route"],[UIImage imageNamed:@"icon_open_telephone"]];
    UIView *navgationView = [self addNavgationViewWithTitleArray:titleArray ImageArray:imageArray];
    navgationView.center = CGPointMake(kScreenWidth/2 - 10, 105);
    
    [view addSubview:navgationView];
    
    return view;
}
*/

// cell下方的导航栏视图
- (UIView *)addNavgationViewWithTitleArray:(NSArray *)titleArray ImageArray:(NSArray *)imageArray
{
    UIView *view = [[UIView alloc] initWithFrame:kFrame(0, 0, kScreenWidth - 20, 30)];
    if (titleArray.count < 1)
    {
        return nil;
    }
    for (int i = 0; i < titleArray.count; i ++)
    {
        UIButton *btn = [self packageButtonWithImage:imageArray[i] Title:titleArray[i] Frame:kFrame(0, 0, (kScreenWidth - 20)/titleArray.count, 30)];
        btn.frame = kFrame(i * (kScreenWidth - 20)/titleArray.count, 0, (kScreenWidth - 20)/titleArray.count, 30);
        [view addSubview:btn];
    }
    return view;
}

// 封装导航按钮
- (UIButton *)packageButtonWithImage:(UIImage *)image Title:(NSString *)title Frame:(CGRect)frame
{
    UIButton *navgationBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    navgationBtn.frame = frame;
    navgationBtn.layer.borderWidth = 0.5;
    navgationBtn.layer.borderColor = [UIColor grayColor].CGColor;
    // 图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:kFrame(0, 0, 15, 15)];
    imageView.image = image;
    imageView.center = CGPointMake(frame.size.width/2 - 15/2.0, frame.size.height/2);
    [navgationBtn addSubview:imageView];
    // 文字
    UILabel *navgationTitle = [[UILabel alloc] initWithFrame:kFrame(0, 0, 40, 20)];
    navgationTitle.text = title;
    navgationTitle.textAlignment = NSTextAlignmentLeft;
    navgationTitle.font = [UIFont systemFontOfSize:10];
    navgationTitle.center = CGPointMake(frame.size.width/2 + 20, frame.size.height/2);
    [navgationBtn addSubview:navgationTitle];
    
    return navgationBtn;
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
