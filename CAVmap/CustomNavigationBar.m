//
//  CustomNavigationBar.m
//  CAVmap
//
//  Created by 3024 on 14-10-18.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "CustomNavigationBar.h"

@implementation CustomNavigationBar


@synthesize customNavigationBarView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


+ (BaseView *)initNavigationBarWith:(CGRect )frame
{
    BaseView *resultView = [[BaseView alloc] initWithFrame:frame];
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
    label.text = @"text";
    
    [resultView addSubview:label];
    
    return resultView;
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
