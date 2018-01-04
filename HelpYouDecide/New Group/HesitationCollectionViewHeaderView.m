//
//  HesitationView.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-06.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import "HesitationCollectionViewHeaderView.h"

@interface HesitationCollectionViewHeaderView ()

@property (nonatomic, weak) IBOutlet UILabel *firstLabel;
@property (nonatomic, weak) IBOutlet UILabel *secondLabel;


@end


@implementation HesitationCollectionViewHeaderView


- (void)setFirstLabelTextToString:(NSString *)text {
    self.firstLabel.text = text;
}

- (void)setSecondLabelTextToString:(NSString *)text {
    self.secondLabel.text = text;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

