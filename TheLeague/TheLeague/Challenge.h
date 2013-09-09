//
//  Challenge.h
//  TheLeague
//
//  Created by Will Goss on 9/6/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

@class User;
#import "BaseModel.h"
#import <Foundation/Foundation.h>

@interface Challenge : BaseModel

@property (strong, nonatomic) NSString *challengeId;
@property (strong, nonatomic) NSString *senderId;
@property (strong, nonatomic) NSString *recipientId;
@property (strong, nonatomic) NSString *matchId;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) User *sender;
@property (strong, nonatomic) User *recipient;

@end
