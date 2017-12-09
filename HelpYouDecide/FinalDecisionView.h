//
//  FinalDecisionView.h
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-09.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinalDecisionView : UIView

@property (nonatomic, strong) NSString *finalDecision;

- (void)showWinningDecisionLabel;
- (void)showFinalDecision;

@end
