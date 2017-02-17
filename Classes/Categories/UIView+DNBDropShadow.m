//
//  UIView+DNBDropShadow.m
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

#import "UIView+DNBDropShadow.h"

@implementation UIView (DNBDropShadow)

const CGSize    DNVDS_DEFAULT_OFFSET   = (CGSize){ 3, 3 };
const CGFloat   DNVDS_DEFAULT_RADIUS   = 2.0f;
const CGFloat   DNVDS_DEFAULT_OPACITY  = 0.6f;

- (void)addDropShadow
{
    [self addDropShadow:UIColor.blackColor
             withOffset:DNVDS_DEFAULT_OFFSET
                 radius:DNVDS_DEFAULT_RADIUS
                opacity:DNVDS_DEFAULT_OPACITY];
}

- (void)addDropShadow:(UIColor*)color
{
    [self addDropShadow:color
             withOffset:DNVDS_DEFAULT_OFFSET
                 radius:DNVDS_DEFAULT_RADIUS
                opacity:DNVDS_DEFAULT_OPACITY];
}

- (void)addDropShadow:(UIColor*)color
           withOffset:(CGSize)offset
               radius:(CGFloat)radius
              opacity:(CGFloat)opacity
{
    self.layer.shadowColor      = color.CGColor;
    self.layer.shadowOffset     = offset;
    self.layer.shadowRadius     = radius;
    self.layer.shadowOpacity    = (float)opacity;
}

@end
