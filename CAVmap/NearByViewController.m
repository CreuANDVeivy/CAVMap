//
//  NearByViewController.m
//  CAVmap
//
//  Created by 3024 on 14-10-19.
//  Copyright (c) 2014年 CAV. All rights reserved.
//

#import "NearByViewController.h"

@interface NearByViewController ()

@end

@implementation NearByViewController

@synthesize hotWordSearchView;

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
    [self inithotWordSearchView];
}


- (void)inithotWordSearchView
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
