//
//  KeyWordSearchModel.h
//  CAVmap
//
//  Created by Ibokan on 14-10-20.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import <Foundation/Foundation.h>

// 接收数据
typedef void(^receiveDataBlock)(BMKPoiResult*);

@interface KeyWordSearchModel : NSObject <BMKPoiSearchDelegate>
{
    receiveDataBlock currentBlock;
}

// 发送周边检索请求
- (void)RequertDataWith:(NSString*)keyWord currentLocation:(BMKUserLocation*)location block:(receiveDataBlock)block;

@end
