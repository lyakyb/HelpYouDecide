//
//  DecisionsFooterView.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-07.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import "DecisionsFooterView.h"

@interface DecisionsFooterView ()

@property (nonatomic, weak) IBOutlet UIButton *rollButton;

@end

@implementation DecisionsFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.rollButton.layer.cornerRadius = 30;
    self.rollButton.clipsToBounds = YES;
}

@end
