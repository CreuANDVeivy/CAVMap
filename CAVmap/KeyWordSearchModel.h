//
//  KeyWordSearchModel.h
//  CAVmap
//
//  Created by Ibokan on 14-10-20.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import <Foundation/Foundation.h>

// 接收数据
typedef void(^receiveDataBlock)(id);

@interface KeyWordSearchModel : NSObject <BMKPoiSearchDelegate,BMKRouteSearchDelegate>
{
    receiveDataBlock currentBlock;  // 点评块
    receiveDataBlock baiduBlock;  // 兴趣点检索块
    receiveDataBlock detailBlock;  // 详情块
    receiveDataBlock routeSearchBlock;  // 路径检索块
    BMKRouteSearch *_searcher;  // 路径检索
}

// 发送周边检索请求
- (void)requestDataWith:(NSString*)keyWord currentLocation:(CLLocationCoordinate2D)location block:(receiveDataBlock)block;

// POI检索
- (void)requestBaiduDetailDataWithUid:(NSString *)uid andBlock:(receiveDataBlock)block;

// 点评检索
- (void)requestDataWithUrl:(NSString *)url params:(NSString *)params reponse:(receiveDataBlock)block;

// 路径检索
-(void)requearRouteSearchWithStartPoint:(BMKPlanNode *)startNode endPoint:(BMKPlanNode *)endNode city:(NSString *)city andBlock:(receiveDataBlock)block;

//单例
+ (KeyWordSearchModel *)keyWordModel;

@end

