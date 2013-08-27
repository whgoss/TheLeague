//
//  APIClient.m
//  TheLeague
//
//  Created by Will Goss on 8/26/13.
//  Copyright (c) 2013 Will Goss. All rights reserved.
//

#import "Base64.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "APIClient.h"
#import "Constants.h"
#import <FacebookSDK/FacebookSDK.h>

@implementation APIClient

typedef void(^RetrieveTokenSuccess)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON);
typedef void(^RetrieveTokenFailure)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON);

+ (NSString*)authHash
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSString * parameters = appDelegate.userManager.fbUID;
    NSString *salt = API_KEY;
    NSData *saltData = [salt dataUsingEncoding:NSUTF8StringEncoding];
    NSData *paramData = [parameters dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* hash = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH ];
    CCHmac(kCCHmacAlgSHA256, saltData.bytes, saltData.length, paramData.bytes, paramData.length, hash.mutableBytes);
    NSString *base64Hash = [hash base64EncodedString];
    return base64Hash;
}

+ (NSURL*)baseUrl
{
    return [NSURL URLWithString:BASE_URL];
}

+ (void)get:(NSString *) endpoint withQueryParams:(NSDictionary *)queryParams
    success:(void(^)(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)) successCallback
    failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)) failureCallback
{
    NSString *newEndpoint = [NSString stringWithFormat:@"%@%@", BASE_URL, endpoint];
    NSString *urlString = [APIClient buildUrlString:queryParams forEndpoint:newEndpoint];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [APIClient buildRequestWithNSURL:url andHTTPMethod:@"GET" andEndpoint:endpoint];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:successCallback
                                         failure:failureCallback];
    [operation start];
    
}

+ (NSMutableURLRequest *) buildRequestWithNSURL:(NSURL *) url andHTTPMethod:(NSString *) method andEndpoint:(NSString *) endpoint
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:method];
    
    //    NSDictionary *authenticationHeaders = [CrowdFlikAPIClient buildAuthenticationHeadersForHTTPMethod:method withEndPoint:endpoint];
    //
    //    //add our headers to the request
    //    [authenticationHeaders enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop)
    //    {
    //        [request setValue:obj forHTTPHeaderField:key];
    //    }];
    
    return request;
}

+ (NSString *)buildUrlString:(NSDictionary *)queryParams forEndpoint: (NSString*)endpoint
{
    NSString *urlString = [NSString stringWithString:endpoint];
    
    if (queryParams && [queryParams count] > 0) {
        BOOL first = YES;
        for (NSString *key in queryParams) {
            
            NSString *keyValue = [queryParams objectForKey:key];
            
            //dont add any params that are empty strings
            if (![keyValue isEqualToString:@""] && key != nil) {
                
                NSString *format;
                if ( first ) {
                    format = @"%@%?%@=%@";
                } else {
                    format = @"%@%&%@=%@";
                }
                urlString = [NSString stringWithFormat:format, urlString, key, keyValue];
                first = NO;
            }
        }
    }
    
    return urlString;
}

+ (NSString*)convertDictionaryToJSONString: (NSDictionary*)dictionary
{
    NSMutableDictionary *tempDic = [NSMutableDictionary new];
    
    if (dictionary && [dictionary count] > 0) {
        
        for (NSString *key in dictionary) {
            
            NSString *keyValue = [dictionary objectForKey:key];
            //dont add any params that are empty strings
            if (![keyValue isEqualToString:@""] && key != nil) {
                
                [tempDic setObject:keyValue forKey:key];
            }
        }
    }
    
    NSData *dataDic = [NSJSONSerialization dataWithJSONObject:tempDic options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *jsonString = [[NSString alloc] initWithData:dataDic encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

@end