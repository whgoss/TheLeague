//
//  ChallengeCell.h
//  TheLeague
//
//  Created by Will Goss on 9/6/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

@class Challenge;
@class Match;
@class User;
#import <UIKit/UIKit.h>

@interface ChallengeCell : UITableViewCell

- (void)configureFromChallenge: (Challenge*)challenge;

@end