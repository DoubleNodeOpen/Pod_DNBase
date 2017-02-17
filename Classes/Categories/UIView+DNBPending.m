//
//  UIView+DNBPending.m
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

#include <objc/runtime.h>

#import "UIView+DNBPending.h"

const NSString* kDNBPendingAlpha        = @"DNBPendingAlpha";
const NSString* kDNBPendingFrame        = @"DNBPendingFrame";
const NSString* kDNBPendingTransform    = @"DNBPendingTransform";

@implementation UIView (Pending)

- (BOOL)isVisible
{
    if (self.window)
    {
        return YES;
    }
    if (self.superview)
    {
        return YES;
    }

    return NO;
}

- (CGPoint)origin   {   return self.frame.origin;       }
- (CGFloat)x        {   return self.frame.origin.x;     }
- (CGFloat)y        {   return self.frame.origin.y;     }
- (CGSize)size      {   return self.frame.size;         }
- (CGFloat)width    {   return self.frame.size.width;   }
- (CGFloat)height   {   return self.frame.size.height;  }

- (void)setOrigin:(CGPoint)origin
{
    self.frame   = (CGRect){ origin.x, origin.y, self.frame.size };
}

- (void)setX:(CGFloat)x
{
    self.frame   = (CGRect){ x, self.frame.origin.y, self.frame.size };
}

- (void)setY:(CGFloat)y
{
    self.frame   = (CGRect){ self.frame.origin.x, y, self.frame.size };
}

- (void)setSize:(CGSize)size
{
    self.frame   = (CGRect){ self.frame.origin, size.width, size.height };
}

- (void)setWidth:(CGFloat)width
{
    self.frame   = (CGRect){ self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height };
}

- (void)setHeight:(CGFloat)height
{
    self.frame   = (CGRect){ self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height };
}

- (CGPoint)pendingOrigin    {   return self.pendingFrame.origin;        }
- (CGFloat)pendingX         {   return self.pendingFrame.origin.x;      }
- (CGFloat)pendingY         {   return self.pendingFrame.origin.y;      }
- (CGSize)pendingSize       {   return self.pendingFrame.size;          }
- (CGFloat)pendingWidth     {   return self.pendingFrame.size.width;    }
- (CGFloat)pendingHeight    {   return self.pendingFrame.size.height;   }

- (void)setPendingOrigin:(CGPoint)pendingOrigin
{
    self.pendingFrame   = (CGRect){ pendingOrigin.x, pendingOrigin.y, self.pendingFrame.size };
}

- (void)setPendingX:(CGFloat)pendingX
{
    self.pendingFrame   = (CGRect){ pendingX, self.pendingFrame.origin.y, self.pendingFrame.size };
}

- (void)setPendingY:(CGFloat)pendingY
{
    self.pendingFrame   = (CGRect){ self.pendingFrame.origin.x, pendingY, self.pendingFrame.size };
}

- (void)setPendingSize:(CGSize)pendingSize
{
    self.pendingFrame   = (CGRect){ self.pendingFrame.origin, pendingSize.width, pendingSize.height };
}

- (void)setPendingWidth:(CGFloat)pendingWidth
{
    self.pendingFrame   = (CGRect){ self.pendingFrame.origin.x, self.pendingFrame.origin.y, pendingWidth, self.pendingFrame.size.height };
}

- (void)setPendingHeight:(CGFloat)pendingHeight
{
    self.pendingFrame   = (CGRect){ self.pendingFrame.origin.x, self.pendingFrame.origin.y, self.pendingFrame.size.width, pendingHeight };
}

- (void)setPendingAlpha:(float)pendingAlpha
{
    objc_setAssociatedObject(self, &kDNBPendingAlpha, [NSNumber numberWithFloat:pendingAlpha], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (float)pendingAlpha
{
    return [objc_getAssociatedObject(self, &kDNBPendingAlpha) floatValue];
}

- (void)setPendingFrame:(CGRect)pendingFrame
{
    objc_setAssociatedObject(self, &kDNBPendingFrame, [NSValue valueWithCGRect:pendingFrame], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)pendingFrame
{
    return [objc_getAssociatedObject(self, &kDNBPendingFrame) CGRectValue];
}

- (void)setPendingTransform:(CATransform3D)pendingTransform
{
    objc_setAssociatedObject(self, &kDNBPendingTransform, [NSValue valueWithCATransform3D:pendingTransform], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CATransform3D)pendingTransform
{
    return [objc_getAssociatedObject(self, &kDNBPendingTransform) CATransform3DValue];
}

- (void)resetPendingAlpha
{
    self.pendingAlpha   = self.alpha;
}

- (void)resetPendingFrame
{
    self.pendingFrame   = self.frame;
}

- (void)resetPendingTransform
{
    self.pendingTransform   = self.layer.transform;
}

- (void)resetPendingValues
{
    [self resetPendingAlpha];
    [self resetPendingFrame];
    [self resetPendingTransform];
}

- (void)applyPendingAlpha
{
    if (self.alpha != self.pendingAlpha)
    {
        self.alpha  = self.pendingAlpha;
    }
}

- (void)applyPendingFrame
{
    if (!CGRectEqualToRect(self.frame, self.pendingFrame))
    {
        self.frame  = self.pendingFrame;
    }
}

- (void)applyPendingTransform
{
    if (!CATransform3DEqualToTransform(self.layer.transform, self.pendingTransform))
    {
        self.layer.transform    = self.pendingTransform;
    }
}

- (void)applyPendingValues
{
    [self applyPendingAlpha];
    [self applyPendingFrame];
    [self applyPendingTransform];
}

@end
