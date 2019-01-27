//
//  FadeOutSegue.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 27/01/2019.
//  Copyright © 2019 YoungBin Kim. All rights reserved.
//

#import "FadeOutSegue.h"

@implementation FadeOutSegue

- (void) perform {
    UIView *sourceViewControllerView = self.sourceViewController.view;
    UIView *destinationViewControllerView = self.destinationViewController.view;

    destinationViewControllerView.alpha = 0.0;
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow insertSubview:destinationViewControllerView aboveSubview:sourceViewControllerView];
    
    [UIView animateWithDuration:1.0f animations:^{
        sourceViewControllerView.alpha = 0.f;
        destinationViewControllerView.alpha = 1.f;
    } completion:^(BOOL finished) {
        [self.sourceViewController presentViewController:self.destinationViewController animated:NO completion:nil];
    }];

}





@end
