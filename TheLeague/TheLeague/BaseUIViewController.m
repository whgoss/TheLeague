//
//  BaseUIViewController.m
//  Hackathon Selection
//
//  Created by Will Goss on 8/16/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import "BaseUIViewController.h"
#import "MainViewController.h"

@implementation BaseUIViewController

- (void)viewDidLoad
{
    // add loading indicator
    _loadingIndicator = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:_loadingIndicator];
}

#pragma mark - Orientation functions

- (BOOL)shouldAutorotate
{
    return FALSE;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationPortrait;
}

// pre-iOS 6 support
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

@end