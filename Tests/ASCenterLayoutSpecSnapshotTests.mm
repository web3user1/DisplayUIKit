//
//  ASCenterLayoutSpecSnapshotTests.mm
//  AsyncDisplayKit
//
//  Copyright (c) 2014-present, Facebook, Inc.  All rights reserved.
//  This source code is licensed under the BSD-style license found in the
//  LICENSE file in the root directory of this source tree. An additional grant
//  of patent rights can be found in the PATENTS file in the same directory.
//

#import "ASLayoutSpecSnapshotTestsHelper.h"

#import <DisplayUIKit/ASBackgroundLayoutSpec.h>
#import <DisplayUIKit/ASCenterLayoutSpec.h>
#import <DisplayUIKit/ASStackLayoutSpec.h>

static const ASSizeRange kSize = {{100, 120}, {320, 160}};

@interface ASCenterLayoutSpecSnapshotTests : ASLayoutSpecSnapshotTestCase
@end

@implementation ASCenterLayoutSpecSnapshotTests

- (void)testWithOptions
{
  [self testWithCenteringOptions:ASCenterLayoutSpecCenteringNone sizingOptions:{}];
  [self testWithCenteringOptions:ASCenterLayoutSpecCenteringXY sizingOptions:{}];
  [self testWithCenteringOptions:ASCenterLayoutSpecCenteringX sizingOptions:{}];
  [self testWithCenteringOptions:ASCenterLayoutSpecCenteringY sizingOptions:{}];
}

- (void)testWithSizingOptions
{
  [self testWithCenteringOptions:ASCenterLayoutSpecCenteringNone
                   sizingOptions:ASCenterLayoutSpecSizingOptionDefault];
  [self testWithCenteringOptions:ASCenterLayoutSpecCenteringNone
                   sizingOptions:ASCenterLayoutSpecSizingOptionMinimumX];
  [self testWithCenteringOptions:ASCenterLayoutSpecCenteringNone
                   sizingOptions:ASCenterLayoutSpecSizingOptionMinimumY];
  [self testWithCenteringOptions:ASCenterLayoutSpecCenteringNone
                   sizingOptions:ASCenterLayoutSpecSizingOptionMinimumXY];
}

- (void)testWithCenteringOptions:(ASCenterLayoutSpecCenteringOptions)options
                   sizingOptions:(ASCenterLayoutSpecSizingOptions)sizingOptions
{
  ASDisplayNode *backgroundNode = ASDisplayNodeWithBackgroundColor([UIColor redColor]);
  ASDisplayNode *foregroundNode = ASDisplayNodeWithBackgroundColor([UIColor greenColor], CGSizeMake(70, 100));

  ASLayoutSpec *layoutSpec =
  [ASBackgroundLayoutSpec
   backgroundLayoutSpecWithChild:
   [ASCenterLayoutSpec
    centerLayoutSpecWithCenteringOptions:options
    sizingOptions:sizingOptions
    child:foregroundNode]
   background:backgroundNode];

  [self testLayoutSpec:layoutSpec
             sizeRange:kSize
              subnodes:@[backgroundNode, foregroundNode]
            identifier:suffixForCenteringOptions(options, sizingOptions)];
}

static NSString *suffixForCenteringOptions(ASCenterLayoutSpecCenteringOptions centeringOptions,
                                           ASCenterLayoutSpecSizingOptions sizingOptinos)
{
  NSMutableString *suffix = [NSMutableString string];

  if ((centeringOptions & ASCenterLayoutSpecCenteringX) != 0) {
    [suffix appendString:@"CenteringX"];
  }

  if ((centeringOptions & ASCenterLayoutSpecCenteringY) != 0) {
    [suffix appendString:@"CenteringY"];
  }

  if ((sizingOptinos & ASCenterLayoutSpecSizingOptionMinimumX) != 0) {
    [suffix appendString:@"SizingMinimumX"];
  }

  if ((sizingOptinos & ASCenterLayoutSpecSizingOptionMinimumY) != 0) {
    [suffix appendString:@"SizingMinimumY"];
  }

  return suffix;
}

- (void)testMinimumSizeRangeIsGivenToChildWhenNotCentering
{
  ASDisplayNode *backgroundNode = ASDisplayNodeWithBackgroundColor([UIColor redColor]);
  ASDisplayNode *foregroundNode = ASDisplayNodeWithBackgroundColor([UIColor redColor], CGSizeMake(10, 10));
  foregroundNode.style.flexGrow = 1;
  
  ASCenterLayoutSpec *layoutSpec =
  [ASCenterLayoutSpec
   centerLayoutSpecWithCenteringOptions:ASCenterLayoutSpecCenteringNone
   sizingOptions:{}
   child:
   [ASBackgroundLayoutSpec
    backgroundLayoutSpecWithChild:
    [ASStackLayoutSpec
     stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
     spacing:0
     justifyContent:ASStackLayoutJustifyContentStart
     alignItems:ASStackLayoutAlignItemsStart
     children:@[foregroundNode]]
    background:backgroundNode]];

  [self testLayoutSpec:layoutSpec sizeRange:kSize subnodes:@[backgroundNode, foregroundNode] identifier:nil];
}

@end
