//
//  UIFont+DNBCustom.h
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

#import <UIKit/UIKit.h>

@interface UIFont (DNBCustom)

/**
 *  Creates and returns a new UIFont object (works around the iOS oddity which required an additional sizing call).
 *
 *  @param fontName The postscript font name string
 *  @param fontSize The font size (in points)
 *
 *  @return A new UIFont configured according to the specified parameters.
 */
+ (UIFont*)customFontWithName:(NSString*)fontName size:(double)fontSize;

+ (UIFont*)customFontWithNameDebug:(NSString*)fontName size:(double)fontSize;

@end
