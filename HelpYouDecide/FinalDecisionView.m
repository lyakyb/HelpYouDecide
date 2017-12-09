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

@property (nonatomic, assign) CGFloat initialWidth;
@property (nonatomic, assign) CGFloat initialHeight;

@end

@implementation FinalDecisionView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.finalDecisionLabel setFont:[UIFont fontWithName:@"Chalkboard SE" size:40.f]];
    [self.winningDecisionLabel setAlpha:0.f];
    [self.finalDecisionLabel setAlpha:0.f];
}

- (void)setFinalDecision:(NSString *)finalDecision {
    self.finalDecisionLabel.text = finalDecision;
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
                    }
                }];
            }
        }];}
    );
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
