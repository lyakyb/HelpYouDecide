//
//  HesitationToDecisionsCustomSegue.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-17.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import "HesitationToDecisionsCustomSegue.h"

@implementation HesitationToDecisionsCustomSegue

- (void)perform {
    UIView *sourceViewControllerView = self.sourceViewController.view;
    UIView *destinationViewControllerView = self.destinationViewController.view;
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;

    destinationViewControllerView.frame = CGRectMake(0.0, screenHeight, screenWidth, screenHeight);
    
    
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow insertSubview:destinationViewControllerView aboveSubview:sourceViewControllerView];
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.65f animations:^{
        sourceViewControllerView.frame = CGRectOffset(sourceViewControllerView.frame, 0.0, -screenHeight);
        destinationViewControllerView.frame = CGRectOffset(destinationViewControllerView.frame, 0.0, -screenHeight);
    } completion:^(BOOL finished) {
        [weakSelf.sourceViewController presentViewController:self.destinationViewController animated:NO completion:nil];
    }];
    
}

@end
