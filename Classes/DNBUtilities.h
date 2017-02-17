//
//  DNBUtilities.h
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

#import "DNBApplicationProtocol.h"

/**
 *  System Versioning Preprocessor Macros
 */
#define DNB_SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define DNB_SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define DNB_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define DNB_SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define DNB_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/**
 *  DLog Logging Items and Macros
 */
#ifndef __DNB_LOGLEVEL__
#define __DNB_LOGLEVEL__    1

typedef NS_ENUM(NSInteger, DNBLogLevel)
{
    DNBLL_Critical = 0,
    DNBLL_Error,
    DNBLL_Warning,
    DNBLL_Debug,
    DNBLL_Info,
    DNBLL_Everything
};

#define DNBLD_UnitTests     @"UNITTESTS"
#define DNBLD_General       @"GENERAL"
#define DNBLD_Framework     @"FRAMEWORK"
#define DNBLD_CoreData      @"COREDATA"
#define DNBLD_CoreDataIS    @"COREDATAIS"
#define DNBLD_Realm         @"REALM"
#define DNBLD_ViewState     @"VIEWSTATE"
#define DNBLD_Theming       @"THEMING"
#define DNBLD_Location      @"LOCATION"
#define DNBLD_Networking    @"NETWORKING"
#define DNBLD_API           @"API"
#define DNBLD_DAO           @"DAO"

#if !defined(DEBUG)
#define DNBAssert(condition,domain,...)           NSAssert(condition, __VA_ARGS__);
#define DNBLogMarker(marker)                      NSLog(@"%@", marker)
#define DNBLog(level,domain,...)                  NSLog(__VA_ARGS__)
#define DNBLogData(level,domain,data)             ;
#define DNBLogImage(...)                          ;
#define DNBLogTimeBlock(level,domain,title,block) block()
#define DNBAssertIsMainThread                     ;
#else
#define DNBAssert(condition,domain,...)           if (!(condition)) { DNBLogMessageF(__FILE__,__LINE__,__PRETTY_FUNCTION__,domain,DNBLL_Critical,__VA_ARGS__); } NSAssert(condition, __VA_ARGS__);
#define DNBLogMarker(marker)                      NSLog(@"%@", marker); LogMessageF(__FILE__,__LINE__,__PRETTY_FUNCTION__,domain,level,@"%@", marker)
#define DNBLog(level,domain,...)                  DNBLogMessageF(__FILE__,__LINE__,__PRETTY_FUNCTION__,domain,level,__VA_ARGS__); //LogMessageF(__FILE__,__LINE__,__PRETTY_FUNCTION__,domain,level,__VA_ARGS__)
#define DNBLogData(level,domain,data)             LogDataF(__FILE__,__LINE__,__PRETTY_FUNCTION__,domain,level,data)
#define DNBLogImage(level,domain,image)           LogImageDataF(__FILE__,__LINE__,__PRETTY_FUNCTION__,domain,level,image.size.width,image.size.height,UIImagePNGRepresentation(image))
#define DNBLogTimeBlock(level,domain,title,block) DNBLogMessageF(__FILE__,__LINE__,__PRETTY_FUNCTION__,domain,level,@"%@: blockTime: %f",title,DNBTimeBlock(block)); LogMessageF(__FILE__,__LINE__,__PRETTY_FUNCTION__,domain,level,@"%@: blockTime: %f",title,DNBTimeBlock(block))
#define DNBAssertIsMainThread                     if (![NSThread isMainThread])                                                                         \
{                                                                                                                                                       \
    NSException* exception = [NSException exceptionWithName:@"DNBUtilities Exception"                                                                   \
                                                     reason:[NSString stringWithFormat:@"Not in Main Thread"]                                           \
                                                   userInfo:@{ @"FILE" : @(__FILE__), @"LINE" : @(__LINE__), @"FUNCTION" : @(__PRETTY_FUNCTION__) }];   \
    @throw exception;                                                                                                                                   \
}

extern void LogImageDataF(const char *filename, int lineNumber, const char *functionName, NSString *domain, int level, int width, int height, NSData *data);

#undef assert
#if __DARWIN_UNIX03
#define assert(e)   (__builtin_expect(!(e), 0) ? (CFShow(CFSTR("assert going to fail, connect Logger NOW\n")), LoggerFlush(NULL,YES), __assert_rtn(__func__, __FILE__, __LINE__, #e)) : (void)0)
#else
#define assert(e)   (__builtin_expect(!(e), 0) ? (CFShow(CFSTR("assert going to fail, connect Logger NOW\n")), LoggerFlush(NULL,YES), __assert(#e, __FILE__, __LINE__)) : (void)0)
#endif  // __DARWIN_UNIX03
#endif  // !defined(DEBUG)

#endif  // __DNB_LOGLEVEL__

#define DNB_OBJ_OR_NULL(x)  (x ? x : [NSNull null])

@class DNBDate;

