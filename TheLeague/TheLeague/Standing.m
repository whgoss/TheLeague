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
    NSString *pos = dict[@"position"];
    _position = [pos intValue];
    _user = [[User alloc] initFromDictionary:dict[USER]];
    return self;
}

@end