//
//  DecisionsFooterView.h
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-07.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DecisionsFooterView : UICollectionReusableView

- (void)disableRollButton;
- (void)enableRollButton;
- (void)updateButtonTextTo:(NSString *)text;

@end
