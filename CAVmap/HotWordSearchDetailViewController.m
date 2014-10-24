//
//  HotWordSearchDetailViewController.m
//  CAVmap
//
//  Created by 3024 on 14-10-21.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "HotWordSearchDetailViewController.h"
#import "KeyWordSearchModel.h"
#import "DetailPageCustomTableViewCell.h"

@interface HotWordSearchDetailViewController ()

@end

@implementation HotWordSearchDetailViewController

@synthesize selectView,searchDetialTableView;

#pragma mark - Refresh -- 下拉刷新

/*
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.searchDetialTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
//#warning 自动刷新(一进入程序就下拉刷新)
    [self.searchDetialTableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.searchDetialTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.searchDetialTableView.headerPullToRefreshText = @"下拉刷新!";
    self.searchDetialTableView.headerReleaseToRefreshText = @"松开立即刷新了";
    self.searchDetialTableView.headerRefreshingText = @"正在加载刷新中";
    
    self.searchDetialTableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.searchDetialTableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.searchDetialTableView.footerRefreshingText = @"数据加载中，请稍后";
}
*/

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加假数据
//    for (int i = 0; i<5; i++) {
//        [self.fakeData insertObject:MJRandomData atIndex:0];
//    }
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.searchDetialTableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.searchDetialTableView headerEndRefreshing];
    });
}

- (void)footerRereshing
{
    // 1.添加假数据
//    for (int i = 0; i<5; i++) {
//        [self.fakeData addObject:MJRandomData];
//    }
    
    // 2.2秒后刷新表格UI
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.searchDetialTableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.searchDetialTableView footerEndRefreshing];
    });
}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [super addRightMapButton];  // 添加右边选择地图的按钮
    // 添加选择视图
    NSArray *title = @[@"范围",@"类别",@"排序"];
    UIView *select = [self mySelectViewWithTitleArray:title];
    select.center = CGPointMake(kScreenWidth/2, 74);
    [self.view addSubview:select];
    // 添加活动指示器
//    [self.view addSubview:[UIView creatCustomActivity]];
    // 初始化tableView
    [self initSearchDetialTableView];
     /*
    CLLocationCoordinate2D location = {23.13593,113.2563223};
    
    [keyword requestDataWith:@"中餐" currentLocation:location block:^(id result)
    {
//        BMKPoiResult *poi = (BMKPoiResult *)result;
//        for (BMKPoiInfo *info in poi.poiInfoList)
//        {
//             NSLog(@"%@",info);//BMKCityListInfo
//        }
    }];
    */

    // 添加刷新加载数据

    [self.searchDetialTableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.searchDetialTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
}

#pragma mark - InitMethod

// 初始化搜索数据的详情的表示图
- (void)initSearchDetialTableView
{
    searchDetialTableView = [[UITableView alloc] initWithFrame:kFrame(0, 90, kScreenWidth, kScreenHeight - 90) style:UITableViewStyleGrouped];
    // 设置代理
    searchDetialTableView.delegate = self;
    searchDetialTableView.dataSource = self;
    
    searchDetialTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:searchDetialTableView];
}

#pragma mark - SelectViewInit
// 添加选择的视图
- (UIView *)mySelectViewWithTitleArray:(NSArray *)titleName
{
    selectView = [[UIView alloc] initWithFrame:kFrame(-1, 0, kScreenWidth + 2, 30)];
    selectView.layer.borderWidth = 0.5;
    selectView.layer.borderColor = [UIColor grayColor].CGColor;
    
    for (int i = 0; i < titleName.count; i ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn addTarget:self action:@selector(changeSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1200 + i;
        btn.frame = kFrame(kScreenWidth/titleName.count*i, 0, kScreenWidth/titleName.count, 30);
        [selectView addSubview:btn];
        
        UILabel *title = [[UILabel alloc] initWithFrame:kFrame(32.5, 5, 50, 20)];
        title.font = [UIFont systemFontOfSize:12];
        title.text = titleName[i];
        [btn addSubview:title];
        
        UIButton *imageView = [UIButton buttonWithType:UIButtonTypeSystem];
        [imageView setImage:[UIImage imageNamed:@"sort_arrow_down_normal.png"] forState:0];
        imageView.frame = kFrame(60, 13, 6, 4);
        [imageView setTintColor:[UIColor grayColor]];
        [btn addSubview:imageView];
        
        UIImageView *spert = [[UIImageView alloc] initWithFrame:kFrame(i * 100 - 1, 7.5, 1, 15)];
        spert.image = [UIImage imageNamed:@"listitem_bg_down.9.png"];
        
        [selectView addSubview:spert];
        
    }
    return selectView;
}

#pragma mark - ButtonClicksAction
// 点击选择事件的方法
- (void)changeSelectAction:(UIButton *)sender
{
    for (int i = 0; i < 3; i ++)
    {
        UIButton *btn = (UIButton *)[[[selectView viewWithTag:1200 + i] subviews] objectAtIndex:1];
        [btn setTintColor:[UIColor grayColor]];
        btn.transform = CGAffineTransformMakeRotation(0);
        
        UILabel *label = (UILabel *)[[[selectView viewWithTag:1200 + i] subviews] objectAtIndex:0];
        label.textColor = [UIColor blackColor];
    }
    
    UILabel *label = (UILabel *)[[sender subviews] objectAtIndex:0];
    
    label.textColor = [UIColor colorWithRed:10/255.0 green:95/255.0 blue:254/255.0 alpha:1];
    
    UIButton *btn = (UIButton *)[[sender subviews] objectAtIndex:1];
    btn.transform = CGAffineTransformMakeRotation(M_PI);
    [btn setTintColor:[UIColor colorWithRed:10/255.0 green:95/255.0 blue:254/255.0 alpha:1]];
    
    NSLog(@"-------%ld",(long)sender.tag);
}


#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"DetialCell";

    DetailPageCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
#warning 可能会出现重影 这里需要处理重影
    
    if (cell == nil)
    {
        cell = [[DetailPageCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        
    }
    // 添加自定义的cell视图
    
    cell.titleLabel_Dinner.text = @"我想在这操作我的cell单元";
    
    return cell;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
