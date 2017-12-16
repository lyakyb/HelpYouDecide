//
//  DecisionsFooterView.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-07.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import "DecisionsFooterView.h"

@interface DecisionsFooterView ()

@property (nonatomic, weak) IBOutlet UIButton *rollButton;

@end

@implementation DecisionsFooterView

- (UIColor *)disabledTextColor {
    return [UIColor colorWithRed:170.f/255.f green:170.f/255.f blue:170.f/255.f alpha:1.f];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    CAShapeLayer *rollButtonLayer = [CAShapeLayer layer];
    rollButtonLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.rollButton.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:(CGSize){10.0, 10.0}].CGPath;
    self.rollButton.layer.mask = rollButtonLayer;

    [self.rollButton setTitleColor:[self disabledTextColor] forState:UIControlStateNormal];
    self.rollButton.tintColor = [self disabledTextColor];
    
    [self disableRollButton];    
}

- (void)disableRollButton {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.f animations:^{
            weakSelf.rollButton.backgroundColor = [UIColor colorWithRed:125.f/255.f green:125.f/255.f blue:125.f/255.f alpha:1.f];
            [weakSelf.rollButton setTitleColor:[weakSelf disabledTextColor]
                                      forState:UIControlStateNormal];            
        } completion:^(BOOL finished) {
            [weakSelf.rollButton setUserInteractionEnabled:NO];
        }];
    });
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGPoint fixedLocation = CGPointMake(0.0, [[UIScreen mainScreen] bounds].size.height-self.bounds.size.height);
    CGSize size = self.frame.size;
    
    self.frame = CGRectMake(fixedLocation.x, fixedLocation.y, size.width, size.height);
}

- (void)enableRollButton {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.f animations:^{
            weakSelf.rollButton.backgroundColor = [UIColor colorWithRed:90.f/255.f green:149.f/255.f blue:255.f/255.f alpha:1.f];
            [weakSelf.rollButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        } completion:^(BOOL finished) {
            [weakSelf.rollButton setUserInteractionEnabled:YES];
#ifdef DEBUG
            NSLog(@"user interaction enabled to YES");
#endif
        }];
    });
}

@end
