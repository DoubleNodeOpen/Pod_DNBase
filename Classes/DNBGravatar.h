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

#import <UIKit/UIKit.h>

// Rating of Gravatar
typedef NS_ENUM(NSUInteger, DNBGravatarRating)
{
    DNBGravatarRatingG = 1,
    DNBGravatarRatingPG,
    DNBGravatarRatingR,
    DNBGravatarRatingX,
    
    DNBGravatarRating_Count
};

// Default Gravatar types: http://bit.ly/1cCmtdb
typedef NS_ENUM(NSUInteger, DNBGravatarDefault)
{
    DNBGravatarDefault404 = 1,
    DNBGravatarDefaultMysteryMan,
    DNBGravatarDefaultIdenticon,
    DNBGravatarDefaultMonsterID,
    DNBGravatarDefaultWavatar,
    DNBGravatarDefaultRetro,
    DNBGravatarDefaultBlank,
    
    DNBGravatarDefault_Count
};

@interface DNBGravatar : NSObject

// User email - you must set this!
@property (readwrite, strong, nonatomic)    NSString*           email;

// The size of the gravatar up to 2048. All gravatars are squares, so you will get 2048x2048.
@property (readwrite, nonatomic)            NSUInteger          size;

// Rating (G, PG, R, X) of gravatar to allow, helpful for kid-friendly apps.
@property (readwrite, nonatomic)            DNBGravatarRating   rating;

// If email doesn't have a gravatar, use one of these... http://bit.ly/1cCmtdb
@property (readwrite, nonatomic)            DNBGravatarDefault  defaultGravatar;

// Force a default gravatar, whether or not email has gravatar. Remember to set defaultGravatar too!
@property (readwrite, nonatomic)            BOOL                forceDefault;

- (NSString*)gravtarURL:(NSString*)email;

@end
