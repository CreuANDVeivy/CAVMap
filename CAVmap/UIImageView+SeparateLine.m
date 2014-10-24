//
//  UIImageView+SeparateLine.m
//  CAVmap
//
//  Created by Ibokan on 14-10-24.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "UIImageView+SeparateLine.h"

@implementation UIImageView (SeparateLine)


+ (id)addSeparateLineWithFrame:(CGRect)frame
{
    UIImageView *separaLine = [[UIImageView alloc]initWithFrame:frame];
    separaLine.image = [UIImage imageNamed:@"sendtocar_dotted_line"];
    
    return separaLine;
}
@end
