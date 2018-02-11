//
//  FinalDecisionCollectionViewCell.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2018-01-06.
//  Copyright © 2018 YoungBin Kim. All rights reserved.
//

#import "FinalDecisionCollectionViewCell.h"

@interface FinalDecisionCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *decisionLabel;

@end

@implementation FinalDecisionCollectionViewCell

- (void)setDecision:(NSString *)decision {
    self.decisionLabel.text = decision;
}

- (void)highlight {
    [self highlightForFinal:NO];
}

- (void)highlightForFinal:(BOOL)isFinal {
    UIColor *flashingColor = [UIColor new];
    
    if (isFinal) {
        flashingColor = [UIColor colorWithRed:139.f/255.f green:252.f/255.f blue:133.f/255.f alpha:1.f];
    } else {
        flashingColor = [UIColor colorWithRed:125.f/255.f green:200.f/255.f blue:200.f/255.f alpha:1.f];
    }
    
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.5f animations:^{
        weakSelf.backgroundColor = flashingColor;
    }];
}

- (void)finalHighlight {
    [self highlightForFinal:YES];
}

- (void)unhighlight {
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.5f animations:^{
        weakSelf.backgroundColor = [UIColor whiteColor];
    }];
}

@end
