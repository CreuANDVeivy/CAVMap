//
//  NearByViewController.m
//  CAVmap
//
//  Created by 3024 on 14-10-19.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "NearByViewController.h"
#import "hotWordSearchModelData.h"
#import "HotWordSearchDetailViewController.h"

@interface NearByViewController ()

@end



NSArray *quickImageName;
NSArray *quickTitleName;
NSArray *backImageArray;  // 背景图片数组
NSArray *goIamgeArray;  // 箭头图片数组
NSArray *tintColorArray;

@implementation NearByViewController

#define Margin 10
@synthesize hotWordSearchTableView,hotWordSearchDataSourceArray,hotWordTitleArray;

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
    [self initData];  // 初始化cell中的数据
    self.tabBarController.tabBar.hidden = YES;
    
    // 测试数据
    //    [[hotWordSearchModelData new] loadData];
}


#pragma mark - InitAction

- (void)initData
{
    // section1 的图片和标题
    quickImageName = @[@"dinner.png",@"hotel.png",@"zhoumoqunaer.png",@"scenic.png",@"group.png",@"taxi.png",@"cinema.png",@"bus.png"];
    quickTitleName = @[@"找美食",@"订酒店",@"周末去哪儿",@"搜景点",@"查团购",@"出租车",@"看电影",@"公交站"];
    // 背景图片数组
    backImageArray = @[[UIImage imageNamed:@"main_map_drawer_icon_poi_scene_meishi.png"],
                       [UIImage imageNamed:@"main_map_drawer_icon_poi_scene_jiudian.png"],
                       [UIImage imageNamed:@"main_map_drawer_icon_poi_scene_xiuxianyule.png"],
                       [UIImage imageNamed:@"main_map_drawer_icon_poi_scene_jiaotongsheshi.png"],
                       [UIImage imageNamed:@"main_map_drawer_icon_poi_scene_shenghuofuwu.png"],
                       [UIImage imageNamed:@"main_map_drawer_icon_poi_tour_recommand.png"]];
    // 箭头图片数组
    goIamgeArray = @[[UIImage imageNamed:@"scene_arrow_orange.png"],
                     [UIImage imageNamed:@"scene_arrow_green.png"],
                     [UIImage imageNamed:@"scene_arrow_pink.png"],
                     [UIImage imageNamed:@"scene_arrow_blue.png"]];
    // 标题的字体颜色
    tintColorArray = @[[UIColor colorWithRed:247/255.0 green:183/255.0 blue:134/255.0 alpha:1],[UIColor colorWithRed:192/255.0 green:233/255.0 blue:165/255.0 alpha:1],[UIColor colorWithRed:245/255.0 green:159/255.0 blue:160/255.0 alpha:1],[UIColor colorWithRed:160/255.0 green:202/255.0 blue:250/255.0 alpha:1]];
    hotWordTitleArray = [[NSMutableArray alloc] init];
    NSArray *arr1 = @[@"美食",@"中餐",@"小吃快餐",@"川菜",@"西餐",@"火锅",@"肯德基"];
    NSArray *arr2 = @[@"酒店",@"快捷酒店",@"星级酒店",@"青年旅社",@"旅馆",@"招待所",@"特价酒店"];
    NSArray *arr3 = @[@"休闲娱乐",@"电影院",@"KTV",@"酒吧",@"咖啡厅",@"网吧",@"商场"];
    NSArray *arr4 = @[@"交通设施",@"公交站",@"加油站",@"火车票代售点",@"长途汽车站",@"停车场",@"火车站"];
    NSArray *arr5 = @[@"生活服务",@"超市",@"药店",@"ATM",@"银行",@"医院",@"厕所"];
    NSArray *arr6 = @[@"特色推荐",@"著名景点",@"特色美食",@"宾馆",@"购物",@"地铁线路",@"机场车站"];
    // 添加到数组中
    [hotWordTitleArray addObject:arr1];
    [hotWordTitleArray addObject:arr2];
    [hotWordTitleArray addObject:arr3];
    [hotWordTitleArray addObject:arr4];
    [hotWordTitleArray addObject:arr5];
    [hotWordTitleArray addObject:arr6];
    
}
- (void)initHotWordSearchTableView
{
    hotWordSearchTableView = [[BaseTableView alloc] initWithFrame:kTableViewFrame];  // 初始化视图
    
    hotWordSearchTableView.delegate = self;  // 设置代理
    hotWordSearchTableView.dataSource = self;
    
    [self.view addSubview:hotWordSearchTableView];  // 加载到视图
}


