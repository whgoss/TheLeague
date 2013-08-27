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
NSString extern *const LOGIN_USER;
NSString extern *const NOTIFICATION_USER_LOGGED_IN;

// Segue constants
NSString extern *const LOGIN_TO_MAIN;

// GET paramter constants
NSString extern *const NAME;
NSString extern *const FACEBOOK_ID;
NSString extern *const AUTH_HASH;

@end