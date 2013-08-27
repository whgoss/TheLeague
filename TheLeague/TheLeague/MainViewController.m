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

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // hide the back button
    self.navigationItem.hidesBackButton = TRUE;
    
    // show loading indicator
    _loadingIndicator.labelText = @"Loading...";
    [_loadingIndicator show:TRUE];
    
    // instantiate standings array
    _standingsArray = [[NSMutableArray alloc] init];
    
    // get standings
    NSString *endpoint = [NSString stringWithFormat:@"%@", ENDPOINT_STANDINGS];
    [APIClient get:endpoint withQueryParams:nil success:[self standingsSuccess] failure:[self standingsFailure]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _standingsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StandingCell *standingCell = [tableView dequeueReusableCellWithIdentifier:@"StandingCell"];
    
    if (_standingsArray.count > 0)
    {
        Standing *standing = [_standingsArray objectAtIndex:indexPath.row];
        [standingCell configureFromStanding:standing];
    }
    
    return standingCell;
}

#pragma mark - Remote callbacks

- (SuccessCallback) standingsSuccess
{
    SuccessCallback block = ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        // hide loading indicator
        [_loadingIndicator hide:TRUE];
        
        // refresh standings array
        _standingsArray = [[NSMutableArray alloc] init];
        NSMutableArray *jsonStandingsArray = JSON;
        
        // loop through json array and populate custom event object off info
        for (NSDictionary * s in jsonStandingsArray)
        {
            //populate our flik object
            Standing *standing = [[Standing alloc] initFromDictionary:s];
            [_standingsArray addObject:standing];
        }
        
        // refresh the table
        [_tableView reloadData];
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