#pragma mark -Custom Cell View
- (UIView *)customCellView:(NSIndexPath *)indexPath
{
    // 自定义cell
    UIView *view = [[UIView alloc] initWithFrame:kFrame(Margin, 10, kScreenWidth - 2*Margin, 120)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    // 总的按钮
    UIButton *totalButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    totalButton.frame = kFrame(0, 0, 100, 120);
    [totalButton addTarget:self action:@selector(cellButtonClicksAction:) forControlEvents:UIControlEventTouchUpInside];
    totalButton.tag = 1000 + indexPath.row * 10;
    [view addSubview:totalButton];
    // 背景图
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:kFrame(0, 40, 100, 80)];
    imageView.image = backImageArray[indexPath.row];
    [view addSubview:imageView];
    // 大标题
    UILabel *bigTitle = [[UILabel alloc] init];
    bigTitle.text = [hotWordTitleArray[indexPath.row] objectAtIndex:0];  // 设置标题
    bigTitle.textAlignment = NSTextAlignmentLeft;
    bigTitle.font = [UIFont systemFontOfSize:16];
    
    [totalButton addSubview:bigTitle];
    if (indexPath.row < 2)
    {
        bigTitle.frame = kFrame(5, 0, 50, 40);
        
    }
    else
    {
        bigTitle.frame = kFrame(5, -20, 40, 80);
        bigTitle.numberOfLines = 2;
    }
    
    bigTitle.textColor = [tintColorArray objectAtIndex:indexPath.row % 4];
    
    
    // 箭头
    UIImageView *goImageVeiw = [[UIImageView alloc] initWithImage:[goIamgeArray objectAtIndex:indexPath.row % 4] highlightedImage:[goIamgeArray objectAtIndex:indexPath.row % 4]];
    goImageVeiw.frame = kFrame(40, 12, 15, 15);
    [totalButton addSubview:goImageVeiw];
    for (int i = 0; i < 3; i ++)
    {
        for (int j = 0; j < 2; j ++)
        {
            UIButton *btn = [[UIButton alloc] initWithFrame:kFrame(100 + j * 100, 40 * i, 100, 40)];
            [btn addTarget:self action:@selector(cellButtonClicksAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = 1001 + i * 2 + j + indexPath.row * 10;
            btn.titleLabel.textColor = [UIColor redColor];
            btn.layer.borderWidth = 0.5;
            btn.layer.borderColor = [UIColor colorWithWhite:0.1 alpha:0.1].CGColor;
            UILabel *label = [[UILabel alloc] initWithFrame:kFrame(0, 0, 100, 40)];
            label.textColor = [UIColor blackColor];
            label.text = [hotWordTitleArray[indexPath.row] objectAtIndex:i * 2 + j + 1];
            if ([label.text isEqualToString:@"火锅"] ||[label.text isEqualToString:@"肯德基"] ||[label.text isEqualToString:@"特价酒店"] ||[label.text isEqualToString:@"电影院"] ||[label.text isEqualToString:@"KTV"] ||[label.text isEqualToString:@"公交站"] ||[label.text isEqualToString:@"ATM"] ||[label.text isEqualToString:@"著名景点"])
            {
                label.textColor = [UIColor colorWithRed:1.0 green:0.1 blue:0.1 alpha:1];
            }
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:12];
            [btn addSubview:label];
            
            [view addSubview:btn];
        }
    }
    
    return view;
}

#pragma mark - ButtonClicklAction

- (void)selectClicklAction:(BaseButton *)sender
{
    //    NSLog(@"%ld",(long)sender.tag);
}

- (void)cellButtonClicksAction:(UIButton *)sender
{
    int section,_index;
    
    section = (sender.tag-1000)/10;
    _index = (sender.tag-1000)%10;
    
    HotWordSearchDetailViewController *detail = [[HotWordSearchDetailViewController alloc] init];
    
    [self.navigationController pushViewController:detail animated:YES];
    NSLog(@"%@",[hotWordTitleArray[section] objectAtIndex:_index]);
}

#pragma mark - TableView Delegate
// 区头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
// 区尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
// 返回区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;  // 返回固定的区数
}
// 返回区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    return 6;
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
        return 130;
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
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.2];
        
        [cell.contentView addSubview:[self customCellView:indexPath]];  // 自定义cell
        hotWordSearchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        return cell;
    }
    return [UITableViewCell new];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
