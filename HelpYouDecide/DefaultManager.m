//
//  DefaultManager.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-07.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import "DefaultManager.h"

@implementation DefaultManager

+ (instancetype)sharedInstance {
    static DefaultManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}

@end
