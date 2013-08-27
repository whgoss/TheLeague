//
//  UserManager.h
//  TheLeague
//
//  Created by Will Goss on 8/26/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

@class AppDelegate;
#import <Foundation/Foundation.h>

@interface UserManager : NSObject

@property (strong, nonatomic) NSString *authHash;
@property (strong, nonatomic) NSString *fbAccessToken;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *fbUID;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *displayName;

- (void)logIn;
- (void)logOut;

@end
