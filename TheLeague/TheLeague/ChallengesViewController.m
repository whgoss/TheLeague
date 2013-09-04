//
//  ChallengesViewController.m
//  TheLeague
//
//  Created by Will Goss on 9/4/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import "ChallengesViewController.h"

@interface ChallengesViewController ()

@end

@implementation ChallengesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // hide the back button and persist title
    self.parentViewController.navigationItem.hidesBackButton = TRUE;
    self.parentViewController.navigationItem.title = self.navigationItem.title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
