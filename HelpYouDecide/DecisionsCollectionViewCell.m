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

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textField.delegate = self;
    
}

- (void)updatePlaceHolderTextTo:(NSString *)text {
    self.textField.placeholder = text;
}

- (NSString *)decision {
    return self.textField.text;
}

- (void)displayKeyboard {
    [self.textField becomeFirstResponder];
}

- (void)hideKeyboard {
    [self.textField resignFirstResponder];
}

- (void)enableWarning {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.textField setTintColor:[UIColor redColor]];
        [weakSelf.textField setTextColor:[UIColor redColor]];
    });
}

- (void)disableWarning {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.textField setTintColor:[UIColor blackColor]];
        [weakSelf.textField setTextColor:[UIColor blackColor]];
    });
}

- (BOOL)hasInput {
#ifdef DEBUG
    NSLog(@"text : %@", self.textField.text);
#endif
    return self.textField.text.length > 0;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.delegate textFieldUpdatingFromValue:textField.text sender:self];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.delegate textFieldUpdatedToValue:textField.text sender:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField resignFirstResponder];
    return YES;
}

@end
