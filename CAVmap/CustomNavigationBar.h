//
//  CustomNavigationBar.h
//  CAVmap
//
//  Created by 3024 on 14-10-18.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "BaseView.h"

@interface CustomNavigationBar : BaseView


@property (retain, nonatomic) BaseView *customNavigationBarView;  // 自定义的navgationBar

+ (BaseView *)initNavigationBarWith:(CGRect )frame;


@end
