//
//  Constants.h
//  TheLeague
//
//  Created by Will Goss on 8/27/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

NSString extern *const API_KEY;
NSString extern *const BASE_URL;
NSString extern *const NOTIFICATION_USER_LOGGED_IN;

#pragma mark - Endpoint constants

NSString extern *const ENDPOINT_USER_LOGIN;
NSString extern *const ENDPOINT_STANDINGS;
NSString extern *const ENDPOINT_USER_STATS;
NSString extern *const ENDPOINT_USER_STANDING;
NSString extern *const ENDPOINT_USER_CHALLENGES;
NSString extern *const ENDPOINT_USER_SEND_CHALLENGE;

// Misc constants
NSString extern *const USER;
NSString extern *const USER_ID;
NSString extern *const ID;
NSString extern *const MOVE_UP;
NSString extern *const MOVE_DOWN;
NSString extern *const MOVE_NONE;
NSString extern *const MOVEMENT;
NSString extern *const POSITION;
NSString extern *const WINS;
NSString extern *const LOSSES;
NSString extern *const ACCESS_TOKEN;
NSString extern *const WIN_PERCENTAGE;
NSString extern *const RECIPIENT_ID;
NSString extern *const SENDER_ID;
NSString extern *const MATCH_ID;
NSString extern *const ACCEPTED;
NSString extern *const DATE;
NSString extern *const RECIPIENT;
NSString extern *const SENDER;
NSString extern *const API_ERROR;

// Segue constants
NSString extern *const LOGIN_TO_MAIN;
NSString extern *const MAIN_TO_PROFILE;
NSString extern *const MAIN_TO_CHALLENGES;
NSString extern *const MAIN_TO_STATISTICS;

// GET paramter constants
NSString extern *const NAME;
NSString extern *const FACEBOOK_ID;
NSString extern *const AUTH_HASH;

@end