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
NSString *const NOTIFICATION_USER_LOGGED_IN = @"NOTIFICATION_USER_LOGGED_IN";

#pragma mark - Endpoint constants

NSString *const ENDPOINT_USER_LOGIN = @"/loginUser.php";
NSString *const ENDPOINT_STANDINGS = @"/getStandings.php";
NSString *const ENDPOINT_USER_STATS = @"/getUserStatistics.php";
NSString *const ENDPOINT_USER_STANDING = @"/getStanding.php";
NSString *const ENDPOINT_USER_CHALLENGES = @"/getChallenges.php";

#pragma mark - General constants

NSString *const USER = @"user";
NSString *const USER_ID = @"userId";
NSString *const ID = @"id";
NSString *const MOVE_UP = @"moveUp";
NSString *const MOVE_DOWN = @"moveDown";
NSString *const MOVE_NONE = @"moveNone";
NSString *const MOVEMENT = @"movement";
NSString *const POSITION = @"position";
NSString *const WINS = @"wins";
NSString *const LOSSES = @"losses";
NSString *const ACCESS_TOKEN = @"accessToken";
NSString *const WIN_PERCENTAGE = @"winPercentage";

// Segue constants
NSString *const LOGIN_TO_MAIN = @"LoginToMainSegue";
NSString *const MAIN_TO_PROFILE = @"MainToProfileSegue";
NSString *const MAIN_TO_CHALLENGES = @"MainToChallengesSegue";
NSString *const MAIN_TO_STATISTICS = @"MainToStatisticsSegue";

// GET parameter constants
NSString *const NAME = @"name";
NSString *const FACEBOOK_ID = @"fbId";
NSString *const AUTH_HASH = @"authHash";

@end