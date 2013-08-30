//
//  UserManager.m
//  TheLeague
//
//  Created by Will Goss on 8/26/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import "Constants.h"
#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import "UserManager.h"

@implementation UserManager

typedef void(^FBCompletionHandler)(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error);

# pragma mark - log in/out

- (void)logIn
{
    //Starts a connection to Facebook API so we can grab the details off the fb user and check for existing token
    [[FBRequest requestForMe] startWithCompletionHandler:[self fbCompletionSuccess]];
}

- (void)logOut
{
    //distribute notification of user logout
    //    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_LOGOUT object:self userInfo:nil];
    //
    //    //clear active user's tokens upon logout
    //    [CrowdFlikAPIClient clearUserTokens];
    
    //kill Facebook session on logout
    [FBSession.activeSession closeAndClearTokenInformation];
    [FBSession.activeSession close];
    [FBSession setActiveSession:nil];
}

- (FBCompletionHandler) fbCompletionSuccess
{
    FBCompletionHandler block = ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
        if (error)
        {
        }
        else
        {
            // get user information
            [self logIntoLeague:user];
            
            // send login notification so controllers can handle this
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_USER_LOGGED_IN object:nil userInfo:nil];
        }
    };
    
    return block;
}

-(void)logIntoLeague:(NSDictionary<FBGraphUser> *) user
{
    [self retrieveFbUserInfo:user];
    
    //    if ([CrowdFlikAPIClient checkUserTokens]) {
    //        //we have a local token - let's find user info
    //        [self findUserByFacebookId];
    //    } else {
    //        //no local token available. check db for user token
    //        [CrowdFlikAPIClient retrieveUserToken: _fbAccessToken : _fbUID success:[self retrieveTokenSuccess] failure:[self retrieveTokenFailure]];
    //    }
}

-(void)retrieveFbUserInfo:(NSDictionary<FBGraphUser> *) user
{
    _fbAccessToken = FBSession.activeSession.accessTokenData.accessToken;
    _fbUID = [user objectForKey:@"id"];
    _userName = [user objectForKey:@"username"];
    _displayName = [user objectForKey:@"name"];
}

@end