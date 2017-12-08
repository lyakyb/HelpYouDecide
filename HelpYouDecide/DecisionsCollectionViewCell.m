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
    self.backgroundColor = [UIColor blueColor];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.backgroundColor = [UIColor blueColor];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}
- (IBAction)textFieldDIdEndEditing:(id)sender {
    NSLog(@"did end editing");
}

- (void)textFieldDidBeingEditing:(UITextField *)textField {
    
}

- (void)displayKeyboard {
    [self.textField becomeFirstResponder];
}

- (void)hideKeyboard {
    [self.textField resignFirstResponder];
}


@end
