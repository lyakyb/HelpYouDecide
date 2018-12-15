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
@property (nonatomic, weak) IBOutlet UIView *lineView;

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
    if (numberOfDecisions == 99) {
        self.label.text = @"+";
    } else {
        self.label.text = [NSString stringWithFormat:@"%ld", numberOfDecisions +2];
    }
}

- (void)hideLine {
    self.lineView.hidden = YES;
}


@end
