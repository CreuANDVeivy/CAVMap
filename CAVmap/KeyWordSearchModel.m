//
//  KeyWordSearchModel.m
//  CAVmap
//
//  Created by Ibokan on 14-10-20.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "KeyWordSearchModel.h"
#import "AppDelegate.h"

@implementation KeyWordSearchModel


- (void)requestDataWith:(NSString *)keyWord currentLocation:(BMKUserLocation*)location block:(receiveDataBlock)block
{
    // 初始化检索对象
    BMKPoiSearch *searcher = [[BMKPoiSearch alloc]init];
    searcher.delegate = self;
    // 发起检索
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.pageIndex = 1;
    option.pageCapacity = 10;
    option.location = location.location.coordinate;
    option.keyword = keyWord;
    BOOL flag = [searcher poiSearchNearBy:option];
    //    [option release];
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }
    currentBlock = block;
}

// 实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR)
    {
        currentBlock(poiResultList);
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD)
    {
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else
    {
        NSLog(@"抱歉，未找到结果");
    }
}

- (void)requestDataWith:(NSString*)url params:(NSString*)params block:(receiveDataBlock)block errorBlock:(receiveDataBlock)errorblock
{
    [[[AppDelegate instance] dpapi] requestWithURL:url paramsString:params delegate:self];
    dpBlock = block;
    errorBlock = errorblock;
}


- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    errorBlock(error);
}

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
	dpBlock(result);
}

@end
