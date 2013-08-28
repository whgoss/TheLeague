//
//  Standing.m
//  TheLeague
//
//  Created by Will Goss on 8/27/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import "Constants.h"
#import "Standing.h"
#import "User.h"

@implementation Standing

- (id)initFromDictionary: (NSDictionary*)dict
{
    self = [super init];
    _standingId = dict[ID];
    NSString *pos = dict[POSITION];
    _position = [pos intValue];
    _movement = dict[MOVEMENT];
    _user = [[User alloc] initFromDictionary:dict[USER]];
    return self;
}

+ (int)playerRankToBracketNumber: (int)rank
{
    int temp = 0;
    for (int i = 0; i <= rank; i++)
    {
        if (temp + i >= rank)
        {
            return i;
        }
        else
        {
            temp += i;
        }
    }
    
    return temp;
}

@end