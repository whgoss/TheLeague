//
//  BaseUIViewController.h
//  Hackathon Selection
//
//  Created by Will Goss on 8/16/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>

@interface BaseUIViewController : UIViewController
{
    MBProgressHUD *_loadingIndicator;
}

@end