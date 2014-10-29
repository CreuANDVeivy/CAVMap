//
//  SearchViewController.h
//  CAVmap
//
//  Created by Ibokan on 14-10-28.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchViewController : BaseViewController<UITextFieldDelegate>

@property (strong, nonatomic) BaseTextField *textfield;

@end
