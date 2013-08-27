//
//  APIClient.h
//  TheLeague
//
//  Created by Will Goss on 8/26/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIClient : NSObject

+ (NSString*)authHash;

+ (void)get:(NSString *) endpoint withQueryParams:(NSDictionary *)queryParams
    success:(void(^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)) successCallback
    failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)) failureCallback;

@end