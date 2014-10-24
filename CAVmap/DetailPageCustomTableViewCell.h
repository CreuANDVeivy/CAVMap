//
//  DetailPageCustomTableViewCell.h
//  CAVmap
//
//  Created by 3024 on 14-10-22.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailPageCustomTableViewCell : UITableViewCell


{
    int flag;  // 记录导航按钮个数
}


@property (retain, nonatomic) UIImageView *imageView_Dinner;  // 详情的图片视图
@property (retain, nonatomic) UILabel *titleLabel_Dinner;  // 详情标题
@property (retain, nonatomic) UIImageView *comment_Dinner;  // 星评视图
@property (retain, nonatomic) UILabel *priceLabel_Dinner;  // 价格标签
@property (retain, nonatomic) UILabel *storeType_Dinner;  // 商类型
@property (retain, nonatomic) UILabel *address_Dinner;  // 商店地址
@property (retain, nonatomic) UILabel *distanceLabel_Dinner;  // 距离


// 导航按钮的方法  (他的tag值是从1021 递增的)
- (void)navigationClicksAction:(UIButton *)sender;


@end
