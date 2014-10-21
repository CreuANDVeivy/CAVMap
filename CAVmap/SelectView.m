//
//  SelectView.m
//  CAVmap
//
//  Created by 3024 on 14-10-21.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "SelectView.h"

@implementation SelectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}

- (SelectView *)mySelectViewWithTitleArray:(NSArray *)titleName
{
    SelectView *selectView = [[SelectView alloc] initWithFrame:kFrame(0, 0, kScreenWidth, 30)];
    
    for (int i = 0; i < titleName.count; i ++)
    {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btn addTarget:self action:@selector(changeSelectAction:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.frame = kFrame(kScreenWidth/titleName.count*i, 0, kScreenWidth/titleName.count, 30);
        [selectView addSubview:btn];

        UILabel *title = [[UILabel alloc] initWithFrame:kFrame(32.5, 5, 50, 20)];
        title.font = [UIFont systemFontOfSize:12];
        title.text = titleName[i];
        [btn addSubview:title];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sort_arrow_down_normal.png"] highlightedImage:[UIImage imageNamed:@"sort_arrow_down_normal.png"]];
        imageView.frame = kFrame(60, 13, 6, 4);
        
        [btn addSubview:imageView];
        
    }
    return selectView;
}

// 
- (void)changeSelectAction:(id)sender
{
    NSLog(@"-------");
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
