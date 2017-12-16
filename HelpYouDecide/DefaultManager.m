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

- (void)storeDecisionsAndRollFromArray:(NSArray *)decisions {
    if (self.hasRolled) {
        return;
    }
    
    NSLog(@"Rolling the dice!");
    self.decisions = decisions;
    
    //Rolling Mechanism. Scale size number of decisions * 25
    NSInteger range = (self.numberOfDecisions * 25) + 1; //Lower bound +1 to elminate 0
    int number = arc4random_uniform(range);
    NSLog(@"Rolled Number: %li", number);
    for (int i = 0; i < self.numberOfDecisions; i++) {
        NSLog(@"Between %i and %i", (i*25)+1, (i+1)*25);
        if ((i * 25)+1 < number && number <= (i + 1) * 25) {
            self.finalDecision = [self.decisions objectAtIndex:i];
            NSLog(@"Final Decision is: %@", self.finalDecision);
        } else if (i==0) {
            self.finalDecision = [self.decisions firstObject];
        }
    }
    
    self.hasRolled = YES;
}

- (void)clearDecisions {
    self.decisions = nil;
}

@end
