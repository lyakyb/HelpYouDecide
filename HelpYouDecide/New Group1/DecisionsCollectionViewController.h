//
//  DecisionsCollectionViewController.h
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-06.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    DecisionsCollectionViewSectionDecisions,
    DecisionsCollectionViewSectionFooter,
    DecisionsCollectionViewCount
} DecisionsCollectionViewSection;

@interface DecisionsCollectionViewController : UICollectionViewController

@property (nonatomic, strong) NSMutableArray *decisions;


@end
