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

@property (nonatomic, readwrite) NSMutableArray *decisionsArray;
@property (nonatomic, readwrite) NSString *finalDecision;
@property (nonatomic, assign) BOOL hasRolled;
@property (nonatomic, readwrite) NSMutableArray *duplicates;
@property (nonatomic, assign) NSInteger numDecisions;
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

- (NSArray *)decisions {
    return [self.decisionsArray copy];
}

- (NSUInteger)finalDecisionIndex {
    return [self.decisions indexOfObject:self.finalDecision];
}

- (void)roll {
    if (self.hasRolled) {
        return;
    }
#ifdef DEBUG
    NSLog(@"Rolling the dice!");
#endif
    //Rolling Mechanism. Scale size number of decisions * 25
    NSInteger range = (self.numDecisions * 25) + 1; //Lower bound +1 to elminate 0
    int number = arc4random_uniform(range);
#ifdef DEBUG
    NSLog(@"Rolled Number: %li", number);
#endif
    for (int i = 0; i < self.numDecisions; i++) {
#ifdef DEBUG
        NSLog(@"Between %i and %i", (i*25)+1, (i+1)*25);
#endif
        if ((i * 25)+1 < number && number <= (i + 1) * 25) {
            self.finalDecision = [self.decisionsArray objectAtIndex:i];
#ifdef DEBUG
            NSLog(@"Final Decision is: %@", self.finalDecision);
#endif
        } else if (i==0) {
            self.finalDecision = [self.decisionsArray firstObject];
        }
    }
    
    self.hasRolled = YES;
}

- (void)clearDecisions {
#ifdef DEBUG
    NSLog(@"clearing out decisions");
#endif
    self.finalDecision = nil;
    self.decisionsArray = nil;
    self.numberOfDecisions = 0;
    self.hasRolled = NO;
    self.duplicates = nil;
}

- (BOOL)addDecision:(NSString *)decision {
    if ([self.decisionsArray containsObject:decision]) {
        [self.duplicates addObject:decision];
        return NO;
    }
    
    [self.decisionsArray addObject:decision];
    if (self.decisionsArray.count == self.numDecisions) {
        [[NSNotificationCenter defaultCenter] postNotificationName:HelpYouDecideReadyToRoll object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:HelpYouDecideNotReadyToRoll object:nil];
    }
    
    return YES;
}

- (void)setNumberOfDecisions:(NSInteger)numberOfDecisions {
    self.numDecisions = numberOfDecisions;
    self.decisionsArray = [[NSMutableArray alloc] initWithCapacity:numberOfDecisions];
    self.duplicates = [[NSMutableArray alloc] initWithCapacity:numberOfDecisions/2];
}

- (void)updateWithArray:(NSArray *)array {
    [self.decisionsArray removeAllObjects];
    for (int i=0; i<array.count; i++) {
        [self addDecision:array[i]];
    }
}

- (NSInteger)numberOfDecisions {
    return self.numDecisions;
}


@end
