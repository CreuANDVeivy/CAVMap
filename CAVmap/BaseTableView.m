//
//  BaseTableView.m
//  SeeDoctorGuide
//
//  Created by 3024 on 14-9-26.
//  Copyright (c) 2014年 ibokan. All rights reserved.
//

#import "BaseTableView.h"
#import "MainViewController.h"

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
//        self.delegate = self;
    }
    return self;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    NSLog(@"+++++++++++++++++++++++");
//    [MainViewController new].tabBarView.hidden = YES;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    [MainViewController new].tabBarView.hidden = NO;
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
