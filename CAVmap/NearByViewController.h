//
//  NearByViewController.h
//  CAVmap
//
//  Created by 3024 on 14-10-19.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "BaseViewController.h"

@interface NearByViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>

//@property (retain, nonatomic) BaseCollectionView *hotWordSearchView;  // 热词搜索视图


//
@property (retain, nonatomic) NSMutableArray *hotWordSearchDataSourceArray;  // 附近热词搜索视图数据源
@property (retain, nonatomic) BaseTableView *hotWordSearchTableView;  // 附近热词搜索视图


//
@end
