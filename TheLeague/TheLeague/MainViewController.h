//
//  MainViewController.h
//  TheLeague
//
//  Created by Will Goss on 8/27/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

@class User;
#import "BaseUIViewController.h"

@interface MainViewController : BaseUIViewController <UITableViewDataSource, UITableViewDelegate, UITabBarDelegate>

@property (strong, nonatomic) NSMutableArray *standingsArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end