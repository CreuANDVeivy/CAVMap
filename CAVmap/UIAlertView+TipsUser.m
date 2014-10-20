//
//  UIAlertView+TipsUser.m
//  CAVmap
//
//  Created by Ibokan on 14-10-20.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "UIAlertView+TipsUser.h"

@implementation UIAlertView (TipsUser)

+ (void)showAlertViewWithMessage:(NSString*)message buttonTitles:(NSString *)buttonTitles, ...NS_REQUIRES_NIL_TERMINATION
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:buttonTitles, nil];
    [alert show];
}

@end
