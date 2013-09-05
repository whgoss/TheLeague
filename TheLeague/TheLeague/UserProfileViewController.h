//
//  UserProfileViewController.h
//  TheLeague
//
//  Created by Will Goss on 8/28/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

@class Standing;
@class User;
#import "BaseUIViewController.h"

@interface UserProfileViewController : BaseUIViewController

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *bracketLabel;
@property (strong, nonatomic) IBOutlet UILabel *recordLabel;
@property (strong, nonatomic) IBOutlet UILabel *winPercentageLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastLoginLabel;
@property (strong, nonatomic) IBOutlet UITableView *statsView;
@property (strong, nonatomic) IBOutlet UIImageView *avatarView;
@property (strong, nonatomic) IBOutlet UIButton *challengeButton;

- (void)setUser: (User*)user withStanding: (Standing*)standing;

@end