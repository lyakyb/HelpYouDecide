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
- (void)decisionAppeared;

@end

@interface FinalDecisionView : UIView

@property (nonatomic, strong) NSString *finalDecision;
@property (nonatomic, weak) id<FinalDecisionViewDelegate> delegate;

- (void)showWinningDecisionLabel;
- (void)showFinalDecision;
- (void)showRetrySuggestion;
- (void)hideRetrySuggestion;

@end
