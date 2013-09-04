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

- (void)configureFromStanding: (Standing*)standing;

@end