//
//  AppDelegate.h
//  TheLeague
//
//  Created by Will Goss on 8/26/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import "UserManager.h"
#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

// Session Login sample application
//
// The purpose of this sample application is to provide an example of
// how to log in with Facebook. The goal of the sample is to show how
// to use the FBSession class for this purpose, with minimal additional
// sample functionality to distract from the core topic.

@class LoginViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LoginViewController *viewController;
@property (strong, nonatomic) UserManager *userManager;

// FBSample logic
// In this sample the app delegate maintains a property for the current
// active session, and the view controllers reference the session via
// this property, as well as play a role in keeping the session object
// up to date; a more complicated application may choose to introduce
// a simple singleton that owns the active FBSession object as well
// as access to the object by the rest of the application
@property (strong, nonatomic) FBSession *session;

@end
