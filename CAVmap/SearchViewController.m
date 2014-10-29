//
//  SearchViewController.m
//  CAVmap
//
//  Created by Ibokan on 14-10-28.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

@synthesize textfield;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initTextField];
}


#pragma mark - 初始化textfieldd

// nav搜索栏
- (void)initTextField
{
    textfield = [[BaseTextField alloc] initWithFrame:kFrame(50, 25, kScreenWidth-100, 30)];
    textfield.placeholder = @"搜地点、查公交、找路线";
    textfield.font = [UIFont systemFontOfSize:14];
    [textfield becomeFirstResponder];
    textfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    textfield.leftViewMode = UITextFieldViewModeAlways;
    textfield.delegate = self;
    textfield.returnKeyType = UIReturnKeySearch;
    UIView *sV = [[UIView alloc]initWithFrame:kFrame(10, 0, 30, 30)];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:kFrame(10,5, 18, 18)];
    imageV.image = [UIImage imageNamed:@"common_icon_searchbox_magnifier_2"];
    [sV addSubview:imageV];
    textfield.leftView = sV;
    textfield.backgroundColor = [UIColor colorWithWhite:1 alpha:0.98];
    textfield.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textfield];
    [textfield addKeyboardBtn];
    
    UIButton *searchBtn = [UIButton blueSystemButtonWithButtonType:UIButtonTypeRoundedRect title:@"搜索" frame:kFrame(kScreenWidth-45, 27.5, 40, 25)];
    [self.view addSubview:searchBtn];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [textfield.keyBoardBtn setImage:[UIImage imageNamed:@"keyboard_btn_hide7@2x"] forState:UIControlStateNormal];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
