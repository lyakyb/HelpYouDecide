//
//  FinalSingleDecisionView.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 27/01/2019.
//  Copyright © 2019 YoungBin Kim. All rights reserved.
//

#import "FinalSingleDecisionView.h"

@interface FinalSingleDecisionView ()

@property (nonatomic, weak) IBOutlet UILabel *finalDecisionLabel;

@end

@implementation FinalSingleDecisionView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.finalDecisionLabel setText:@""];
}


- (void)setDecisionText:(NSString *)text {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2f animations:^{
        [weakSelf.finalDecisionLabel setAlpha:0.1f];
    } completion:^(BOOL finished) {
        [weakSelf.finalDecisionLabel setText:text];
        [UIView animateWithDuration:0.2f animations:^{
            [weakSelf.finalDecisionLabel setAlpha:1.f];
        }];
    }];
}

- (void)showFinalDecision {
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:self.finalDecisionLabel.frame cornerRadius:30.f];
    borderLayer.strokeColor = [UIColor colorWithRed:7.f/255.f green:249.f/255.f blue:156.f/255.f alpha:1.f].CGColor;
    borderLayer.lineWidth = 2.f;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.path = borderPath.CGPath;
    
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.fromValue = @(0.0);
    drawAnimation.toValue = @(1.0);
    drawAnimation.duration = 2.f;
    
    [borderLayer addAnimation:drawAnimation forKey:@"strokeEnd"];
    
    [self.layer addSublayer:borderLayer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
