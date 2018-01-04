//
//  LocalizationManager.h
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-17.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum  {
    LocalizationManagerLanguageSettingEnglish,
    LocalizationManagerLanguageSettingKorean,
    LocalizationManagerLanguageSettingCount
} LocalizationManagerLanguageSetting;

@interface LocalizationManager : NSObject

@property (nonatomic, readonly) LocalizationManagerLanguageSetting *preferredLanguage;

+ (instancetype)sharedInstance;
- (NSString *)stringForPromptKey:(NSString *)key;

@end
