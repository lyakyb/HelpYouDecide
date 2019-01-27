//
//  FinalDecisionView.h
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-09.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FinalDecisionViewDelegate

- (void)noButtonPressed;
- (void)retryButtonPressed;
- (void)viewAppeared;

@end

@interface FinalDecisionView : UIView

@property (nonatomic, strong) NSString *finalDecision;
@property (nonatomic, weak) id<FinalDecisionViewDelegate> delegate;

- (void)showWinningDecisionLabel;
//deprecated
- (void)showFinalDecision;
- (void)showRetrySuggestion;
- (void)hideRetrySuggestion;
- (void)setWinningDecisionTextTo:(NSString *)text;
- (void)setRetryButtonTextTo:(NSString *)text;
- (void)setupRetryButton;

@end
