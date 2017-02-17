//
//  DNBUrlSessionManager.h
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

#import <AFNetworking/AFNetworking.h>

@interface DNBUrlSessionManager : AFURLSessionManager

+ (_Nonnull instancetype)manager;

+ (_Nonnull instancetype)managerWithSessionConfiguration:(NSURLSessionConfiguration* _Nonnull)configuration;

- (_Nonnull instancetype)init;

- (_Nonnull instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration* _Nullable)configuration;

- (NSURLSessionDataTask* _Nonnull)sendTaskWithRequest:(NSURLRequest* _Nonnull)request
                                   serverErrorHandler:(void(^ _Nullable)(NSHTTPURLResponse* _Nullable httpResponse))serverErrorHandler
                                     dataErrorHandler:(void(^ _Nullable)(NSData* _Nullable errorData, NSString* _Nullable errorMessage))dataErrorHandler
                                  unknownErrorHandler:(void(^ _Nullable)(NSError* _Nullable dataError))unknownErrorHandler
                                noResponseBodyHandler:(void(^ _Nullable)())noResponseBodyHandler
                                    completionHandler:(void(^ _Nullable)(NSURLResponse* _Nonnull response, id _Nullable responseObject))completionHandler;

- (NSURLSessionDataTask* _Nonnull)dataTaskWithRequest:(NSURLRequest* _Nonnull)request
                                             withData:(NSData* _Nonnull)data
                                   serverErrorHandler:(void(^ _Nullable)(NSHTTPURLResponse* _Nullable httpResponse))serverErrorHandler
                                     dataErrorHandler:(void(^ _Nullable)(NSData* _Nullable errorData, NSString* _Nullable errorMessage))dataErrorHandler
                                  unknownErrorHandler:(void(^ _Nullable)(NSError* _Nullable dataError))unknownErrorHandler
                                noResponseBodyHandler:(void(^ _Nullable)())noResponseBodyHandler
                                    completionHandler:(void(^ _Nullable)(NSURLResponse* _Nonnull response, id _Nullable responseObject))completionHandler;

@end
