//
//  NSDate+DNBPrettyDate.h
//  DoubleNode Core
//
//  Created by Darren Ehlers on 2017/02/17.
//  Copyright © 2016 Darren Ehlers and DoubleNode, LLC. All rights reserved.
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

#import <Foundation/Foundation.h>

@interface NSDate (DNBPrettyDate)

/**
 *  Creates and returns a new NSString object initialized with a natural language version of the source date in relation to now.
 *
 *  @warning This function is NOT localized, only supports English.
 *
 *  @return A new NSString object, configured with a natual language representation of the source date.
 */
- (NSString*)prettyDate;

/**
 *  Creates and returns a new NSString object initialized with a natural language version of the source date in relation to now.
 *
 *  @warning This function is NOT localized, only supports English.
 *
 *  @return A new NSString object, configured with a natual language representation of the source date.
 */
- (NSString*)shortPrettyDate;

/**
 *  Creates and returns a new NSString object initialized with a simple display of a date range, between the source date and the end data parameter.
 *
 *  @param end The end date for the date range string.
 *
 *  @warning This function is currently not very robust, and works well only for dates within the same month.  This function should be revisited and expanded upon in the future.
 *
 *  @return A new NSString object, configured with a simple representation of a date range (ie: MMM d-d, yyyy).
 */
- (NSString*)simpleDateRange:(NSDate*)end;

/**
 *  Creates an returns a new NSString object initialized with a localized version of the source date.
 *
 *  @return A new NSString object, configured with a localized version of the source date.
 */
- (NSString*)localizedDate;

@end
