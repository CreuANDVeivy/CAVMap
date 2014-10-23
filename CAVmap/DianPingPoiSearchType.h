//
//  DianPingPoiSearchType.h
//  CAVmap
//
//  Created by Ibokan on 14-10-22.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DianPingPoiSearchType : NSObject

@end

@interface DetailPageDataInfo : NSObject

@property (retain, nonatomic) NSString *photo_url;  // 详情的图片视图
@property (retain, nonatomic) NSString *name;  // 详情标题
@property (retain, nonatomic) NSString *comment;  // 星评视图
@property (retain, nonatomic) NSString *price;  // 价格标签
@property (retain, nonatomic) NSSet *storeName;  // 商店名
@property (retain, nonatomic) NSString *address;  // 商店地址
@property (retain, nonatomic) NSString *distance;  // 距离

- (id)initWithDictionary:(NSDictionary *)dict;

@end
