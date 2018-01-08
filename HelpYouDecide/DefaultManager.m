//
//  DefaultManager.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-07.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import "DefaultManager.h"
#import "SharedConstants.h"


@interface DefaultManager ()

@property (nonatomic, readwrite) NSArray *decisions;
@property (nonatomic, readwrite) NSString *finalDecision;
@property (nonatomic, assign) BOOL hasRolled;

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

- (NSUInteger)finalDecisionIndex {
    return [self.decisions indexOfObject:self.finalDecision];
}

- (void)storeDecisionsAndRollFromArray:(NSArray *)decisions {
    if (self.hasRolled) {
        return;
    }
#ifdef DEBUG
    NSLog(@"Rolling the dice!");
#endif
    self.decisions = decisions;
    
    //Rolling Mechanism. Scale size number of decisions * 25
    NSInteger range = (self.numberOfDecisions * 25) + 1; //Lower bound +1 to elminate 0
    int number = arc4random_uniform(range);
#ifdef DEBUG
    NSLog(@"Rolled Number: %li", number);
#endif
    for (int i = 0; i < self.numberOfDecisions; i++) {
#ifdef DEBUG
        NSLog(@"Between %i and %i", (i*25)+1, (i+1)*25);
#endif
        if ((i * 25)+1 < number && number <= (i + 1) * 25) {
            self.finalDecision = [self.decisions objectAtIndex:i];
#ifdef DEBUG
            NSLog(@"Final Decision is: %@", self.finalDecision);
#endif
        } else if (i==0) {
            self.finalDecision = [self.decisions firstObject];
        }
    }
    
    self.hasRolled = YES;
}

- (void)clearDecisions {
#ifdef DEBUG
    NSLog(@"clearing out decisions");
#endif
    self.finalDecision = nil;
    self.decisions = nil;
    self.numberOfDecisions = 0;
}

@end
