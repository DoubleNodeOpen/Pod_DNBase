//
//  UIView+DNBPending.h
///  DoubleNodeOpen Base
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

@interface UIView (DNBPending)

@property (atomic, assign) float            pendingAlpha;
@property (atomic, assign) CGRect           pendingFrame;
@property (atomic, assign) CATransform3D    pendingTransform;

@property (atomic, assign) CGPoint  origin;
@property (atomic, assign) CGFloat  x;
@property (atomic, assign) CGFloat  y;
@property (atomic, assign) CGSize   size;
@property (atomic, assign) CGFloat  width;
@property (atomic, assign) CGFloat  height;

@property (atomic, assign) CGPoint  pendingOrigin;
@property (atomic, assign) CGFloat  pendingX;
@property (atomic, assign) CGFloat  pendingY;
@property (atomic, assign) CGSize   pendingSize;
@property (atomic, assign) CGFloat  pendingWidth;
@property (atomic, assign) CGFloat  pendingHeight;

/**
 *  Returns if the view is currently loaded and visible.
 */
- (BOOL)isVisible;

/**
 *  Resets pending alpha value to current alpha value.
 */
- (void)resetPendingAlpha;

/**
 *  Resets pending frame value to current frame value.
 */
- (void)resetPendingFrame;

/**
 *  Resets pending transform value to current transform value.
 */
- (void)resetPendingTransform;

/**
 *  Resets pending values to current values.
 */
- (void)resetPendingValues;

/**
 *  Sets current alpha value to pending alpha value.
 */
- (void)applyPendingAlpha;

/**
 *  Sets current frame value to pending frame value.
 */
- (void)applyPendingFrame;

/**
 *  Sets current transform value to pending transform value.
 */
- (void)applyPendingTransform;

/**
 *  Sets current values to pending values.
 */
- (void)applyPendingValues;

@end
