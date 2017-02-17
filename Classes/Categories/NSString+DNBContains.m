//
//  NSString+DNBContains.m
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

#import "NSString+DNBContains.h"

@implementation NSString (DNBContains)

- (BOOL)contains:(NSString*)subString
{
    return ([self rangeOfString:subString].location != NSNotFound);
}

@end
