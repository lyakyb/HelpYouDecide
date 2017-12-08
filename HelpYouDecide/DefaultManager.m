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

- (void)storeDecisionsFromArray:(NSArray *)decisions {
    self.decisions = decisions;
}

@end
