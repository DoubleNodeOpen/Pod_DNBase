//
//  DNBGravatar.h
//  DoubleNodeOpen Base
//
//  Created by Darren Ehlers on 2017/02/17.
//  Copyright © 2017 Darren Ehlers and DoubleNode, LLC. All rights reserved.
//
//  Derived from work originally created by Rudd Fawcett
//  Portions Copyright (c) 2013 Rudd Fawcett.
//  All rights reserved.
//  https://www.cocoacontrols.com/controls/uiimageview-gravatar
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

#import <CommonCrypto/CommonDigest.h>

#import "DNBGravatar.h"

@implementation DNBGravatar

- (NSString*)gravtarURL:(NSString*)email
{
    NSMutableString*    gravatarPath = [NSMutableString stringWithFormat:@"https://gravatar.com/avatar/%@?", [self createMD5:email]];

    return [self buildLink:gravatarPath];
}

- (NSMutableString*)buildLink:(NSMutableString*)baseLink
{
    if (_size)
    {
        [baseLink appendString:[NSString stringWithFormat:@"&size=%lu", (unsigned long)_size]];
    }

    if (_rating)
    {
        switch (_rating)
        {
            case DNBGravatarRatingG:    {   [baseLink appendString:@"&rating=g"];   break;  }
            case DNBGravatarRatingPG:   {   [baseLink appendString:@"&rating=pg"];  break;  }
            case DNBGravatarRatingR:    {   [baseLink appendString:@"&rating=r"];   break;  }
            case DNBGravatarRatingX:    {   [baseLink appendString:@"&rating=x"];   break;  }

            default:    {   break;  }
        }
    }

    if (_defaultGravatar)
    {
        switch (_defaultGravatar)
        {
            case DNBGravatarDefault404:         {   [baseLink appendString:@"&default=404"];        break;  }
            case DNBGravatarDefaultMysteryMan:  {   [baseLink appendString:@"&default=mm"];         break;  }
            case DNBGravatarDefaultIdenticon:   {   [baseLink appendString:@"&default=identicon"];  break;  }
            case DNBGravatarDefaultMonsterID:   {   [baseLink appendString:@"&default=monsterid"];  break;  }
            case DNBGravatarDefaultWavatar:     {   [baseLink appendString:@"&default=wavatar"];    break;  }
            case DNBGravatarDefaultRetro:       {   [baseLink appendString:@"&default=retro"];      break;  }
            case DNBGravatarDefaultBlank:       {   [baseLink appendString:@"&default=blank"];      break;  }

            default:    {   break;  }
        }
    }

    if (_forceDefault)
    {
        [baseLink appendString:@"&forcedefault=y"];
    }

    return baseLink;
}

- (NSString*)createMD5:(NSString*)email
{
    const char*     cStr = [email UTF8String];
    unsigned char   digest[16];

    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);

    NSMutableString*    emailMD5 = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];

    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [emailMD5 appendFormat:@"%02x", digest[i]];
    }

    return emailMD5;
}

@end
