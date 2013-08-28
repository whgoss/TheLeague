//
//  UserProfileController.m
//  TheLeague
//
//  Created by Will Goss on 8/28/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import "AFNetworking.h"
#import "APIClient.h"
#import "AppDelegate.h"
#import "Callback.h"
#import "Constants.h"
#import "Standing.h"
#import "User.h"
#import "UserProfileViewController.h"
#import "UserStatistics.h"

@interface UserProfileViewController ()

@property (strong, nonatomic) Standing *standing;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) UserStatistics *stats;
@property (strong, nonatomic) Standing *currentUserStanding;

@end

@implementation UserProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // show loading indicator
    _loadingIndicator.labelText = @"Loading...";
    [_loadingIndicator show:TRUE];
    
    // set user title
    _nameLabel.text = _user.name;
    
    // get facebook avatar
    NSString *facebookId = _user.facebookId;
    NSString *avatarString = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=normal", facebookId];
    NSURL *avatarURL = [[NSURL alloc] initWithString:avatarString];
    [_avatarView setImageWithURL:avatarURL placeholderImage:[UIImage imageNamed:@"default-avatar.png"]];
    _avatarView.clipsToBounds = YES;
    
    // hide the challenge button by default for aesthetic purposes
    [_challengeButton setEnabled:FALSE];
    
    // get user stats
    NSString *endpoint = [NSString stringWithFormat:@"%@", ENDPOINT_USER_STATS];
    NSArray *keys = [[NSArray alloc] initWithObjects:USER_ID, @"apiKey", nil];
    NSArray *objects = [[NSArray alloc] initWithObjects:_user.userId, API_KEY, nil];
    NSDictionary *params = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    [APIClient get:endpoint withQueryParams:params success:[self userStatsSuccess] failure:[self userStatsFailure]];
}

- (void)setUser: (User*)user withStanding: (Standing*)standing
{
    _user = user;
    _standing = standing;
}

#pragma mark - Remote callbacks

- (SuccessCallback) userStatsSuccess
{
    SuccessCallback block = ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        NSDictionary *statDict = JSON;
        
        // get statistics
        _stats = [[UserStatistics alloc] initFromDictionary:statDict];
        
        // set labels
        _rankLabel.text = [NSString stringWithFormat:@"Rank: %d", _standing.position];
        _recordLabel.text = [NSString stringWithFormat:@"Record: (%d-%d)", _stats.wins, _stats.losses];
        _winPercentageLabel.text = [NSString stringWithFormat:@"Win Percent: %d%%", _stats.winPercentage];
        
        // get app delegate
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        
        // get logged in user standing
        NSString *endpoint = [NSString stringWithFormat:@"%@", ENDPOINT_USER_STANDING];
        NSArray *keys = [[NSArray alloc] initWithObjects:@"apiKey", USER_ID, nil];
        NSArray *objects = [[NSArray alloc] initWithObjects:API_KEY, appDelegate.userManager.user.userId, nil];
        NSDictionary *params = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
        [APIClient get:endpoint withQueryParams:params success:[self currentUserStandingSuccess] failure:[self currentUserStandingFailure]];
    };
    
    return block;
}

- (FailureCallback) userStatsFailure
{
    FailureCallback block = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
    {
        // hide loading indicator
        [_loadingIndicator hide:TRUE];
    };
    
    return block;
}

- (SuccessCallback) currentUserStandingSuccess
{
    SuccessCallback block = ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        NSDictionary *result = JSON;
        _currentUserStanding = [[Standing alloc] initFromDictionary:result];
        int currentUserBracket = [Standing playerRankToBracketNumber:_currentUserStanding.position];
        int profileUserBracket = [Standing playerRankToBracketNumber:_standing.position];
        
        // if the player's current bracket is not one less the bracket of the player whose profile is currently being viewed, disable the challenge button
        if (profileUserBracket == (currentUserBracket - 1))
        {
            [_challengeButton setEnabled:TRUE];
        }
        
        // hide loading indicator
        [_loadingIndicator hide:TRUE];
    };
    
    return block;
}

- (FailureCallback) currentUserStandingFailure
{
    FailureCallback block = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
    {
        // hide loading indicator
        [_loadingIndicator hide:TRUE];
    };
    
    return block;
}

@end