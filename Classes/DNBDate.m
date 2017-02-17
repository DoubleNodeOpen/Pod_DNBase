//
//  DNBDate.m
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

#import "DNBDate.h"

@implementation DNBDate

+ (id)dateWithComponentFlags:(unsigned)flags fromDate:(NSDate*)date
{
    return [[DNBDate alloc] initWithComponentFlags:flags fromDate:date];
}

+ (id)dateWithComponents:(NSDateComponents*)components
{
    return [[DNBDate alloc] initWithComponents:components];
}

- (id)initWithComponentFlags:(unsigned)flags fromDate:(NSDate*)date
{
    NSCalendar*    calendar    = [NSCalendar currentCalendar];

    NSDateComponents*   components  = [calendar components:flags fromDate:date];
    
    return [self initWithComponents:components];
}

- (id)initWithComponents:(NSDateComponents*)components
{
    self = [super init];
    if (self)
    {
        self.era                = components.era;
        self.year               = components.year;
        self.month              = components.month;
        self.day                = components.day;
        self.hour               = components.hour;
        self.minute             = components.minute;
        self.second             = components.second;
        self.nanosecond         = components.nanosecond;
        self.weekday            = components.weekday;
        self.weekdayOrdinal     = components.weekdayOrdinal;
        self.quarter            = components.quarter;
        self.weekOfMonth        = components.weekOfMonth;
        self.weekOfYear         = components.weekOfYear;
        self.yearForWeekOfYear  = components.yearForWeekOfYear;
        self.leapMonth          = components.leapMonth;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder*)decoder
{
    self = [super init];
    if (self)
    {
        self.era                = [[decoder decodeObjectForKey:@"era"] integerValue];
        self.year               = [[decoder decodeObjectForKey:@"year"] integerValue];
        self.month              = [[decoder decodeObjectForKey:@"month"] integerValue];
        self.day                = [[decoder decodeObjectForKey:@"day"] integerValue];
        self.hour               = [[decoder decodeObjectForKey:@"hour"] integerValue];
        self.minute             = [[decoder decodeObjectForKey:@"minute"] integerValue];
        self.second             = [[decoder decodeObjectForKey:@"second"] integerValue];
        self.nanosecond         = [[decoder decodeObjectForKey:@"nanosecond"] integerValue];
        self.weekday            = [[decoder decodeObjectForKey:@"weekday"] integerValue];
        self.weekdayOrdinal     = [[decoder decodeObjectForKey:@"weekdayOrdinal"] integerValue];
        self.quarter            = [[decoder decodeObjectForKey:@"quarter"] integerValue];
        self.weekOfMonth        = [[decoder decodeObjectForKey:@"weekOfMonth"] integerValue];
        self.weekOfYear         = [[decoder decodeObjectForKey:@"weekOfYear"] integerValue];
        self.yearForWeekOfYear  = [[decoder decodeObjectForKey:@"yearForWeekOfYear"] integerValue];
        self.leapMonth          = [[decoder decodeObjectForKey:@"leapMonth"] integerValue];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeObject:@(self.era)               forKey:@"era"];
    [encoder encodeObject:@(self.year)              forKey:@"year"];
    [encoder encodeObject:@(self.month)             forKey:@"month"];
    [encoder encodeObject:@(self.day)               forKey:@"day"];
    [encoder encodeObject:@(self.hour)              forKey:@"hour"];
    [encoder encodeObject:@(self.minute)            forKey:@"minute"];
    [encoder encodeObject:@(self.second)            forKey:@"second"];
    [encoder encodeObject:@(self.nanosecond)        forKey:@"nanosecond"];
    [encoder encodeObject:@(self.weekday)           forKey:@"weekday"];
    [encoder encodeObject:@(self.weekdayOrdinal)    forKey:@"weekdayOrdinal"];
    [encoder encodeObject:@(self.quarter)           forKey:@"quarter"];
    [encoder encodeObject:@(self.weekOfMonth)       forKey:@"weekOfMonth"];
    [encoder encodeObject:@(self.weekOfYear)        forKey:@"weekOfYear"];
    [encoder encodeObject:@(self.yearForWeekOfYear) forKey:@"yearForWeekOfYear"];
    [encoder encodeObject:@(self.leapMonth)         forKey:@"leapMonth"];
}

- (NSComparisonResult)compare:(id)otherObject
{
    DNBDate*    otherDate   = (DNBDate*)otherObject;
    
    if ((self.era != INT32_MAX) && (otherDate.era != INT32_MAX))
    {
        if (self.era < otherDate.era)
        {
            return NSOrderedAscending;
        }
        else if (self.era > otherDate.era)
        {
            return NSOrderedDescending;
        }
    }
    
    if ((self.year != INT32_MAX) && (otherDate.year != INT32_MAX))
    {
        if (self.year < otherDate.year)
        {
            return NSOrderedAscending;
        }
        else if (self.year > otherDate.year)
        {
            return NSOrderedDescending;
        }
    }
    
    if ((self.month != INT32_MAX) && (otherDate.month != INT32_MAX))
    {
        if (self.month < otherDate.month)
        {
            return NSOrderedAscending;
        }
        else if (self.month > otherDate.month)
        {
            return NSOrderedDescending;
        }
    }
    
    if ((self.day != INT32_MAX) && (otherDate.day != INT32_MAX))
    {
        if (self.day < otherDate.day)
        {
            return NSOrderedAscending;
        }
        else if (self.day > otherDate.day)
        {
            return NSOrderedDescending;
        }
    }
    
    if ((self.hour != INT32_MAX) && (otherDate.hour != INT32_MAX))
    {
        if (self.hour < otherDate.hour)
        {
            return NSOrderedAscending;
        }
        else if (self.hour > otherDate.hour)
        {
            return NSOrderedDescending;
        }
    }
    
    if ((self.minute != INT32_MAX) && (otherDate.minute != INT32_MAX))
    {
        if (self.minute < otherDate.minute)
        {
            return NSOrderedAscending;
        }
        else if (self.minute > otherDate.minute)
        {
            return NSOrderedDescending;
        }
    }
    
    if ((self.second != INT32_MAX) && (otherDate.second != INT32_MAX))
    {
        if (self.second < otherDate.second)
        {
            return NSOrderedAscending;
        }
        else if (self.second > otherDate.second)
        {
            return NSOrderedDescending;
        }
    }
    
    if ((self.nanosecond != INT32_MAX) && (otherDate.nanosecond != INT32_MAX))
    {
        if (self.nanosecond < otherDate.nanosecond)
        {
            return NSOrderedAscending;
        }
        else if (self.nanosecond > otherDate.nanosecond)
        {
            return NSOrderedDescending;
        }
    }
    
    return NSOrderedSame;
}

- (BOOL)isEqualToDNDate:(DNBDate*)otherDate
{
    return ([self compare:otherDate] == NSOrderedSame);
}

- (NSDate*)date
{
    if (!super.date)
    {
        NSCalendar* calendar    = super.calendar;
        if (!calendar)
        {
            calendar    = [NSCalendar currentCalendar];
        }
    
        return [calendar dateFromComponents:self];
    }
    
    return super.date;
}

- (NSString*)dayOfWeekString
{
    switch (self.weekday)
    {
        case 1:     return @"Sunday";
        case 2:     return @"Monday";
        case 3:     return @"Tuesday";
        case 4:     return @"Wednesday";
        case 5:     return @"Thursday";
        case 6:     return @"Friday";
            
        case 7:
        default:
            return @"Saturday";
    }
}

- (NSString*)dateString
{
    return [NSString stringWithFormat:@"%02ld/%02ld/%04ld", (long)self.month, (long)self.day, (long)self.year];
}

- (NSString*)timeString
{
    NSString*   ampm    = (self.hour >= 12) ? @"pm" : @"am";
    NSUInteger  hour    = (self.hour == 0) ? 12 : ((self.hour > 12) ? (self.hour - 12) : self.hour);
    
    if (self.minute > 0)
    {
        return [NSString stringWithFormat:@"%2lu:%02ld%@", (unsigned long)hour, (long)self.minute, ampm];
    }

    return [NSString stringWithFormat:@"%2lu%@", (unsigned long)hour, ampm];
}

@end
