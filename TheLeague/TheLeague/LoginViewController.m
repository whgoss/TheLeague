//
//  ViewController.m
//  TheLeague
//
//  Created by Will Goss on 8/26/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import "APIClient.h"
#import "AppDelegate.h"
#import "Callback.h"
#import "Constants.h"
#import "LoginViewController.h"
#import "UserManager.h"
#import "NSString+NSString_Extended.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UIButton *buttonLoginLogout;
@property (strong, nonatomic) IBOutlet UITextView *textNoteOrLink;

- (IBAction)buttonClickHandler:(id)sender;
- (void)updateView;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // show loading indicator
    _loadingIndicator.labelText = @"Logging in...";
    [_loadingIndicator show:TRUE];
    
	// update view
    [self updateView];
    
    // listen for login notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginCallback) name:NOTIFICATION_USER_LOGGED_IN object:nil];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (!appDelegate.session.isOpen)
    {
        // create a fresh session object
        appDelegate.session = [[FBSession alloc] init];
        
        // if we don't have a cached token, a call to open here would cause UX for login to
        // occur; we don't want that to happen unless the user clicks the login button, and so
        // we check here to make sure we have a token before calling open
        if (appDelegate.session.state == FBSessionStateCreatedTokenLoaded)
        {
            
            // even though we had a cached token, we need to login to make the session usable
            [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState status,
                                                             NSError *error) {
                // we recurse here, in order to update buttons and labels
                [self updateView];
                
                // set active session (not sure if this is necessary atm)
                [FBSession setActiveSession:appDelegate.session];
                
                // log user in
                [appDelegate.userManager logIn];
            }];
        }
    }
}

// FBSample logic
// main helper method to update the UI to reflect the current state of the session.
- (void)updateView
{
    // get the app delegate, so that we can reference the session property
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (appDelegate.session.isOpen)
    {
        // valid account UI is shown whenever the session is open
        [self.buttonLoginLogout setTitle:@"Log out" forState:UIControlStateNormal];
        [self.textNoteOrLink setText:[NSString stringWithFormat:@"https://graph.facebook.com/me/friends?access_token=%@",
                                      appDelegate.session.accessTokenData.accessToken]];
        
    } else {
        // login-needed account UI is shown whenever the session is closed
        [self.buttonLoginLogout setTitle:@"Log in" forState:UIControlStateNormal];
        [self.textNoteOrLink setText:@"Login to create a link to fetch account data"];
    }
}

// FBSample logic
// handler for button click, logs sessions in or out
- (IBAction)buttonClickHandler:(id)sender
{
    // get the app delegate so that we can access the session property
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    // this button's job is to flip-flop the session from open to closed
    if (appDelegate.session.isOpen)
    {
        // if a user logs out explicitly, we delete any cached token information, and next
        // time they run the applicaiton they will be presented with log in UX again; most
        // users will simply close the app or switch away, without logging out; this will
        // cause the implicit cached-token login to occur on next launch of the application
        [appDelegate.session closeAndClearTokenInformation];
        
    } else {
        if (appDelegate.session.state != FBSessionStateCreated) {
            // Create a new, logged out session.
            appDelegate.session = [[FBSession alloc] init];
        }
        
                
        // if the session isn't open, let's open it now and present the login UX to the user
        [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                         FBSessionState status,
                                                         NSError *error) {
            // and here we make sure to update our UX according to the new session state
            [self updateView];
            
            // generate c   lient hash
            [appDelegate.userManager logIn];
        }];
    }
}

- (void)loginCallback
{
    // get app delegate
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    // get logged in user info
    NSString *endpoint = [NSString stringWithFormat:@"%@", LOGIN_USER];
    NSArray *keys = [[NSArray alloc] initWithObjects:FACEBOOK_ID, NAME, AUTH_HASH, nil];
    NSString *hash = [APIClient authHash];
    NSString *displayName = [appDelegate.userManager.displayName urlencode];
    NSArray *objects = [[NSArray alloc] initWithObjects:appDelegate.userManager.fbUID, displayName, hash, nil];
    NSDictionary *params = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    [APIClient get:endpoint withQueryParams:params success:[self loginSuccess] failure:[self loginFailure]];
}

#pragma mark Template generated code

- (void)viewDidUnload
{
    self.buttonLoginLogout = nil;
    self.textNoteOrLink = nil;
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return FALSE;
    // Return YES for supported orientations
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
//    {
//        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//    }
//    else
//    {
//        return FALSE;
//    }
}

#pragma mark - Remote callbacks

- (SuccessCallback) loginSuccess
{
    SuccessCallback block = ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
    {
        // hide loading indicator
        [_loadingIndicator hide:TRUE];
        
        // go to main controller
        [self performSegueWithIdentifier:LOGIN_TO_MAIN sender:self];
    };
    
    return block;
}

- (FailureCallback) loginFailure
{
    FailureCallback block = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
    {
        // hide loading indicator
        [_loadingIndicator hide:TRUE];
    };
    
    return block;
}

@end
