//
//  UIImage+Redraw.h
//  UI_ScrollView
//
//  Created by Jerry Li on 13-7-1.
//  Copyright (c) 2013年 Li Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Redraw)

+(UIImage*)redraw:(UIImage*)newImage Frame:(CGRect)frame;

@end

@interface  UIButton(addtion)
+(UIButton*)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame image:(UIImage *)image title:(NSString *)title target:(id)target action:(SEL)action;

+(UIButton*)buttonWithType:(UIButtonType)buttonType frame:(CGRect)frame image:(UIImage *)image title:(NSString *)title target:(id)target andAction:(SEL)action;

+ (UIButton *)packageButtonWithImage:(UIImage *)image Title:(NSString *)title Frame:(CGRect)frame;
@end
