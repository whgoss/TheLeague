//
//  Standing.h
//  TheLeague
//
//  Created by Will Goss on 8/27/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

@class User;
#import "BaseModel.h"
#import <Foundation/Foundation.h>

@interface Standing : BaseModel

@property (strong, nonatomic) NSString *movement;
@property (strong, nonatomic) NSString *standingId;
@property (strong, nonatomic) User *user;
@property (nonatomic) int position;

+ (int)playerRankToBracketNumber: (int)rank;

@end