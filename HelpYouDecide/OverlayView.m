//
//  OverlayView.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-08.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import "OverlayView.h"


@interface OverlayView ()

@property (nonatomic, weak) IBOutlet UIButton *rollButton;

@end

@implementation OverlayView

- (UIColor *)disabledTextColor {
    return [UIColor colorWithRed:170.f/255.f green:170.f/255.f blue:170.f/255.f alpha:1.f];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.rollButton.backgroundColor = [UIColor colorWithRed:125.f/255.f green:125.f/255.f blue:125.f/255.f alpha:1.f];
    [self.rollButton setTitleColor:[self disabledTextColor] forState:UIControlStateNormal];
    self.rollButton.tintColor = [self disabledTextColor];
    self.rollButton.alpha = 0.f;
    self.rollButton.enabled = NO;
    
}

- (void)enableRollButton {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.f animations:^{
            weakSelf.rollButton.backgroundColor = [UIColor colorWithRed:90.f/255.f green:149.f/255.f blue:255.f/255.f alpha:1.f];
            [weakSelf.rollButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        } completion:^(BOOL finished) {
        }];
    });
}

- (void)disableRollButton {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.f animations:^{
            weakSelf.rollButton.backgroundColor = [UIColor colorWithRed:125.f/255.f green:125.f/255.f blue:125.f/255.f alpha:1.f];
            [weakSelf.rollButton setTitleColor:[weakSelf disabledTextColor] forState:UIControlStateNormal];

        } completion:^(BOOL finished) {
        }];
    });
}

- (void)showRollButton {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.f animations:^{
            weakSelf.rollButton.alpha = 1.f;
        } completion:^(BOOL finished) {
            weakSelf.hidden = NO;
            weakSelf.rollButton.enabled = YES;
        }];
    });
}

- (void)hideRollButton {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:1.f animations:^{
            weakSelf.rollButton.alpha = 0.f;
        } completion:^(BOOL finished) {
            weakSelf.hidden = YES;
            weakSelf.rollButton.enabled = NO;
        }];
    });
}

- (IBAction)rollButtonPressed:(id)sender{
    NSLog(@"Roll Button Pressed");
    [self.delegate didPressRollButton];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
