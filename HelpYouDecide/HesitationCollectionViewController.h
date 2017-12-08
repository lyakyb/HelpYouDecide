//
//  HesitationCollectionViewController.h
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-06.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DeviceTypeRegular,
    DeviceTypePlus,
    DeviceTypeTouch,
    DeviceTypeTablet
} DeviceType;

typedef enum {
    HesitationCollectionViewSectionHeader,
    HesitationCollectionViewSectionSelections,
    HesitationCollectionViewSectionCount,
} HesitationCollectionViewSection;

@class HesitationCollectionViewController;

@protocol HesitationCollectionViewControllerDelegate

- (void)HesistationCollectionViewController:(HesitationCollectionViewController *)hesitationCollectionViewController didSelectNumberOfDecisions:numberOfDecisions;

@end

@interface HesitationCollectionViewController : UICollectionViewController

@end
