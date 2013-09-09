//
//  Challenge.m
//  TheLeague
//
//  Created by Will Goss on 9/6/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import "Challenge.h"
#import "Constants.h"
#import "User.h"

@implementation Challenge

- (id)initFromDictionary: (NSDictionary*)dict
{
    self = [super init];
    _challengeId = dict[ID];
    _senderId = dict[SENDER_ID];
    _recipientId = dict[RECIPIENT_ID];
    _matchId = dict[MATCH_ID];
    _sender = [[User alloc] initFromDictionary:dict[SENDER]];
    _recipient = [[User alloc] initFromDictionary:dict[RECIPIENT]];
//    _accepted = dict[ACCEPTED];
//    _date = dict[DATE];
    return self;
}

@end
