//
//  StandingCell.m
//  TheLeague
//
//  Created by Will Goss on 8/27/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"
#import "Callback.h"
#import "Standing.h"
#import "StandingCell.h"
#import "User.h"

@implementation StandingCell

- (void)configureFromStanding: (Standing*)standing
{
    // set standing object reference
    _standing = standing;
    
    // get facebook avatar
    NSString *facebookId = standing.user.facebookId;
    NSString *avatarString = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=normal", facebookId];
    NSURL *avatarURL = [[NSURL alloc] initWithString:avatarString];
    [_avatarView setImageWithURL:avatarURL placeholderImage:[UIImage imageNamed:@"default-avatar.png"]];
    _avatarView.clipsToBounds = YES;
    
    // set name text
    _nameLabel.text = _standing.user.name;
    
    // set position text
    _positionLabel.text = [NSString stringWithFormat:@"%d", _standing.position];
}

@end