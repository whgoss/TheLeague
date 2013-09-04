//
//  MainViewController.m
//  TheLeague
//
//  Created by Will Goss on 8/27/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import "APIClient.h"
#import "Callback.h"
#import "Constants.h"
#import "MainViewController.h"
#import "Standing.h"
#import "StandingCell.h"
#import "UserProfileViewController.h"

@interface MainViewController ()

@property (strong, nonatomic) Standing *selectedStanding;
@property (strong, nonatomic) User *selectedUser;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)prepareForSegue: (UIStoryboardSegue*)segue sender: (id)sender
{
    if ([[segue identifier] isEqualToString:MAIN_TO_PROFILE])
    {
        // get destination view
        UserProfileViewController *controller = [segue destinationViewController];
        
        // pass the selected user to destination view
        [controller setUser:_selectedUser withStanding:_selectedStanding];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // hide the back button and persist title
    self.parentViewController.navigationItem.hidesBackButton = TRUE;
    self.parentViewController.navigationItem.title = self.navigationItem.title;
    
    // show loading indicator
    _loadingIndicator.labelText = @"Loading...";
    [_loadingIndicator show:TRUE];
    
    // instantiate standings array
    _standingsArray = [[NSMutableArray alloc] init];
    
    // get standings
    NSString *endpoint = [NSString stringWithFormat:@"%@", ENDPOINT_STANDINGS];
    NSArray *keys = [[NSArray alloc] initWithObjects:@"apiKey", nil];
    NSArray *objects = [[NSArray alloc] initWithObjects:API_KEY, nil];
    NSDictionary *params = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    [APIClient get:endpoint withQueryParams:params success:[self standingsSuccess] failure:[self standingsFailure]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // TO-DO: needs to change
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    if (_standingsArray.count > 0)
    {
        int index = [self indexPathToArrayIndex:indexPath];
        if (index < [_standingsArray count])
        {
            StandingCell *standingCell = [tableView dequeueReusableCellWithIdentifier:@"StandingCell"];
            Standing *standing = [_standingsArray objectAtIndex:index];
            [standingCell configureFromStanding:standing];
            cell = standingCell;
        }
    }

    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Bracket %d", section + 1];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // get corresponding user
    int index = [self indexPathToArrayIndex:indexPath];
    _selectedStanding = [_standingsArray objectAtIndex:index];
    _selectedUser = _selectedStanding.user;
    
    // initiate segue
    [self performSegueWithIdentifier:MAIN_TO_PROFILE sender:self];
}

#pragma mark - Convenience methods

- (int)indexPathToArrayIndex: (NSIndexPath*)indexPath
{
    int startingIndex = 0;
    for (int i = 0; i < [indexPath section] + 1; i++)
    {
        startingIndex += i;
    }
    return startingIndex + [indexPath row];
}

#pragma mark - Remote callbacks

- (SuccessCallback) standingsSuccess
{
    SuccessCallback block = ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        // refresh standings array
        _standingsArray = [[NSMutableArray alloc] init];
        NSMutableArray *jsonStandingsArray = JSON;
        
        // loop through json array and populate custom event object off info
        for (NSDictionary * s in jsonStandingsArray)
        {
            Standing *standing = [[Standing alloc] initFromDictionary:s];
            [_standingsArray addObject:standing];
        }
        
        // refresh the table
        [_tableView reloadData];
        
        // hide loading indicator
        [_loadingIndicator hide:TRUE];
    };
    
    return block;
}

- (FailureCallback) standingsFailure
{
    FailureCallback block = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
    {
        // hide loading indicator
        [_loadingIndicator hide:TRUE];
    };
    
    return block;
}

@end