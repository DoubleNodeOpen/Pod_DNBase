//
//  NSDate+DNBPrettyDate.m
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

#import "NSDate+DNBPrettyDate.h"

@implementation NSDate (DNBPrettyDate)

- (NSString*)shortPrettyDate
{
    NSString*   prettyTimestamp;

    float   delta = [self timeIntervalSinceNow] * -1;
    if (delta < 60)
    {
        prettyTimestamp = NSLocalizedString(@"just now", nil);
        //prettyTimestamp = [NSString stringWithFormat:@"%d seconds ago", (int)delta];
    }
    else if (delta < 120)
    {
        prettyTimestamp = NSLocalizedString(@"1 min ago", nil);
    }
    else if (delta < 3600)
    {
        prettyTimestamp = [NSString stringWithFormat:NSLocalizedString(@"%d mins ago", nil), (int)floor(delta / 60.0f)];
    }
    else if (delta < 7200)
    {
        prettyTimestamp = NSLocalizedString(@"1 hr ago", nil);
    }
    else if (delta < 86400)
    {
        prettyTimestamp = [NSString stringWithFormat:NSLocalizedString(@"%d hrs ago", nil), (int)floor(delta / 3600.0f)];
    }
    else if (delta < (86400 * 2))
    {
        prettyTimestamp = NSLocalizedString(@"1 day ago", nil);
    }
    else if (delta < (86400 * 7))
    {
        prettyTimestamp = [NSString stringWithFormat:NSLocalizedString(@"%d days ago", nil), (int)floor(delta / 86400.0f)];
    }
    else if (delta < (86400 * 14))
    {
        prettyTimestamp = [NSString stringWithFormat:NSLocalizedString(@"1 wk ago", nil)];
    }
    else if (delta < (86400 * 35))
    {
        prettyTimestamp = [NSString stringWithFormat:NSLocalizedString(@"%d wks ago", nil), (int)floor(delta / (86400.0f * 7))];
    }
    else
    {
        NSDateFormatter*    formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];

        prettyTimestamp = [NSString stringWithFormat:NSLocalizedString(@"on %@", nil), [formatter stringFromDate:self]];
    }

    return prettyTimestamp;
}

- (NSString*)prettyDate
{
    NSString*   prettyTimestamp;
    
    float   delta = [self timeIntervalSinceNow] * -1;
    if (delta < 60)
    {
        prettyTimestamp = NSLocalizedString(@"just now", nil);
        //prettyTimestamp = [NSString stringWithFormat:@"%d seconds ago", (int)delta];
    }
    else if (delta < 120)
    {
        prettyTimestamp = NSLocalizedString(@"one minute ago", nil);
    }
    else if (delta < 3600)
    {
        prettyTimestamp = [NSString stringWithFormat:NSLocalizedString(@"%d minutes ago", nil), (int)floor(delta / 60.0f)];
    }
    else if (delta < 7200)
    {
        prettyTimestamp = NSLocalizedString(@"one hour ago", nil);
    }
    else if (delta < 86400)
    {
        prettyTimestamp = [NSString stringWithFormat:NSLocalizedString(@"%d hours ago", nil), (int)floor(delta / 3600.0f)];
    }
    else if (delta < (86400 * 2))
    {
        prettyTimestamp = NSLocalizedString(@"one day ago", nil);
    }
    else if (delta < (86400 * 7))
    {
        prettyTimestamp = [NSString stringWithFormat:NSLocalizedString(@"%d days ago", nil), (int)floor(delta / 86400.0f)];
    }
    else if (delta < (86400 * 14))
    {
        prettyTimestamp = [NSString stringWithFormat:NSLocalizedString(@"one week ago", nil)];
    }
    else if (delta < (86400 * 35))
    {
        prettyTimestamp = [NSString stringWithFormat:NSLocalizedString(@"%d weeks ago", nil), (int)floor(delta / (86400.0f * 7))];
    }
    else
    {
        NSDateFormatter*    formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        
        prettyTimestamp = [NSString stringWithFormat:NSLocalizedString(@"on %@", nil), [formatter stringFromDate:self]];
    }
    
    return prettyTimestamp;
}

- (NSString*)simpleDateRange:(NSDate*)end
{
    NSString*    startFormat    = [NSDateFormatter dateFormatFromTemplate:@"MMM d"
                                                                  options:0
                                                                   locale:[NSLocale currentLocale]];
    
    NSString*    endFormat      = [NSDateFormatter dateFormatFromTemplate:@"d, yyyy"
                                                                  options:0
                                                                   locale:[NSLocale currentLocale]];

    NSDateFormatter*    startFormatter = [[NSDateFormatter alloc] init];
    [startFormatter setDateFormat:startFormat];

    NSString*   startStr    = [startFormatter stringFromDate:self];
    
    NSDateFormatter*    endFormatter    = [[NSDateFormatter alloc] init];
    [endFormatter setDateFormat:endFormat];
    
    NSString*   endStr  = [endFormatter stringFromDate:end];
    
    return [NSString stringWithFormat:@"%@-%@", startStr, endStr];
}

- (NSString*)localizedDate
{
    NSString*   datestr = [NSDateFormatter localizedStringFromDate:self
                                                         dateStyle:NSDateFormatterMediumStyle
                                                         timeStyle:NSDateFormatterNoStyle];
    if ([datestr isEqualToString:@"(null)"] == YES)
    {
        return @"";
    }
    
    return [NSString stringWithFormat:@"%@", datestr];
}

@end
