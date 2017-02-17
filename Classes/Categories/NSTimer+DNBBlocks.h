//
//  NSTimer+DNBBlocks.h
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

#import <Foundation/Foundation.h>

@interface NSTimer (DNBBlocks)

/**
 *  Creates and returns a new NSTimer object and schedules it on the current run loop in the default mode.
 *
 *  @param inTimeInterval The number of seconds between firings of the timer. If seconds is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead.
 *  @param inBlock        The block to run when the timer fires. The timer maintains a strong reference to target until it (the timer) is invalidated.
 *  @param inRepeats      If YES, the timer will repeatedly reschedule itself until invalidated. If NO, the timer will be invalidated after it fires.
 *
 *  @return A new NSTimer object, configured according to the specified parameters.
 */
+(id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;

/**
 *  Creates and returns a new NSTimer object initialized with the specified object and selector.
 *
 *  @param inTimeInterval The number of seconds between firings of the timer. If seconds is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead.
 *  @param inBlock        The block to run when the timer fires. The timer maintains a strong reference to target until it (the timer) is invalidated.
 *  @param inRepeats      If YES, the timer will repeatedly reschedule itself until invalidated. If NO, the timer will be invalidated after it fires.
 *
 *  @return A new NSTimer object, configured according to the specified parameters.
 */
+(id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats;

@end
