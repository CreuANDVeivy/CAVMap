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

#pragma mark - 百度检索

- (void)requestDataWith:(NSString *)keyWord currentLocation:(CLLocationCoordinate2D )location block:(receiveDataBlock)block
{
    // 初始化检索对象
    BMKPoiSearch *searcher = [[BMKPoiSearch alloc]init];
    searcher.delegate = self;
    // 发起检索
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.pageIndex = 1;
    option.pageCapacity = 10;
    option.location = location;
    option.keyword = keyWord;
    BOOL flag = [searcher poiSearchNearBy:option];
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }
    baiduBlock = block;
}

- (void)requestBaiduDetailDataWithUid:(NSString *)uid andBlock:(receiveDataBlock)block
{
    
    BMKPoiSearch *searcher = [[BMKPoiSearch alloc]init];
    searcher.delegate = self;
    
    //POI详情检索
    BMKPoiDetailSearchOption* option = [[BMKPoiDetailSearchOption alloc] init];
    option.poiUid = uid;//POI搜索结果中获取的uid
    BOOL flag = [searcher poiDetailSearch:option];

    if(flag)
    {
        //详情检索发起成功
    }
    else
    {
        //详情检索发送失败
    }
    detailBlock = block;
    
}

#pragma mark - 百度路劲检索
-(void)requearRouteSearchWithStartPoint:(BMKPlanNode *)startNode endPoint:(BMKPlanNode *)endNode city:(NSString *)city andBlock:(receiveDataBlock)block
{
    routeSearchBlock = block;
    //初始化检索对象
    _searcher = [[BMKRouteSearch alloc]init];
    _searcher.delegate = self;
    //发起检索
    BMKTransitRoutePlanOption *transitRouteSearchOption = [[BMKTransitRoutePlanOption alloc]init];
    transitRouteSearchOption.city= city;
    transitRouteSearchOption.from = startNode;
    transitRouteSearchOption.to = endNode;
    BOOL flag = [_searcher transitSearch:transitRouteSearchOption];
    
    if(flag)
    {
        NSLog(@"bus检索发送成功");
    }
    else
    {
        NSLog(@"bus检索发送失败");
    }
}

//实现Deleage处理回调结果
-(void)onGetTransitRouteResult:(BMKRouteSearch*)searcher result:(BMKTransitRouteResult*)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR)
    {
        //在此处理正常结果
//        NSLog(@"%@",result);
        
        routeSearchBlock(result);
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR)
    {
        //当路线起终点有歧义时通，获取建议检索起终点
        //result.routeAddrResult
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
    _searcher.delegate = nil;
}

-(void)onGetPoiDetailResult:(BMKPoiSearch *)searcher result:(BMKPoiDetailResult *)poiDetailResult errorCode:(BMKSearchErrorCode)errorCode
{
    if(errorCode == BMK_SEARCH_NO_ERROR)
    {
        //在此处理正常结果
        detailBlock(poiDetailResult);
    }
}


// 实现PoiSearchDeleage处理回调结果
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR)
    {
        // 完成请求
        
        baiduBlock(poiResultList);
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

+ (KeyWordSearchModel *)keyWordModel
{
    static KeyWordSearchModel *keyWord;
    
    if (!keyWord)
    {
        keyWord = [[KeyWordSearchModel alloc]init];
    }
    
    return keyWord;
}

- (void)requestDataWithUrl:(NSString *)url params:(NSString *)params reponse:(receiveDataBlock)block
{
    kAddObserver(self, @selector(receiveData:),kReceiveData, nil);
    
    [[[AppDelegate instance] dpapi] requestWithURL:url paramsString:params delegate:nil];
    currentBlock = block;
}

- (void)receiveData:(NSNotification *)sender
{
    currentBlock(sender.object);
    kRemover(self, kReceiveData, nil);
}

@end
