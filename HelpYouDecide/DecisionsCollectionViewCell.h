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

- (void)textFieldUpdatedToValue:(NSString*)text sender:(DecisionsCollectionViewCell *)sender;
- (void)textFieldUpdatingFromValue:(NSString*)text sender:(DecisionsCollectionViewCell *)sender;

@end

@interface DecisionsCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<DecisionsCollectionViewCellDelegate> delegate;
@property (nonatomic, strong) NSString *decision;

- (void)updatePlaceHolderTextTo:(NSString *)text;
- (BOOL)hasInput;
- (void)displayKeyboard;
- (void)hideKeyboard;
- (void)enableWarning;
- (void)disableWarning;

@end

