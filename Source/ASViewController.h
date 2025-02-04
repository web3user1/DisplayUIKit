//
//  ASViewController.h
//  AsyncDisplayKit
//
//  Created by Huy Nguyen on 16/09/15.
//
//  Copyright (c) 2014-present, Facebook, Inc.  All rights reserved.
//  This source code is licensed under the BSD-style license found in the
//  LICENSE file in the root directory of this source tree. An additional grant
//  of patent rights can be found in the PATENTS file in the same directory.
//

#import <UIKit/UIKit.h>
#import <DisplayUIKit/ASDisplayNode.h>
#import <DisplayUIKit/ASVisibilityProtocols.h>

@class ASTraitCollection;

NS_ASSUME_NONNULL_BEGIN

typedef ASTraitCollection * _Nonnull (^ASDisplayTraitsForTraitCollectionBlock)(UITraitCollection *traitCollection);
typedef ASTraitCollection * _Nonnull (^ASDisplayTraitsForTraitWindowSizeBlock)(CGSize windowSize);

/**
 * ASViewController allows you to have a completely node backed hierarchy. It automatically
 * handles @c ASVisibilityDepth, automatic range mode and propogating @c ASDisplayTraits to contained nodes.
 *
 * You can opt-out of node backed hierarchy and use it like a normal UIViewController.
 * More importantly, you can use it as a base class for all of your view controllers among which some use a node hierarchy and some don't.
 * See examples/ASDKgram project for actual implementation.
 */
@interface ASViewController<__covariant DisplayNodeType : ASDisplayNode *> : UIViewController <ASVisibilityDepth>

/**
 * ASViewController initializer.
 *
 * @param node An ASDisplayNode which will provide the root view (self.view)
 * @return An ASViewController instance whose root view will be backed by the provided ASDisplayNode.
 *
 * @see ASVisibilityDepth
 */
- (instancetype)initWithNode:(DisplayNodeType)node;

NS_ASSUME_NONNULL_END

/**
 * @return node Returns the ASDisplayNode which provides the backing view to the view controller.
 */
@property (nonatomic, strong, readonly, null_unspecified) DisplayNodeType node;

NS_ASSUME_NONNULL_BEGIN

/**
 * Set this block to customize the ASDisplayTraits returned when the VC transitions to the given traitCollection.
 */
@property (nonatomic, copy) ASDisplayTraitsForTraitCollectionBlock overrideDisplayTraitsWithTraitCollection;

/**
 * Set this block to customize the ASDisplayTraits returned when the VC transitions to the given window size.
 */
@property (nonatomic, copy) ASDisplayTraitsForTraitWindowSizeBlock overrideDisplayTraitsWithWindowSize;

/**
 * @abstract Passthrough property to the the .interfaceState of the node.
 * @return The current ASInterfaceState of the node, indicating whether it is visible and other situational properties.
 * @see ASInterfaceState
 */
@property (nonatomic, readonly) ASInterfaceState interfaceState;


// AsyncDisplayKit 2.0 BETA: This property is still being tested, but it allows
// blocking as a view controller becomes visible to ensure no placeholders flash onscreen.
// Refer to examples/SynchronousConcurrency, AsyncViewController.m
@property (nonatomic, assign) BOOL neverShowPlaceholders;

@end

@interface ASViewController (ASRangeControllerUpdateRangeProtocol)

/**
 * Automatically adjust range mode based on view events. If you set this to YES, the view controller or its node
 * must conform to the ASRangeControllerUpdateRangeProtocol. 
 *
 * Default value is YES *if* node or view controller conform to ASRangeControllerUpdateRangeProtocol otherwise it is NO.
 */
@property (nonatomic, assign) BOOL automaticallyAdjustRangeModeBasedOnViewEvents;

@end

@interface ASViewController (Deprecated)

/**
 * The constrained size used to measure the backing node.
 *
 * @discussion Defaults to providing a size range that uses the view controller view's bounds as
 * both the min and max definitions. Override this method to provide a custom size range to the
 * backing node.
 */
- (ASSizeRange)nodeConstrainedSize AS_WARN_UNUSED_RESULT ASDISPLAYNODE_DEPRECATED_MSG("Set the size directly to the view's frame");

@end

NS_ASSUME_NONNULL_END
