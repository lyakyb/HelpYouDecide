//
//  FinalDecisionToHesitationCustomUnwindSegue.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-17.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import "FinalDecisionToHesitationCustomUnwindSegue.h"

@implementation FinalDecisionToHesitationCustomUnwindSegue


- (void)perform {
    UIView *sourceViewControllerView = self.sourceViewController.view;
    UIView *destinationViewControllerView = self.destinationViewController.view;
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow insertSubview:destinationViewControllerView belowSubview:sourceViewControllerView];
    
    destinationViewControllerView.transform = CGAffineTransformScale(destinationViewControllerView.transform, 0.001, 0.001);
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5f animations:^{
        sourceViewControllerView.transform = CGAffineTransformScale(destinationViewControllerView.transform, 0.001, 0.001);
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.5f animations:^{
                destinationViewControllerView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                if (finished) {
                    sourceViewControllerView.transform = CGAffineTransformIdentity;
                }
            }];
        }
    }];
    
}

@end
