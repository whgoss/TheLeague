//
//  StandingCell.h
//  TheLeague
//
//  Created by Will Goss on 8/27/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

@class Standing;
@class User;
#import <UIKit/UIKit.h>

@interface StandingCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *positionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *avatarView;
@property (strong, nonatomic) IBOutlet UIImageView *upDownView;
@property (strong, nonatomic) Standing *standing;

- (void)configureFromStanding: (Standing*)standing;

@end