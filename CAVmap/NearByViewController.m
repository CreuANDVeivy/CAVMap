//
//  NearByViewController.m
//  CAVmap
//
//  Created by 3024 on 14-10-19.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "NearByViewController.h"
#import "hotWordSearchModelData.h"

@interface NearByViewController ()

@end



NSArray *quickImageName;
NSArray *quickTitleName;

@implementation NearByViewController

#define Margin 10
@synthesize hotWordSearchTableView,hotWordSearchDataSourceArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    hotWordSearchDataSourceArray = [[NSMutableArray alloc] init];  // 数组初始化
    [self initHotWordSearchTableView];  // 初始化tableView
    [self initData];
    // 测试数据
//    [[hotWordSearchModelData new] loadData];
}


#pragma mark - InitAction

- (void)initData
{
    quickImageName = @[@"dinner.png",@"hotel.png",@"zhoumoqunaer.png",@"scenic.png",@"group.png",@"taxi.png",@"cinema.png",@"bus.png"];
    quickTitleName = @[@"找美食",@"订酒店",@"周末去哪儿",@"搜景点",@"查团购",@"出租车",@"看电影",@"公交站"];
}
- (void)initHotWordSearchTableView
{
    hotWordSearchTableView = [[BaseTableView alloc] initWithFrame:kTableViewFrame];  // 初始化视图
    
    hotWordSearchTableView.delegate = self;  // 设置代理
    hotWordSearchTableView.dataSource = self;
    
    [self.view addSubview:hotWordSearchTableView];  // 加载到视图
}

#pragma mark - ButtonClicklAction

- (void)selectClicklAction:(BaseButton *)sender
{
    NSLog(@"%d",sender.tag);
}

#pragma mark - TableView Delegate

// 返回区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;  // 返回固定的区数
}
// 返回区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
// 返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 180;
    }
    else
    {
        return 120;
    }
}

// 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] init];

        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);  // 去掉分割线的偏移效果
        cell.selectionStyle = UITableViewCellSelectionStyleNone;  // 去掉选中背景
        // 自定义cell
        for (int j = 0; j < 2; j ++)
        {
            for (int i = 0; i < 4; i ++)
            {
                // 添加按钮
                BaseButton *btn = [[BaseButton alloc] initWithFrame:kFrame(80*i+15, j * 80 + Margin, 50, 50)];
                [btn setImage:[UIImage imageNamed:quickImageName[j*4 + i]] forState:0];  // 设置图片
                btn.tag = 1000 + j * 4 + i;
                [btn addTarget:self action:@selector(selectClicklAction:) forControlEvents:UIControlEventTouchUpInside];
                
                // 设置标题
                BaseLabel *label = [[BaseLabel alloc] initWithFrame:kFrame(80 * i, j * 80 + Margin + 58, 80, 15)];
                label.textAlignment = NSTextAlignmentCenter;  // 居中显示
                label.text = quickTitleName[j*4 + i];  // 设置标题
                label.font = [UIFont systemFontOfSize:14];
                //
                [cell.contentView addSubview:btn];
                [cell.contentView addSubview:label];
            }
        }
        return cell;
        
    }
    else
    {
        static NSString *identifer = @"navgation";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
        // 自定义cell
//        UIView *view = []
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:kFrame(<#x#>, <#y#>, <#w#>, <#h#>)]
        
        
        
    }
    return [UITableViewCell new];
}



#pragma mark - Memory Manage
//- (void)inithotWordSearchView
//{
//    
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
