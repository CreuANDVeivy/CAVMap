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

@interface KeyWordSearchModel : NSObject <BMKPoiSearchDelegate>
{
    receiveDataBlock currentBlock;
    receiveDataBlock baiduBlock;
    receiveDataBlock detailBlock;
    
}

// 发送周边检索请求
- (void)requestDataWith:(NSString*)keyWord currentLocation:(CLLocationCoordinate2D)location block:(receiveDataBlock)block;

// POI检索
- (void)requestBaiduDetailDataWithUid:(NSString *)uid andBlock:(receiveDataBlock)block;

// 点评检索
- (void)requestDataWithUrl:(NSString *)url params:(NSString *)params reponse:(receiveDataBlock)block;

//单例
+ (KeyWordSearchModel *)keyWordModel;

@end

