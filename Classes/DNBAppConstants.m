//
//  DNBAppConstants.m
//  DoubleNode.com
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

#import <ColorUtils/ColorUtils.h>

#import "DNBUtilities.h"

#import "DNBAppConstants.h"

@implementation DNBAppConstants

+ (NSDate*)dateConstant:(NSString*)key
{
    return [[self class] dateConstant:key filter:nil];
}

+ (NSDate*)dateConstant:(NSString*)key
                 filter:(NSString*)filter
{
    NSString*   str = [[self class] constantValue:key filter:filter];
    
    NSDateFormatter*    formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd/yyyy HH:mm z"];
    
    return [formatter dateFromString:str];
}

+ (UIColor*)colorConstant:(NSString*)key
{
    return [[self class] colorConstant:key filter:nil];
}

+ (UIColor*)colorConstant:(NSString*)key
                   filter:(NSString*)filter
{
    return [UIColor colorWithString:[[self class] constantValue:key filter:filter]];
}

+ (BOOL)boolConstant:(NSString*)key
{
    return [[self class] boolConstant:key filter:nil];
}

+ (BOOL)boolConstant:(NSString*)key
              filter:(NSString*)filter
{
    return [[[self class] constantValue:key filter:filter] boolValue];
}

+ (double)doubleConstant:(NSString*)key
{
    return [[self class] doubleConstant:key filter:nil];
}

+ (double)doubleConstant:(NSString*)key
                  filter:(NSString*)filter
{
    return [[[self class] constantValue:key filter:filter] doubleValue];
}

+ (int)intConstant:(NSString*)key
{
    return [[self class] intConstant:key filter:nil];
}

+ (int)intConstant:(NSString*)key
            filter:(NSString*)filter
{
    return [[[self class] constantValue:key filter:filter] intValue];
}

+ (UIFont*)fontConstant:(NSString*)key
{
    return [[self class] fontConstant:key filter:nil];
}

+ (UIFont*)fontConstant:(NSString*)key
                 filter:(NSString*)filter
{
    NSString*   fontName    = [[self class] constantValue:[NSString stringWithFormat:@"%@Name", key] filter:filter];
    NSString*   fontSize    = [[self class] constantValue:[NSString stringWithFormat:@"%@Size", key] filter:filter];
    
    UIFont* retFont  = [UIFont fontWithName:fontName size:([fontSize doubleValue] / 2)];
    
    return [retFont fontWithSize:([fontSize doubleValue] / 2)];
}

+ (CGSize)sizeConstant:(NSString*)key
{
    return [[self class] sizeConstant:key filter:nil];
}

+ (CGSize)sizeConstant:(NSString*)key
                filter:(NSString*)filter
{
    NSString*   sizeWidth   = [[self class] constantValue:[NSString stringWithFormat:@"%@Width", key] filter:filter];
    NSString*   sizeHeight  = [[self class] constantValue:[NSString stringWithFormat:@"%@Height", key] filter:filter];
    
    return CGSizeMake([sizeWidth floatValue], [sizeHeight floatValue]);
}

+ (NSDictionary*)dictionaryConstant:(NSString*)key
{
    NSDictionary*   value   = [[self class] plistConfig:key];
    
    return value;
}

+ (id)constantValue:(NSString*)key
{
    return [self constantValue:key filter:nil];
}

+ (id)constantValue:(NSString*)key
             filter:(NSString*)filter
{
    id  value   = [[self class] plistConfig:key];
    
    if (filter && [value isKindOfClass:[NSDictionary class]])
    {
        NSDictionary*   values  = (NSDictionary*)value;

        value   = values[filter];
        if (!value)
        {
            value   = values[@"default"];
        }
    }
    else if (value)
    {
        value   = [NSString stringWithFormat:@"%@", value];
    }
    
    return value;
}

static NSDictionary*    plistConfigDict = nil;
static NSString*        plistServerCode = nil;

+ (NSDictionary*)plistDict
{
    NSString*   serverCode  = [DNBUtilities.appDelegate settingsItem:@"ServerCode"];
    //DLog(LL_Debug, LD_General, @"ServerCode=%@", serverCode);
    if (![serverCode isEqualToString:plistServerCode])
    {
        plistConfigDict = nil;
        plistServerCode = serverCode;
    }

    @synchronized( self )
    {
        if (plistConfigDict == nil)
        {
            NSString*   constantsPlist  = @"Constants";
            NSString*   constantsPath   = [[NSBundle mainBundle] pathForResource:constantsPlist ofType:@"plist"];
            if (!constantsPath)
            {
                NSException*    exception = [NSException exceptionWithName:@"DNAppConstants Exception"
                                                                    reason:[NSString stringWithFormat:@"Constants plist not found: %@", constantsPlist]
                                                                  userInfo:nil];
                @throw exception;
            }

            plistConfigDict = [[NSDictionary alloc] initWithContentsOfFile:constantsPath];
            if (!plistConfigDict)
            {
                NSException*    exception = [NSException exceptionWithName:@"DNAppConstants Exception"
                                                                    reason:[NSString stringWithFormat:@"Unable to initialize Constants Config Dictionary: %@", constantsPath]
                                                                  userInfo:nil];
                @throw exception;
            }

            NSString*   constantsPlist2 = [NSString stringWithFormat:@"Constants%@%@", ((serverCode.length > 0) ? @"_" : @""), serverCode];
            NSString*   constantsPath2  = [[NSBundle mainBundle] pathForResource:constantsPlist2 ofType:@"plist"];
            if (constantsPath2)
            {
                NSMutableDictionary*    newDict = [NSMutableDictionary dictionaryWithDictionary:plistConfigDict];
                
                NSDictionary*   overrideItems   = [[NSDictionary alloc] initWithContentsOfFile:constantsPath2];
                [overrideItems enumerateKeysAndObjectsUsingBlock:
                 ^(NSString* key, id obj, BOOL* stop)
                 {
                     id originalObj = newDict[key];
                     
                     if ([obj isKindOfClass:[NSDictionary class]])
                     {
                         NSMutableDictionary*   objMD  = [obj mutableCopy];
                         if ([originalObj isKindOfClass:[NSDictionary class]])
                         {
                             [objMD addEntriesFromDictionary:originalObj];
                         }
                         else
                         {
                             objMD[@"default"]  = originalObj;
                         }
                         
                         newDict[key]   = objMD;
                     }
                     else
                     {
                         newDict[key]   = obj;
                     }
                 }];
                
                plistConfigDict = newDict;
            }
        }
    }
    
    return plistConfigDict;
}

+ (id)plistConfig:(NSString*)key
{
    NSDictionary*   dict = [[self class] plistDict];
    
    id  value = dict[key];
    if ((value == nil) || (value == [NSNull null]))
    {
        DNBLog(DNBLL_Warning, DNBLD_Framework, @"***** MISSING CONSTANT KEY: %@", key);
    }
    
    return value;
}

@end