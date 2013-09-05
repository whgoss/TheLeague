//
//  ChallengesViewController.m
//  TheLeague
//
//  Created by Will Goss on 9/4/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import "APIClient.h"
#import "AppDelegate.h"
#import "Callback.h"
#import "ChallengesViewController.h"
#import "Constants.h"
#import "User.h"
#import "UserManager.h"

@interface ChallengesViewController ()

@end

@implementation ChallengesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // show loading indicator
    _loadingIndicator.labelText = @"Loading...";
    [_loadingIndicator show:TRUE];
    
    // get app delegate
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    // get logged in user standing
    NSString *endpoint = [NSString stringWithFormat:@"%@", ENDPOINT_USER_CHALLENGES];
    NSArray *keys = [[NSArray alloc] initWithObjects:@"apiKey", USER_ID, nil];
    NSArray *objects = [[NSArray alloc] initWithObjects:API_KEY, appDelegate.userManager.user.userId, nil];
    NSDictionary *params = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    [APIClient get:endpoint withQueryParams:params success:[self challengesSuccess] failure:[self challengesFailure]];
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

#pragma mark - Remote callbacks

- (SuccessCallback) challengesSuccess
{
    SuccessCallback block = ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        // hide loading indicator
        [_loadingIndicator hide:TRUE];
    };
    
    return block;
}

- (FailureCallback) challengesFailure
{
    FailureCallback block = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
    {
        // hide loading indicator
        [_loadingIndicator hide:TRUE];
    };
    
    return block;
}

@end
