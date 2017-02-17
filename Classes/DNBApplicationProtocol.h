//
//  DNBApplicationProtocol.h
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
#import <UIKit/UIKit.h>

/**
 *  Provides functions expected to be in the applications AppDelegate class.
 */
@protocol DNBApplicationProtocol<NSObject>

#pragma mark - Base DNBApplicationProtocol functions

@optional

/**
 *  Hook to setup initial debug logging state
 *
 *  @discussion The primary use-case for this function is for debugging, diagnostics and unit testing.
 *
 */
- (void)resetLogState;

@required

- (NSString*)buildString;
- (NSString*)versionString;
- (NSString*)bundleName;

/**
 *  Returns the rootViewController.
 *
 *  @return The main window's rootViewController.
 *
 */
- (UIViewController*)rootViewController;

/**
 *  Displays/hides the status bar networkActivityIndicator in a thread-safe, nested manner.
 *
 */
- (void)setNetworkActivityIndicatorVisible:(BOOL)setVisible;

/**
 *  Returns the current state of reachability.
 *
 */
- (BOOL)isReachable;

#pragma mark - CoreData DNBApplicationProtocol functions

/**
 *  Disables the App URL Cache (if applicable).
 *
 *  @discussion The primary use-case for this function is for debugging, diagnostics and unit testing.
 *
 */
- (void)disableURLCache;

#pragma mark - NSUserDefaults settings items

/**
 *  Loads and returns the current value of the user setting, specified by a key.
 *
 *  @param item The NSString key for the specific user setting.
 *
 *  @return The current value of the specified user setting (or @"" if not set).
 */
- (id)settingsItem:(NSString*)item;

/**
 *  Loads and returns the current value of the user setting, specified by a key and a default value.
 *
 *  @param item         The NSString key for the specific user setting.
 *  @param defaultValue The default value for the specific user setting, when it has not been previously set.
 *
 *  @return The current value of the specified user setting.
 */
- (id)settingsItem:(NSString*)item default:(id)defaultValue;

/**
 *  Loads and returns the current BOOL value of the user setting, specified by a key and a default value.
 *
 *  @param item         The NSString key for the specific user setting.
 *  @param defaultValue The default BOOL value for the specific user setting, when it has not been previously set.
 *
 *  @return The current value of the specified user setting.
 */
- (BOOL)settingsItem:(NSString*)item boolDefault:(BOOL)defaultValue;

/**
 *  Sets the value of the user setting, specified by a key.
 *
 *  @param item  The NSString key for the specific user setting.
 *  @param value The new value for the specific user setting.
 */
- (void)setSettingsItem:(NSString*)item value:(id)value;

/**
 *  Sets the BOOL value of the user setting, specified by a key.
 *
 *  @param item  The NSString key for the specific user setting.
 *  @param value The new BOOL value for the specific user setting.
 */
- (void)setSettingsItem:(NSString*)item boolValue:(BOOL)value;

@end

