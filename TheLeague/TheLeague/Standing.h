//
//  Standing.h
//  TheLeague
//
//  Created by Will Goss on 8/27/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

@class User;
#import <Foundation/Foundation.h>

@interface Standing : NSObject

@property (strong, nonatomic) NSString *standingId;
@property (strong, nonatomic) User *user;
@property (nonatomic) int position;

- (id)initFromDictionary: (NSDictionary*)dict;

@end