//
//  User.h
//  TheLeague
//
//  Created by Will Goss on 8/27/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *facebookId;
@property (strong, nonatomic) NSString *name;

- (id)initFromDictionary: (NSDictionary*)dict;

@end