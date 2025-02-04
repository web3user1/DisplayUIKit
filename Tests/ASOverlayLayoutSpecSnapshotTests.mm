//
//  ASOverlayLayoutSpecSnapshotTests.mm
//  AsyncDisplayKit
//
//  Copyright (c) 2014-present, Facebook, Inc.  All rights reserved.
//  This source code is licensed under the BSD-style license found in the
//  LICENSE file in the root directory of this source tree. An additional grant
//  of patent rights can be found in the PATENTS file in the same directory.
//

#import "ASLayoutSpecSnapshotTestsHelper.h"

#import <DisplayUIKit/ASOverlayLayoutSpec.h>
#import <DisplayUIKit/ASCenterLayoutSpec.h>

static const ASSizeRange kSize = {{320, 320}, {320, 320}};

@interface ASOverlayLayoutSpecSnapshotTests : ASLayoutSpecSnapshotTestCase
@end

@implementation ASOverlayLayoutSpecSnapshotTests

- (void)testOverlay
{
  ASDisplayNode *backgroundNode = ASDisplayNodeWithBackgroundColor([UIColor blueColor]);
  ASDisplayNode *foregroundNode = ASDisplayNodeWithBackgroundColor([UIColor blackColor], {20, 20});
  
  ASLayoutSpec *layoutSpec =
  [ASOverlayLayoutSpec
   overlayLayoutSpecWithChild:backgroundNode
   overlay:
   [ASCenterLayoutSpec
    centerLayoutSpecWithCenteringOptions:ASCenterLayoutSpecCenteringXY
    sizingOptions:{}
    child:foregroundNode]];
  
  [self testLayoutSpec:layoutSpec sizeRange:kSize subnodes:@[backgroundNode, foregroundNode] identifier: nil];
}

@end
