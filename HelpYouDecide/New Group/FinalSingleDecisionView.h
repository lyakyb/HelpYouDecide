//
//  FinalSingleDecisionView.h
//  HelpYouDecide
//
//  Created by Young Bin Kim on 27/01/2019.
//  Copyright © 2019 YoungBin Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FinalSingleDecisionViewDelegate

- (void)didFinishSettingText;

@end

@interface FinalSingleDecisionView : UIView

@property (nonatomic, weak) id<FinalSingleDecisionViewDelegate> delegate;

- (void)setDecisionText:(NSString *)text;
- (void)showFinalDecision;

@end

NS_ASSUME_NONNULL_END
