//
//  Constants.m
//  TheLeague
//
//  Created by Will Goss on 8/27/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import "Constants.h"

@implementation Constants

NSString *const API_KEY = @"xmFBDbVviZpETY5oufGw";
NSString *const BASE_URL = @"http://willgoss.com/theleague";
NSString *const LOGIN_USER = @"/loginUser.php";
NSString *const NOTIFICATION_USER_LOGGED_IN = @"NOTIFICATION_USER_LOGGED_IN";
NSString *const ENDPOINT_STANDINGS = @"/getStandings.php";

NSString *const USER = @"user";
NSString *const ID = @"id";
NSString *const MOVE_UP = @"moveUp";
NSString *const MOVE_DOWN = @"moveDown";
NSString *const MOVE_NONE = @"moveNone";
NSString *const MOVEMENT = @"movement";
NSString *const POSITION = @"position";

// Segue constants
NSString *const LOGIN_TO_MAIN = @"LoginToMainSegue";

// GET parameter constants
NSString *const NAME = @"name";
NSString *const FACEBOOK_ID = @"fbId";
NSString *const AUTH_HASH = @"authHash";

@end