//
//  FinalDecisionView.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-09.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import "FinalDecisionView.h"

@interface FinalDecisionView ()

@property (nonatomic, weak) IBOutlet UILabel *winningDecisionLabel;
@property (nonatomic, weak) IBOutlet UILabel *finalDecisionLabel;
@property (nonatomic, weak) IBOutlet UILabel *retrySuggestionLabel;
@property (nonatomic, weak) IBOutlet UIButton *noButton;
@property (nonatomic, weak) IBOutlet UIButton *yesButton;
@property (nonatomic, weak) IBOutlet UIView *transparentView;

@end

@implementation FinalDecisionView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.finalDecisionLabel setFont:[UIFont fontWithName:@"Chalkboard SE" size:40.f]];
    [self.winningDecisionLabel setAlpha:0.f];
    [self.finalDecisionLabel setAlpha:0.f];
    [self roundAppropriateCorners];
    [self resetRetrySuggestion];
}

- (void)setRetryAlpha:(CGFloat)alpha {
    [self.noButton setAlpha:alpha];
    [self.yesButton setAlpha:alpha];
    [self.retrySuggestionLabel setAlpha:alpha];
    [self.transparentView setAlpha:alpha * 0.9];
}

- (void)unhideRetrySuggestion {
    [self setRetryAlpha:1.f];
}

- (void)roundAppropriateCorners {
    CAShapeLayer *retryMaskLayer = [CAShapeLayer layer];
    retryMaskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.retrySuggestionLabel.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:(CGSize){10.0, 10.0}].CGPath;
    self.retrySuggestionLabel.layer.mask = retryMaskLayer;
    
    CAShapeLayer *noMaskLayer = [CAShapeLayer layer];
    noMaskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.noButton.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:(CGSize){10.0, 10.0}].CGPath;
    self.noButton.layer.mask = noMaskLayer;
    
    CAShapeLayer *yesMaskLayer = [CAShapeLayer layer];
    yesMaskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.yesButton.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:(CGSize){10.0, 10.0}].CGPath;
    self.yesButton.layer.mask = yesMaskLayer;
}

- (void)setFinalDecision:(NSString *)finalDecision {
    self.finalDecisionLabel.text = finalDecision;
}

- (void)showRetrySuggestion {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.f animations:^{
            [weakSelf unhideRetrySuggestion];
        }];
    });
}

- (void)hideRetrySuggestion {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.f animations:^{
            [weakSelf resetRetrySuggestion];
        }];
    });
}

- (void)resetRetrySuggestion {
    [self setRetryAlpha:0.f];
}

- (void)showWinningDecisionLabel {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:4.f animations:^{
            [weakSelf.winningDecisionLabel setAlpha:1.f];
        }];
    });
}

- (void)showFinalDecision {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2.5f animations:^{
            [weakSelf.winningDecisionLabel setAlpha:1.0f];
        } completion:^(BOOL finished) {
            if (finished) {
                
                [UIView animateWithDuration:1.5f animations:^{
                    [weakSelf.finalDecisionLabel setAlpha:1.f];
                    weakSelf.finalDecisionLabel.textColor = [UIColor blueColor];
                } completion:^(BOOL finished) {
                    if (finished) {
                        weakSelf.finalDecisionLabel.textColor = [UIColor blueColor];
                        [weakSelf.delegate decisionAppeared];
                    }
                }];
            }
        }];}
    );
}

- (IBAction)noButtonPressed:(id)sender{
    NSLog(@"No Button Pressed");
    [self.delegate noButtonPressed];
}

- (IBAction)yesButtonPressed:(id)sender{
    NSLog(@"Yes Button Pressed");
    [self.delegate yesButtonPressed];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
