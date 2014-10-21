//
//  HotWordSearchDetailViewController.m
//  CAVmap
//
//  Created by 3024 on 14-10-21.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "HotWordSearchDetailViewController.h"

@interface HotWordSearchDetailViewController ()

@end

@implementation HotWordSearchDetailViewController

@synthesize selectView,searchDetialTableView;

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
    // 添加选择
    NSArray *title = @[@"范围",@"类别",@"排序"];
    UIView *select = [self mySelectViewWithTitleArray:title];
    select.center = CGPointMake(kScreenWidth/2, 74);
    [self.view addSubview:select];
    
}

#pragma mark - InitMethod

// 初始化搜索数据的详情的表示图
- (void)initSearchDetialTableView
{
    searchDetialTableView = [[UITableView alloc] initWithFrame:kFrame(0, 90, kScreenWidth, kScreenHeight - 90) style:UITableViewStyleGrouped];
    // 设置代理
    searchDetialTableView.delegate = self;
    searchDetialTableView.dataSource = self;
    
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
    
    NSLog(@"-------%d",sender.tag);
}


#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
