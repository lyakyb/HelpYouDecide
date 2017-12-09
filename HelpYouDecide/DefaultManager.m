//
//  DefaultManager.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-07.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import "DefaultManager.h"

NSString * const HelpYouDecideAllDecisionsTyped = @"HelpYouDecideAllDecisionsTyped";
NSString * const HelpYouDecideDecisionsNotTyped = @"HelpYouDecideDecisionNotTyped";
NSString * const HelpYouDecideLetsRoll = @"HelpYouDecideLetsRoll";
NSString * const HelpYouDecideDecisionsPageLoaded = @"HelpYouDecideDecisionsPageLoaded";

@interface DefaultManager ()

@property (nonatomic, readwrite) NSArray *decisions;
@property (nonatomic, readwrite) NSString *finalDecision;

@end

@implementation DefaultManager

+ (instancetype)sharedInstance {
    static DefaultManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

- (void)storeDecisionsAndRollFromArray:(NSArray *)decisions {
    NSLog(@"Rolling the dice!");
    self.decisions = decisions;
    
    //Rolling Mechanism. Scale size number of decisions * 25
    static dispatch_once_t onceToken;
    __weak typeof(self) weakSelf = self;
    dispatch_once(&onceToken, ^{
        NSInteger range = (weakSelf.numberOfDecisions * 25) + 1; //Lower bound +1 to elminate 0
        int number = arc4random_uniform(range);
        NSLog(@"Rolled Number: %li", number);
        for (int i = 0; i < weakSelf.numberOfDecisions; i++) {
            NSLog(@"Between %i and %i", (i*25)+1, (i+1)*25);
            if ((i * 25)+1 < number && number <= (i + 1) * 25) {
                weakSelf.finalDecision = [weakSelf.decisions objectAtIndex:i];
                NSLog(@"Final Decision is: %@", weakSelf.finalDecision);
            } else if (i==0) {
                weakSelf.finalDecision = [weakSelf.decisions firstObject];
            }
        }
    });
}

@end
