//
//  User.h
//  TheLeague
//
//  Created by Will Goss on 8/27/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import "BaseModel.h"
#import <Foundation/Foundation.h>

@interface User : BaseModel

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *facebookId;
@property (strong, nonatomic) NSString *name;

@end