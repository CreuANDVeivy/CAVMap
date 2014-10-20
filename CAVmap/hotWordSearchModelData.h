//
//  hotWordSearchModelData.h
//  CAVmap
//
//  Created by 3024 on 14-10-20.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hotWordSearchModelData : NSObject

/*
 * 这里面取得的图片数据都是data型.请转化后使用
 */


//
@property (retain, nonatomic) NSMutableDictionary *hotWordSearchDataDict;  // 整个视图的数据字典
@property (retain, nonatomic) NSMutableDictionary *quickNavigationDict;  // 快速导航区域
@property (retain, nonatomic) NSMutableDictionary *dinnerDict;  // 美食
@property (retain, nonatomic) NSMutableDictionary *hotelDict;  // 酒店
@property (retain, nonatomic) NSMutableDictionary *amusementDict;  // 娱乐
@property (retain, nonatomic) NSMutableDictionary *trafficDict;  // 交通
@property (retain, nonatomic) NSMutableDictionary *lifeDict;  // 生活
@property (retain, nonatomic) NSMutableDictionary *recommendDict;  // 推荐

// 先加载数据
- (void)loadData;


@end
