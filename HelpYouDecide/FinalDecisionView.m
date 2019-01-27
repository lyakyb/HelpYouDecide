//
//  FinalDecisionView.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-09.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import "FinalDecisionView.h"
#import "DeviceType.h"

@interface FinalDecisionView ()

@property (nonatomic, weak) IBOutlet UILabel *winningDecisionLabel;
@property (nonatomic, weak) IBOutlet UILabel *finalDecisionLabel;
@property (nonatomic, weak) IBOutlet UIButton *retryButton;
@property (nonatomic, weak) IBOutlet UIView *lineView;

@end

const CGFloat kRetryButtonHeight = 100.f;

@implementation FinalDecisionView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.finalDecisionLabel setFont:[UIFont fontWithName:@"Chalkboard SE" size:40.f]];
    [self.winningDecisionLabel setAlpha:0.f];
    [self.lineView setAlpha:0.f];
    [self.finalDecisionLabel setAlpha:0.f];
    [self resetRetrySuggestion];
}

- (void)setupRetryButton {
    CGRect bounds = self.retryButton.bounds;
    CGFloat height = [[UIScreen mainScreen] bounds].size.height * 0.15f;
    if ([[DeviceType deviceModel] containsString:@"X"]) {
        height = height + [[[UIApplication sharedApplication] keyWindow] safeAreaInsets].bottom;
    }
    bounds.size.width = [[UIScreen mainScreen] bounds].size.width;
//    bounds.size.height = height;

    [self.retryButton setFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height + self.retryButton.bounds.size.height, bounds.size.width, height)];
    [self.retryButton setBounds:bounds];
    [self roundAppropriateCorners];
    [self.retryButton setBackgroundColor:[UIColor colorWithRed:255.f/255.f green:86.f/255.f blue:95.f/255.f alpha:1.f]];
}


- (void)setRetryAlpha:(CGFloat)alpha {
    [self.retryButton setAlpha:alpha];
//    [self.transparentView setAlpha:alpha * 0.9];
}

- (void)roundAppropriateCorners {
    CAShapeLayer *retryMaskLayer = [CAShapeLayer layer];
    retryMaskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.retryButton.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:(CGSize){15, 15.0}].CGPath;
    self.retryButton.layer.mask = retryMaskLayer;
}

- (void)setFinalDecision:(NSString *)finalDecision {
    self.finalDecisionLabel.text = finalDecision;
}

- (void)showRetrySuggestion {

    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:2.f animations:^{
//        CGRect offsetRect = CGRectOffset(weakSelf.retryButton.frame, 0.0, weakSelf.retryButton.bounds.size.height);
//        weakSelf.retryButton.frame = CGRectOffset(offsetRect, 0.0, -2*weakSelf.retryButton.bounds.size.height);
        weakSelf.retryButton.frame = CGRectMake(0.0, [[UIScreen mainScreen] bounds].size.height - 1.5f*weakSelf.retryButton.bounds.size.height, weakSelf.retryButton.bounds.size.width, weakSelf.retryButton.bounds.size.height);
        [weakSelf.retryButton setAlpha:1.f];
    } completion:^(BOOL finished) {
        if (finished) {
            [weakSelf.retryButton setEnabled:YES];
        }
    }];
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
    [self.retryButton setAlpha:0.f];
    [self.retryButton setEnabled:NO];
}

- (void)showWinningDecisionLabel {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:4.f animations:^{
            [weakSelf.winningDecisionLabel setAlpha:1.f];
            [weakSelf.lineView setAlpha:1.f];
            [weakSelf.delegate viewAppeared];
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
                    }
                }];
            }
        }];}
    );
}

- (IBAction)yesButtonPressed:(id)sender{
#ifdef DEBUG
    NSLog(@"Yes Button Pressed");
#endif
    [self.delegate retryButtonPressed];
}


- (void)setWinningDecisionTextTo:(NSString *)text {
    self.winningDecisionLabel.text = text;
}

- (void)setRetryButtonTextTo:(NSString *)text {
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:text];
    [self.retryButton setAttributedTitle:string forState:UIControlStateNormal];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
