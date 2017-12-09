//
//  DecisionsCollectionViewCell.h
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-07.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DecisionsCollectionViewCell;
@protocol DecisionsCollectionViewCellDelegate

- (void)decisionUpdatedFromCell:(DecisionsCollectionViewCell *)cell;

@end

@interface DecisionsCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSString *decision;
@property (nonatomic, weak) id<DecisionsCollectionViewCellDelegate> delegate;

- (BOOL)hasInput;
- (void)displayKeyboard;
- (void)hideKeyboard;

@end