@interface DNBUtilities : NSObject

+ (id<DNBApplicationProtocol>)appDelegate;
+ (DNBUtilities*)sharedInstance;

+ (CGSize)screenSizeUnits;
+ (CGFloat)screenHeightUnits;
+ (CGFloat)screenWidthUnits;
+ (CGSize)screenSize;
+ (CGFloat)screenHeight;
+ (CGFloat)screenWidth;
+ (BOOL)isTall;
+ (BOOL)isDeviceIPad;

+ (NSString*)applicationDocumentsDirectory;

+ (NSString*)appendNibSuffix:(NSString*)nibNameOrNil;
+ (NSString*)appendNibSuffix:(NSString*)nibNameOrNil withDefaultNib:(NSString*)defaultNib;
+ (NSString*)deviceImageName:(NSString*)name;

+ (void)registerCellNib:(NSString*)nibName withCollectionView:(UICollectionView*)collectionView;
+ (void)registerCellNib:(NSString*)nibName withBundle:(NSBundle*)bundle withCollectionView:(UICollectionView*)collectionView;
+ (void)registerCellNib:(NSString*)nibName forSupplementaryViewOfKind:(NSString*)kind withCollectionView:(UICollectionView*)collectionView;
+ (void)registerCellNib:(NSString*)nibName withBundle:(NSBundle*)bundle forSupplementaryViewOfKind:(NSString*)kind withCollectionView:(UICollectionView*)collectionView;

+ (UICollectionViewCell*)registerCellNib:(NSString*)nibName
                      withCollectionView:(UICollectionView*)collectionView
                          withSizingCell:(BOOL)sizingCellFlag;
+ (UICollectionViewCell*)registerCellNib:(NSString*)nibName
                              withBundle:(NSBundle*)bundle
                      withCollectionView:(UICollectionView*)collectionView
                          withSizingCell:(BOOL)sizingCellFlag;
+ (UICollectionViewCell*)registerCellNib:(NSString*)nibName
              forSupplementaryViewOfKind:(NSString*)kind
                      withCollectionView:(UICollectionView*)collectionView
                          withSizingCell:(BOOL)sizingCellFlag;
+ (UICollectionViewCell*)registerCellNib:(NSString*)nibName
                              withBundle:(NSBundle*)bundle
              forSupplementaryViewOfKind:(NSString*)kind
                      withCollectionView:(UICollectionView*)collectionView
                          withSizingCell:(BOOL)sizingCellFlag;

+ (void)registerCellNib:(NSString*)nibName withTableView:(UITableView*)tableView;
+ (void)registerCellNib:(NSString*)nibName withBundle:(NSBundle*)bundle withTableView:(UITableView*)tableView;
+ (void)registerCellClass:(NSString*)className withTableView:(UITableView*)tableView;

+ (void)registerCellNib:(NSString*)nibName forHeaderFooterViewReuseIdentifier:(NSString*)kind withTableView:(UITableView*)tableView;
+ (void)registerCellNib:(NSString*)nibName withBundle:(NSBundle*)bundle forHeaderFooterViewReuseIdentifier:(NSString*)kind withTableView:(UITableView*)tableView;
+ (void)registerCellClass:(NSString*)className forHeaderFooterViewReuseIdentifier:(NSString*)kind withTableView:(UITableView*)tableView;

+ (void)runOnBackgroundThreadAfterDelay:(CGFloat)delay
                                  block:(void (^)())block;

+ (void)runOnMainThreadAsynchronouslyWithoutDeadlocking:(void (^)())block;
+ (void)runOnMainThreadWithoutDeadlocking:(void (^)())block;
+ (void)runOnBackgroundThread:(void (^)())block;
+ (void)runBlock:(void (^)())block;

+ (void)runAfterDelay:(CGFloat)delay block:(void (^)())block;
+ (void)runOnMainThreadAfterDelay:(CGFloat)delay block:(void (^)())block;

+ (void)runRepeatedlyAfterDelay:(CGFloat)delay block:(void (^)(BOOL* stop))block;
+ (void)runOnMainThreadRepeatedlyAfterDelay:(CGFloat)delay block:(void (^)(BOOL* stop))block;

+ (NSTimer*)repeatRunAfterDelay:(CGFloat)delay block:(void (^)())block;
+ (NSTimer*)runTimerAfterDelay:(CGFloat)delay block:(void (^)())block;

+ (void)runGroupOnBackgroundThread:(void (^)(dispatch_group_t group))block
                    withCompletion:(void (^)())completionBlock;

+ (void)runGroupWithTimeout:(dispatch_time_t)timeout
         onBackgroundThread:(void (^)(dispatch_group_t group))block
             withCompletion:(void (^)())completionBlock;

+ (void)enterGroup:(dispatch_group_t)group;
+ (void)leaveGroup:(dispatch_group_t)group;

+ (bool)canDevicePlaceAPhoneCall;

