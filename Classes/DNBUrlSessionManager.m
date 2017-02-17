//
//  DNBUrlSessionManager.m
//  DoubleNodeOpen Base
//
//  Created by Darren Ehlers on 2017/02/17.
//  Copyright © 2017 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "DNBUrlSessionManager.h"

#import "DNBUtilities.h"

@implementation DNBUrlSessionManager

+ (_Nonnull instancetype)manager
{
    return [[DNBUrlSessionManager alloc] init];
}

+ (_Nonnull instancetype)managerWithSessionConfiguration:(NSURLSessionConfiguration* _Nonnull)configuration
{
    return [[DNBUrlSessionManager alloc] initWithSessionConfiguration:configuration];
}

- (_Nonnull instancetype)init
{
    return [super initWithSessionConfiguration:nil];
}

- (_Nonnull instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration* _Nullable)configuration
{
    if (!configuration)
    {
        configuration   = [NSURLSessionConfiguration defaultSessionConfiguration];
    }
    
    return [super initWithSessionConfiguration:configuration];
}

- (NSURLSessionDataTask*)sendTaskWithRequest:(NSURLRequest*)request
                          serverErrorHandler:(void(^ _Nullable)(NSHTTPURLResponse* _Nullable httpResponse))serverErrorHandler
                            dataErrorHandler:(void(^ _Nullable)(NSData* _Nullable errorData, NSString* _Nullable errorMessage))dataErrorHandler
                         unknownErrorHandler:(void(^ _Nullable)(NSError* _Nullable dataError))unknownErrorHandler
                       noResponseBodyHandler:(void(^ _Nullable)())noResponseBodyHandler
                           completionHandler:(void(^ _Nullable)(NSURLResponse* _Nonnull response, id _Nullable responseObject))completionHandler
{
    return [super dataTaskWithRequest:request
                    completionHandler:
            ^(NSURLResponse* _Nonnull response, id _Nullable responseObject, NSError* _Nullable dataError)
            {
                if (dataError)
                {
                    DNBLog(DNBLL_Info, DNBLD_Networking, @"DATAERROR - %@", response.URL);
                    
                    if (dataError.code == NSURLErrorTimedOut)
                    {
                        NSHTTPURLResponse*  httpResponse;
                        if ([response isKindOfClass:[NSHTTPURLResponse class]])
                        {
                            httpResponse    = (NSHTTPURLResponse*)response;
                        }
                        
                        DNBLog(DNBLL_Info, DNBLD_Networking, @"WILLRETRY - %@", response.URL);
                        [DNBUtilities runOnBackgroundThreadAfterDelay:1.0f
                                                                block:
                         ^()
                         {
                             serverErrorHandler ? serverErrorHandler(httpResponse) : nil;
                         }];
                        return;
                    }
                    
                    if ([response isKindOfClass:[NSHTTPURLResponse class]])
                    {
                        NSHTTPURLResponse*    httpResponse    = (NSHTTPURLResponse*)response;
                        if (httpResponse.statusCode == 500)
                        {
                            DNBLog(DNBLL_Info, DNBLD_Networking, @"WILLRETRY - %@", response.URL);
                            [DNBUtilities runOnBackgroundThreadAfterDelay:1.0f
                                                                    block:
                             ^()
                             {
                                 serverErrorHandler ? serverErrorHandler(httpResponse) : nil;
                             }];
                            return;
                        }
                    }
                    
                    NSData*    errorData   = dataError.userInfo[@"com.alamofire.serialization.response.error.data"];
                    NSString*  errorString = [[NSString alloc] initWithData:errorData
                                                                   encoding:NSASCIIStringEncoding];
                    DNBLog(DNBLL_Debug, DNBLD_General, @"data=%@", errorString);
                    
                    if (errorData)
                    {
                        id jsonData = [NSJSONSerialization JSONObjectWithData:errorData
                                                                      options:0
                                                                        error:nil];
                        if (jsonData)
                        {
                            NSString*  errorMessage    = jsonData[@"error"];
                            if (!errorMessage)
                            {
                                errorMessage    = jsonData[@"data"][@"error"];
                            }
                            if (!errorMessage)
                            {
                                errorMessage    = jsonData[@"data"][@"message"];
                            }
                            if (!errorMessage)
                            {
                                errorMessage    = jsonData[@"message"];
                            }
                            
                            dataErrorHandler ? dataErrorHandler(errorData, errorMessage) : nil;
                            return;
                        }
                    }
                    
                    unknownErrorHandler ? unknownErrorHandler(dataError) : nil;
                    return;
                }
                
                if (!responseObject)
                {
                    noResponseBodyHandler ? noResponseBodyHandler() : nil;
                    return;
                }
                
                completionHandler ? completionHandler(response, responseObject) : nil;
            }];
}

