//
//  DianPingPoiSearchType.m
//  CAVmap
//
//  Created by Ibokan on 14-10-22.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "DianPingPoiSearchType.h"

@implementation DianPingPoiSearchType



@end

@implementation DetailPageDataInfo

@synthesize photo_url,name,comment,price,storeName,address,distance;

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if (self)
    {
        photo_url = [dict objectForKey:@"s_photo_url"];
        name = [dict objectForKey:@"name"];
        comment = [dict objectForKey:@"rating_img_url"];
        price = [NSString stringWithFormat:@"%@",[dict objectForKey:@"avg_price"]];
        storeName = [dict objectForKey:@"categories"];
        address = [dict objectForKey:@"address"];
        distance = [dict objectForKey:@"distance"];
        
    }

    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name = %@  address = %@",name,address];
}

@end