//
//  DecisionsCollectionViewCell.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-07.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import "DecisionsCollectionViewCell.h"

@interface DecisionsCollectionViewCell () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *textField;

@end

@implementation DecisionsCollectionViewCell

- (NSString *)decision {
    return self.textField.text;
}

- (IBAction)textFieldDidEndEditing:(id)sender {
    [self.delegate decisionUpdatedFromCell:self];
    NSLog(@"text length now: %lu", self.textField.text.length);
}

- (void)textFieldDidBeingEditing:(UITextField *)textField {
    
}

- (void)displayKeyboard {
    [self.textField becomeFirstResponder];
}

- (void)hideKeyboard {
    [self.textField resignFirstResponder];
}

- (BOOL)hasInput {
    return self.textField.text.length > 0;
}

@end
