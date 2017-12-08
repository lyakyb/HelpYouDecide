//
//  OverlayView.h
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-08.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OverlayViewDelegate

- (void)didPressRollButton;

@end

@interface OverlayView : UIView

@property (nonatomic, weak) id<OverlayViewDelegate> delegate;

- (void)enableRollButton;
- (void)disableRollButton;
- (void)hideRollButton;
- (void)showRollButton;

@end
