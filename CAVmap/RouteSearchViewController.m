//
//  RouteSearchViewController.m
//  CAVmap
//
//  Created by Ibokan on 14-10-24.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "RouteSearchViewController.h"

@interface RouteSearchViewController ()

@end

@implementation RouteSearchViewController

@synthesize textfiel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    textfiel = [[UITextField alloc] initWithFrame:kFrame(50, 25, kScreenWidth-60, 30)];
    textfiel.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:textfiel];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
