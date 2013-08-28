//
//  UserStatistics.h
//  TheLeague
//
//  Created by Will Goss on 8/28/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserStatistics : NSObject

@property (nonatomic) int wins;
@property (nonatomic) int losses;
@property (nonatomic) int winPercentage;
@property (strong, nonatomic) NSString *userId;

- (id)initFromDictionary: (NSDictionary*)dict;

@end
