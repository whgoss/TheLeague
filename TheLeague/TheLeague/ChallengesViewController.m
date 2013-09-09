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
#import "Challenge.h"
#import "ChallengeCell.h"
#import "ChallengesViewController.h"
#import "Constants.h"
#import "User.h"
#import "UserManager.h"

@interface ChallengesViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *challengeArray;

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_challengeArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChallengeCell *challengeCell = [_tableView dequeueReusableCellWithIdentifier:@"ChallengeCell"];
    
    Challenge *challenge = [_challengeArray objectAtIndex:[indexPath row]];
    [challengeCell configureFromChallenge:challenge];
    
    return challengeCell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // do something
}

#pragma mark - Remote callbacks

- (SuccessCallback) challengesSuccess
{
    SuccessCallback block = ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        // empty data set
        _challengeArray = [[NSMutableArray alloc] init];
        
        // create challenge objects from results
        NSDictionary *results = JSON;
        for (NSDictionary * c in results)
        {
            Challenge *challenge = [[Challenge alloc] initFromDictionary:c];
            [_challengeArray addObject:challenge];
        }
        
        // hide loading indicator
        [_loadingIndicator hide:TRUE];
        
        // reload the table
        [_tableView reloadData];
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
