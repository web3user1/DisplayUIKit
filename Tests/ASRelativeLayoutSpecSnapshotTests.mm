//
//  ASRelativeLayoutSpecSnapshotTests.mm
//  AsyncDisplayKit
//
//  Copyright (c) 2014-present, Facebook, Inc.  All rights reserved.
//  This source code is licensed under the BSD-style license found in the
//  LICENSE file in the root directory of this source tree. An additional grant
//  of patent rights can be found in the PATENTS file in the same directory.
//

#import "ASLayoutSpecSnapshotTestsHelper.h"

#import <DisplayUIKit/ASBackgroundLayoutSpec.h>
#import <DisplayUIKit/ASRelativeLayoutSpec.h>
#import <DisplayUIKit/ASStackLayoutSpec.h>

static const ASSizeRange kSize = {{100, 120}, {320, 160}};

@interface ASRelativeLayoutSpecSnapshotTests : ASLayoutSpecSnapshotTestCase
@end

@implementation ASRelativeLayoutSpecSnapshotTests

#pragma mark - XCTestCase

- (void)testWithOptions
{
  [self testAllVerticalPositionsForHorizontalPosition:ASRelativeLayoutSpecPositionStart];
  [self testAllVerticalPositionsForHorizontalPosition:ASRelativeLayoutSpecPositionCenter];
  [self testAllVerticalPositionsForHorizontalPosition:ASRelativeLayoutSpecPositionEnd];

}

- (void)testAllVerticalPositionsForHorizontalPosition:(ASRelativeLayoutSpecPosition)horizontalPosition
{
  [self testWithHorizontalPosition:horizontalPosition verticalPosition:ASRelativeLayoutSpecPositionStart sizingOptions:{}];
  [self testWithHorizontalPosition:horizontalPosition verticalPosition:ASRelativeLayoutSpecPositionCenter sizingOptions:{}];
  [self testWithHorizontalPosition:horizontalPosition verticalPosition:ASRelativeLayoutSpecPositionEnd sizingOptions:{}];
}

- (void)testWithSizingOptions
{
  [self testWithHorizontalPosition:ASRelativeLayoutSpecPositionStart
                  verticalPosition:ASRelativeLayoutSpecPositionStart
                     sizingOptions:ASRelativeLayoutSpecSizingOptionDefault];
  [self testWithHorizontalPosition:ASRelativeLayoutSpecPositionStart
                  verticalPosition:ASRelativeLayoutSpecPositionStart
                     sizingOptions:ASRelativeLayoutSpecSizingOptionMinimumWidth];
  [self testWithHorizontalPosition:ASRelativeLayoutSpecPositionStart
                  verticalPosition:ASRelativeLayoutSpecPositionStart
                     sizingOptions:ASRelativeLayoutSpecSizingOptionMinimumHeight];
  [self testWithHorizontalPosition:ASRelativeLayoutSpecPositionStart
                  verticalPosition:ASRelativeLayoutSpecPositionStart
                     sizingOptions:ASRelativeLayoutSpecSizingOptionMinimumSize];
}

- (void)testWithHorizontalPosition:(ASRelativeLayoutSpecPosition)horizontalPosition
                  verticalPosition:(ASRelativeLayoutSpecPosition)verticalPosition
                   sizingOptions:(ASRelativeLayoutSpecSizingOption)sizingOptions
{
  ASDisplayNode *backgroundNode = ASDisplayNodeWithBackgroundColor([UIColor redColor]);
  ASDisplayNode *foregroundNode = ASDisplayNodeWithBackgroundColor([UIColor greenColor], CGSizeMake(70, 100));

  ASLayoutSpec *layoutSpec =
  [ASBackgroundLayoutSpec
   backgroundLayoutSpecWithChild:
   [ASRelativeLayoutSpec
    relativePositionLayoutSpecWithHorizontalPosition:horizontalPosition
    verticalPosition:verticalPosition
    sizingOption:sizingOptions
    child:foregroundNode]
   background:backgroundNode];

  [self testLayoutSpec:layoutSpec
             sizeRange:kSize
              subnodes:@[backgroundNode, foregroundNode]
            identifier:suffixForPositionOptions(horizontalPosition, verticalPosition, sizingOptions)];
}

static NSString *suffixForPositionOptions(ASRelativeLayoutSpecPosition horizontalPosition,
                                          ASRelativeLayoutSpecPosition verticalPosition,
                                          ASRelativeLayoutSpecSizingOption sizingOptions)
{
  NSMutableString *suffix = [NSMutableString string];

  if (horizontalPosition == ASRelativeLayoutSpecPositionCenter) {
    [suffix appendString:@"CenterX"];
  } else if (horizontalPosition == ASRelativeLayoutSpecPositionEnd) {
    [suffix appendString:@"EndX"];
  }

  if (verticalPosition  == ASRelativeLayoutSpecPositionCenter) {
    [suffix appendString:@"CenterY"];
  } else if (verticalPosition == ASRelativeLayoutSpecPositionEnd) {
    [suffix appendString:@"EndY"];
  }

  if ((sizingOptions & ASRelativeLayoutSpecSizingOptionMinimumWidth) != 0) {
    [suffix appendString:@"SizingMinimumWidth"];
  }

  if ((sizingOptions & ASRelativeLayoutSpecSizingOptionMinimumHeight) != 0) {
    [suffix appendString:@"SizingMinimumHeight"];
  }

  return suffix;
}

- (void)testMinimumSizeRangeIsGivenToChildWhenNotPositioning
{
  ASDisplayNode *backgroundNode = ASDisplayNodeWithBackgroundColor([UIColor redColor]);
  ASDisplayNode *foregroundNode = ASDisplayNodeWithBackgroundColor([UIColor redColor], CGSizeMake(10, 10));
  foregroundNode.style.flexGrow = 1;
  
  ASLayoutSpec *childSpec =
  [ASBackgroundLayoutSpec
   backgroundLayoutSpecWithChild:
   [ASStackLayoutSpec
    stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
    spacing:0
    justifyContent:ASStackLayoutJustifyContentStart
    alignItems:ASStackLayoutAlignItemsStart
    children:@[foregroundNode]]
   background:backgroundNode];
  
  ASRelativeLayoutSpec *layoutSpec =
  [ASRelativeLayoutSpec
   relativePositionLayoutSpecWithHorizontalPosition:ASRelativeLayoutSpecPositionNone
   verticalPosition:ASRelativeLayoutSpecPositionNone
   sizingOption:{}
   child:childSpec];

  [self testLayoutSpec:layoutSpec sizeRange:kSize subnodes:@[backgroundNode, foregroundNode] identifier:nil];
}

@end
