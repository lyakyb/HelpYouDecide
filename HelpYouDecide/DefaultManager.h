//
//  DefaultManager.h
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-07.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DefaultManager : NSObject

@property (nonatomic, readonly) NSArray *decisions;
@property (nonatomic, readonly) NSString *finalDecision;
@property (nonatomic, readonly) NSUInteger finalDecisionIndex;

+ (instancetype)sharedInstance;
- (void)clearDecisions;
- (void)roll;
- (BOOL)addDecision:(NSString *)decision;
- (NSArray *)duplicateValues;
- (void)setNumberOfDecisions:(NSInteger)numberOfDecisions;
- (NSInteger)numberOfDecisions;
- (void)updateWithArray:(NSArray *)array;

@end
