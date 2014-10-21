//
//  hotWordSearchModelData.m
//  CAVmap
//
//  Created by 3024 on 14-10-20.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "hotWordSearchModelData.h"

@implementation hotWordSearchModelData

@synthesize hotWordSearchDataDict,quickNavigationDict,dinnerDict,hotelDict,amusementDict,trafficDict,lifeDict,recommendDict;


- (void)loadData
{
    // 快速导航
    quickNavigationDict = [[NSMutableDictionary alloc] initWithCapacity:8];  // 初始化数组
    NSArray *quickImageName = @[@"dinner",@"hotel",@"zhoumoqunaer",@"scenic",@"group",@"taxi",@"cinema",@"bus"];
    NSArray *quickTitleName = @[@"找美食",@"订酒店",@"周末去哪儿",@"搜景点",@"查团购",@"出租车",@"看电影",@"公交站"];
    for (int i = 0; i < quickImageName.count; i ++)
    {
        NSString *str = [NSString stringWithFormat:@"%@.jpg",quickImageName[i]];
        [quickNavigationDict setObject:[UIImage imageNamed:str] forKey:quickTitleName[i]];
    }
    // 美食
    dinnerDict = [[NSMutableDictionary alloc] init];
    hotelDict = [[NSMutableDictionary alloc] init];
    amusementDict = [[NSMutableDictionary alloc] init];
    trafficDict = [[NSMutableDictionary alloc] init];
    lifeDict = [[NSMutableDictionary alloc] init];
    recommendDict = [[NSMutableDictionary alloc] init];
    NSArray *arr = @[dinnerDict,hotelDict,amusementDict,trafficDict,lifeDict,recommendDict];
//    NSArray *image1 = 
    
    
    /*
    NSArray *arr1 = @[@"美食",@"中餐",@"小吃快餐",@"川菜",@"西餐",@"火锅",@"肯德基"];
    NSArray *arr2 = @[@"酒店",@"快捷酒店",@"星级酒店",@"青年旅社",@"旅馆",@"招待所",@"特价酒店"];
    NSArray *arr3 = @[@"休闲娱乐",@"电影院",@"KTV",@"酒吧",@"咖啡厅",@"网吧",@"商场"];
    NSArray *arr4 = @[@"交通设施",@"公交站",@"加油站",@"火车票代售点",@"长途汽车站",@"停车场",@"火车站"];
    NSArray *arr5 = @[@"生活服务",@"超市",@"药店",@"ATM",@"银行",@"医院",@"厕所"];
    NSArray *arr6 = @[@"特色推荐",@"著名景点",@"特色美食",@"宾馆",@"购物",@"地铁线路",@"机场车站"];
    */
    
    
    NSLog(@"%d",arr.count);
    
    
}

- (void)saveImageAndTitleWithDict:(NSMutableDictionary *)dict Images:(NSArray *)arr Title:(NSArray *)title
{
    if (arr.count > 0)
    {
        // 添加两张图片信息
        UIImage *iamge1 = arr[0];
        UIImage *iamge2 = arr[1];
        [dict setObject:iamge1 forKey:@"image1"];
        [dict setObject:iamge2 forKey:@"image2"];
        // 将标题添加到字典中
        for (int i = 0; i < title.count; i ++)
        {
            [dict setObject:title[i] forKey:title[i]];
        }
    }
}


@end
