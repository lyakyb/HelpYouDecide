//
//  FinalDecisionCollectionViewCell.h
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2018-01-06.
//  Copyright © 2018 YoungBin Kim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinalDecisionCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) NSString *decision;

- (void)highlight;
- (void)unhighlight;

@end
