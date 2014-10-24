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

@interface KeyWordSearchModel : NSObject <BMKPoiSearchDelegate,DPRequestDelegate>
{
    receiveDataBlock currentBlock;
    receiveDataBlock errorBlock;
    receiveDataBlock dpBlock;
}

// 发送周边检索请求
- (void)requestDataWith:(NSString*)keyWord currentLocation:(CLLocationCoordinate2D)location block:(receiveDataBlock)block;
// 点评检索
- (void)requestDataWith:(NSString*)url params:(NSString*)params block:(receiveDataBlock)block errorBlock:(receiveDataBlock)errorblock;
@end
