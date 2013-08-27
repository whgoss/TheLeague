//
//  Callback.h
//  Hackathon Selection
//
//  Created by Will Goss on 8/15/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CallBack : NSObject

typedef void(^SuccessCallback)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON);
typedef void(^FailureCallback)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON);

@end