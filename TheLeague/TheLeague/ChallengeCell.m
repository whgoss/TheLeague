//
//  ChallengeCell.m
//  TheLeague
//
//  Created by Will Goss on 9/6/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import "AppDelegate.h"
#import "Challenge.h"
#import "ChallengeCell.h"
#import "User.h"

@interface ChallengeCell ()

@property (strong, nonatomic) IBOutlet UILabel *challengeLabel;
@property (strong, nonatomic) IBOutlet UILabel *winLossLabel;

@end

@implementation ChallengeCell

- (void)configureFromChallenge: (Challenge*)challenge
{
    // get app delegate
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    // has the match been played yet?
    if ([challenge.matchId isEqual:[NSNull null]])
    {
        [_winLossLabel setHidden:TRUE];
        
        // did the current user initiate the challenge?
        if ([challenge.senderId isEqualToString:appDelegate.userManager.user.userId])
        {
            _challengeLabel.text = [NSString stringWithFormat:@"You challenged %@.", challenge.recipient.name];
        }
        else
        {
            _challengeLabel.text = [NSString stringWithFormat:@"%@ challenged you.", challenge.recipient.name];
        }
    }
    else
    {
        // do something
    }
}

@end