+ (void)playSound:(NSString*)name;
+ (NSString*)encodeWithHMAC_SHA1:(NSString*)data withKey:(NSString*)key;

+ (UIImage*)imageScaledForRetina:(UIImage*)image;

+ (id)settingsItem:(NSString*)item;
+ (id)settingsItem:(NSString*)item default:(id)defaultValue;
+ (BOOL)settingsItem:(NSString*)item boolDefault:(BOOL)defaultValue;
+ (void)setSettingsItem:(NSString*)item value:(id)value;
+ (void)setSettingsItem:(NSString*)item boolValue:(BOOL)value;

+ (NSString *)getIPAddress;

+ (void)updateImage:(UIImageView*)imageView
           newImage:(UIImage*)newImage;

#pragma mark - Dictionary Translation functions

+ (NSNumber*)dictionaryBoolean:(NSDictionary*)dictionary withItem:(NSString*)key andDefault:(NSNumber*)defaultValue;
+ (NSNumber*)dictionaryBoolean:(NSDictionary*)dictionary dirty:(BOOL*)dirtyFlag withItem:(NSString*)key andDefault:(NSNumber*)defaultValue;

+ (NSNumber*)dictionaryNumber:(NSDictionary*)dictionary withItem:(NSString*)key andDefault:(NSNumber*)defaultValue;
+ (NSNumber*)dictionaryNumber:(NSDictionary*)dictionary dirty:(BOOL*)dirtyFlag withItem:(NSString*)key andDefault:(NSNumber*)defaultValue;

+ (NSDecimalNumber*)dictionaryDecimalNumber:(NSDictionary*)dictionary withItem:(NSString*)key andDefault:(NSDecimalNumber*)defaultValue;
+ (NSDecimalNumber*)dictionaryDecimalNumber:(NSDictionary*)dictionary dirty:(BOOL*)dirtyFlag withItem:(NSString*)key andDefault:(NSDecimalNumber*)defaultValue;

+ (NSNumber*)dictionaryDouble:(NSDictionary*)dictionary withItem:(NSString*)key andDefault:(NSNumber*)defaultValue;
+ (NSNumber*)dictionaryDouble:(NSDictionary*)dictionary dirty:(BOOL*)dirtyFlag withItem:(NSString*)key andDefault:(NSNumber*)defaultValue;

+ (NSString*)dictionaryString:(NSDictionary*)dictionary withItem:(NSString*)key andDefault:(NSString*)defaultValue;
+ (NSString*)dictionaryString:(NSDictionary*)dictionary dirty:(BOOL*)dirtyFlag withItem:(NSString*)key andDefault:(NSString*)defaultValue;

+ (NSArray*)dictionaryArray:(NSDictionary*)dictionary withItem:(NSString*)key andDefault:(NSArray*)defaultValue;
+ (NSArray*)dictionaryArray:(NSDictionary*)dictionary dirty:(BOOL*)dirtyFlag withItem:(NSString*)key andDefault:(NSArray*)defaultValue;

+ (NSDictionary*)dictionaryDictionary:(NSDictionary*)dictionary withItem:(NSString*)key andDefault:(NSDictionary*)defaultValue;
+ (NSDictionary*)dictionaryDictionary:(NSDictionary*)dictionary dirty:(BOOL*)dirtyFlag withItem:(NSString*)key andDefault:(NSDictionary*)defaultValue;

+ (NSDate*)dictionaryDate:(NSDictionary*)dictionary withItem:(NSString*)key andDefault:(NSDate*)defaultValue;
+ (NSDate*)dictionaryDate:(NSDictionary*)dictionary dirty:(BOOL*)dirtyFlag withItem:(NSString*)key andDefault:(NSDate*)defaultValue;

+ (DNBDate*)dictionaryDNBDate:(NSDictionary*)dictionary withItem:(NSString*)key andDefault:(DNBDate*)defaultValue;
+ (DNBDate*)dictionaryDNBDate:(NSDictionary*)dictionary dirty:(BOOL*)dirtyFlag withItem:(NSString*)key andDefault:(DNBDate*)defaultValue;

+ (id)dictionaryObject:(NSDictionary*)dictionary withItem:(NSString*)key andDefault:(id)defaultValue;
+ (id)dictionaryObject:(NSDictionary*)dictionary dirty:(BOOL*)dirtyFlag withItem:(NSString*)key andDefault:(id)defaultValue;

- (void)logSetLevel:(DNBLogLevel)level;
- (void)logEnableDomain:(NSString*)domain;
- (void)logEnableDomain:(NSString*)domain forLevel:(DNBLogLevel)level;
- (void)logDisableDomain:(NSString*)domain;
- (void)logDisableDomain:(NSString*)domain forLevel:(DNBLogLevel)level;

@end

CGFloat DNBTimeBlock (void (^block)(void));

void DNBLogMessageF(const char *filename, int lineNumber, const char *functionName, NSString *domain, int level, NSString *format, ...);
