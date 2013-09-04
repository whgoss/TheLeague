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
#import "Constants.h"
#import "Standing.h"
#import "StandingCell.h"
#import "User.h"

@interface StandingCell ()

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *positionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *avatarView;
@property (strong, nonatomic) IBOutlet UIImageView *upDownView;
@property (strong, nonatomic) Standing *standing;

@end

@implementation StandingCell

- (void)configureFromStanding: (Standing*)standing
{
    // get the app delegate so that we can access the session property
//    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    [_positionLabel setHidden:TRUE];
    
    // nil standing
    if (standing == nil)
    {
        _nameLabel.text = @"Empty slot";
        [_avatarView setImage:[UIImage imageNamed:@"default-avatar@2x.png"]];
        [_positionLabel setHidden:TRUE];
        [_upDownView setHidden:TRUE];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        // set standing object reference
        _standing = standing;
        
        // get facebook avatar
        NSString *facebookId = standing.user.facebookId;
    //    NSString *avatarString = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=normal&access_token=%@", facebookId, appDelegate.session.accessTokenData.accessToken];
        NSString *avatarString = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=normal", facebookId];
        NSURL *avatarURL = [[NSURL alloc] initWithString:avatarString];
        [_avatarView setImageWithURL:avatarURL placeholderImage:[UIImage imageNamed:@"default-avatar.png"]];
        _avatarView.clipsToBounds = YES;
        
        // set name text
        _nameLabel.text = _standing.user.name;
        
        // set position text
        _positionLabel.text = [NSString stringWithFormat:@"%d", _standing.position];
        
        // set image for a user's movement in the standings
        if (![_standing.movement isEqual:[NSNull null]])
        {
            if ([_standing.movement isEqualToString:MOVE_UP])
            {
                [_upDownView setImage:[UIImage imageNamed:@"green_arrow_up.png"]];
                [_upDownView setHidden:FALSE];
            }
            else if ([_standing.movement isEqualToString:MOVE_DOWN])
            {
                [_upDownView setImage:[UIImage imageNamed:@"red_arrow_down.png"]];
                [_upDownView setHidden:FALSE];
            }
            else
            {
                [_upDownView setHidden:TRUE];
            }
        }
        else
        {
            [_upDownView setHidden:TRUE];
        }
        
        // ensure position label is on top
        [self bringSubviewToFront:_positionLabel];
        [self sendSubviewToBack:_avatarView];
    }
}

@end