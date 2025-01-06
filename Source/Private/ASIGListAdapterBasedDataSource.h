//
//  ASIGListAdapterBasedDataSource.h
//  AsyncDisplayKit
//
//  Created by Adlai Holler on 1/19/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <DisplayUIKit/ASAvailability.h>

#if AS_IG_LIST_KIT

#import <IGListKit/IGListKit.h>
#import <DisplayUIKit/ASCollectionView.h>
#import <DisplayUIKit/ASCollectionNode.h>

NS_ASSUME_NONNULL_BEGIN

AS_SUBCLASSING_RESTRICTED
@interface ASIGListAdapterBasedDataSource : NSObject <ASCollectionDataSourceInterop, ASCollectionDelegateInterop, ASCollectionDelegateFlowLayout>

- (instancetype)initWithListAdapter:(IGListAdapter *)listAdapter;

@end

#endif

NS_ASSUME_NONNULL_END
