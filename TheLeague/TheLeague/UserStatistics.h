//
//  UserStatistics.h
//  TheLeague
//
//  Created by Will Goss on 8/28/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import "BaseModel.h"
#import <Foundation/Foundation.h>

@interface UserStatistics : BaseModel

@property (nonatomic) int rank;
@property (nonatomic) int wins;
@property (nonatomic) int losses;
@property (nonatomic) int winPercentage;
@property (strong, nonatomic) NSString *userId;

@end