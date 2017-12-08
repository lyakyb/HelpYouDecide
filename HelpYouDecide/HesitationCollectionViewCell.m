//
//  HesitationCollectionViewCell.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-06.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import "HesitationCollectionViewCell.h"

@interface HesitationCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *label;

@end

@implementation HesitationCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.label.text = @"";
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.label.text = @"";
}

- (void)setNumberOfDecisions:(NSInteger)numberOfDecisions {
    if (numberOfDecisions == 5) {
        self.label.text = @"6+";
    } else {
        self.label.text = [NSString stringWithFormat:@"%ld", numberOfDecisions +2];
    }
}


@end
