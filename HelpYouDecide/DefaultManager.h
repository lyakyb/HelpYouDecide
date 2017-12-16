//
//  DefaultManager.h
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-07.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DefaultManager : NSObject

@property (nonatomic, assign) NSInteger numberOfDecisions;
@property (nonatomic, readonly) NSArray *decisions;
@property (nonatomic, readonly) NSString *finalDecision;

+ (instancetype)sharedInstance;
- (void)storeDecisionsAndRollFromArray:(NSArray *)decisions;
- (void)clearDecisions;

@end
