//
//  User.m
//  TheLeague
//
//  Created by Will Goss on 8/27/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import "Constants.h"
#import "User.h"

@implementation User

- (id)initFromDictionary: (NSDictionary*)dict
{
    self = [super init];
    _facebookId = dict[FACEBOOK_ID];
    _name = dict[NAME];
    _userId = dict[ID];
    return self;
}

@end
