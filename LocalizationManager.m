//
//  LocalizationManager.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-17.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import "LocalizationManager.h"
#import "SharedConstants.h"

@interface LocalizationManager ()

@property (nonatomic, readwrite, assign) LocalizationManagerLanguageSetting *preferredLanguage;

@end

@implementation LocalizationManager

static NSDictionary * LocalizationManagerKoreanDicionary;
static NSDictionary * LocalizationManagerEnglishDictionary;

+ (instancetype)sharedInstance {
    static LocalizationManager *sharedInstance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
        sharedInstance.preferredLanguage = LocalizationManagerLanguageSettingKorean;
        
        LocalizationManagerKoreanDicionary = @{HelpYouDecideInputPromptKey:@"옵션을 적어줘!",
                                               HelpYouDecideWinningPromptKey:@"운명의 선택은...",
                                               HelpYouDecideRetryPromptKey:@"결정장애가 또....",
                                               HelpYouDecideHesitationFirstPromptKey:@"몇가지 결정이",
                                               HelpYouDecideHesitationSecondPromptKey:@"당신을 괴롭히나요?",
                                               HelpYouDecideLetsRollPromptKey:@"골라줘!",
                                               };
    
        
        LocalizationManagerEnglishDictionary = @{HelpYouDecideInputPromptKey:@"Input your option",
                                                HelpYouDecideWinningPromptKey:@"Winning Decision is",
                                                HelpYouDecideRetryPromptKey:@"Retry?",
                                                HelpYouDecideHesitationFirstPromptKey:@"How Many Options",
                                                 HelpYouDecideHesitationSecondPromptKey:@"Are You Considering?",
                                                HelpYouDecideLetsRollPromptKey:@"Let's Roll!",
                                                };
    });
    
    return sharedInstance;
}

- (NSString *)stringForPromptKey:(NSString *)key {
    if (self.preferredLanguage == LocalizationManagerLanguageSettingKorean) {
        return [LocalizationManagerKoreanDicionary objectForKey:key];
    } else if (self.preferredLanguage == LocalizationManagerLanguageSettingEnglish) {
        return [LocalizationManagerEnglishDictionary objectForKey:key];
    }
    
    return nil;
}





@end
