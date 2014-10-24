//
//  HotWordSearchDetailViewController.h
//  CAVmap
//
//  Created by 3024 on 14-10-21.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "BaseViewController.h"
#import "SelectView.h"
#import "UIView+CustomActivity.h"
#import "MJRefresh/MJRefresh.h"
//#import "BMKNavigation.h"



@interface HotWordSearchDetailViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate>



@property (retain, nonatomic) UIView *selectView;
@property (retain, nonatomic) UITableView *searchDetialTableView;




@end