- (NSURLSessionDataTask*)dataTaskWithRequest:(NSURLRequest*)request
                                    withData:(NSData* _Nonnull)data
                          serverErrorHandler:(void(^ _Nullable)(NSHTTPURLResponse* _Nullable httpResponse))serverErrorHandler
                            dataErrorHandler:(void(^ _Nullable)(NSData* _Nullable errorData, NSString* _Nullable errorMessage))dataErrorHandler
                         unknownErrorHandler:(void(^ _Nullable)(NSError* _Nullable dataError))unknownErrorHandler
                       noResponseBodyHandler:(void(^ _Nullable)())noResponseBodyHandler
                           completionHandler:(void(^ _Nullable)(NSURLResponse* _Nonnull response, id _Nullable responseObject))completionHandler
{
    return [super uploadTaskWithRequest:request
                               fromData:data
                               progress:
            ^(NSProgress* _Nonnull uploadProgress)
            {
            }
                      completionHandler:
            ^(NSURLResponse* _Nonnull response, id _Nullable responseObject, NSError* _Nullable dataError)
            {
                if (dataError)
                {
                    DNBLog(DNBLL_Info, DNBLD_Networking, @"DATAERROR - %@", response.URL);
                    
                    if (dataError.code == NSURLErrorTimedOut)
                    {
                        NSHTTPURLResponse*  httpResponse;
                        if ([response isKindOfClass:[NSHTTPURLResponse class]])
                        {
                            httpResponse    = (NSHTTPURLResponse*)response;
                        }
                        
                        DNBLog(DNBLL_Info, DNBLD_Networking, @"WILLRETRY - %@", response.URL);
                        [DNBUtilities runOnBackgroundThreadAfterDelay:1.0f
                                                                block:
                         ^()
                         {
                             serverErrorHandler ? serverErrorHandler(httpResponse) : nil;
                         }];
                        return;
                    }
                    
                    if ([response isKindOfClass:[NSHTTPURLResponse class]])
                    {
                        NSHTTPURLResponse*    httpResponse    = (NSHTTPURLResponse*)response;
                        if (httpResponse.statusCode == 500)
                        {
                            DNBLog(DNBLL_Info, DNBLD_Networking, @"WILLRETRY - %@", response.URL);
                            [DNBUtilities runOnBackgroundThreadAfterDelay:1.0f
                                                                    block:
                             ^()
                             {
                                 serverErrorHandler ? serverErrorHandler(httpResponse) : nil;
                             }];
                            return;
                        }
                    }
                    
                    NSData*    errorData   = dataError.userInfo[@"com.alamofire.serialization.response.error.data"];
                    NSString*  errorString = [[NSString alloc] initWithData:errorData
                                                                   encoding:NSASCIIStringEncoding];
                    DNBLog(DNBLL_Debug, DNBLD_General, @"data=%@", errorString);
                    
                    if (errorData)
                    {
                        id jsonData = [NSJSONSerialization JSONObjectWithData:errorData
                                                                      options:0
                                                                        error:nil];
                        if (jsonData)
                        {
                            NSString*  errorMessage    = jsonData[@"error"];
                            
                            dataErrorHandler ? dataErrorHandler(errorData, errorMessage) : nil;
                        }
                    }
                    
                    unknownErrorHandler ? unknownErrorHandler(dataError) : nil;
                    return;
                }
                
                if (!responseObject)
                {
                    noResponseBodyHandler ? noResponseBodyHandler() : nil;
                    return;
                }
                
                completionHandler ? completionHandler(response, responseObject) : nil;
            }];
}

@end
