//
//  FinalDecisionCollectionView.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2018-01-06.
//  Copyright © 2018 YoungBin Kim. All rights reserved.
//

#import "FinalDecisionCollectionView.h"

@implementation FinalDecisionCollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    [super awakeFromNib];
    [self disappear];
}

- (void)appear {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5f animations:^{
        weakSelf.alpha = 1.f;
    }];
}

- (void)disappear {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5f animations:^{
        weakSelf.alpha = 0.f;
    }];
}


@end
