//
//  UserStatistics.m
//  TheLeague
//
//  Created by Will Goss on 8/28/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import "Constants.h"
#import "UserStatistics.h"

@implementation UserStatistics

- (id)initFromDictionary: (NSDictionary*)dict
{
    self = [super init];
    _userId = dict[USER_ID];
    NSString *wins = dict[WINS];
    NSString *losses = dict[LOSSES];
    NSString *winPercentage = dict[WIN_PERCENTAGE];
    _wins = [wins intValue];
    _losses = [losses intValue];
    _winPercentage = [winPercentage intValue];
    return self;
}

@end
