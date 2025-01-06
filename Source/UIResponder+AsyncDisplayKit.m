//
//  UIResponder+AsyncDisplayKit.m
//  AsyncDisplayKit
//
//  Created by Adlai Holler on 2/13/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import "UIResponder+AsyncDisplayKit.h"

#import <DisplayUIKit/ASAssert.h>
#import <DisplayUIKit/ASBaseDefines.h>
#import <DisplayUIKit/ASResponderChainEnumerator.h>

@implementation UIResponder (AsyncDisplayKit)

- (__kindof UIViewController *)asdk_associatedViewController
{
  ASDisplayNodeAssertMainThread();
  
  for (UIResponder *responder in [self asdk_responderChainEnumerator]) {
    UIViewController *vc = ASDynamicCast(responder, UIViewController);
    if (vc) {
      return vc;
    }
  }
  return nil;
}

@end

