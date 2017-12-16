//
//  HelpYouDecideLayout.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-16.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import "HelpYouDecideLayout.h"

@implementation HelpYouDecideLayout

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *layoutAttributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    __block BOOL foundFooter = NO;
    
    [layoutAttributes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([[obj representedElementKind] isEqualToString:UICollectionElementKindSectionFooter]) {
            foundFooter = YES;
        }
    }];
    
    if (!foundFooter) {
        [layoutAttributes addObject:[self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForItem:[layoutAttributes count] inSection:0]]];
    }

    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    
    layoutAttributes.size = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 65.f);
    
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        [self updateFooterAttributes:layoutAttributes];
    }
    
    return layoutAttributes;
}

- (void)updateHeaderAttributes:(UICollectionViewLayoutAttributes *)attributes {
    
}

- (void)updateFooterAttributes:(UICollectionViewLayoutAttributes *)attributes {
    CGRect currentBounds = self.collectionView.bounds;
    attributes.zIndex = 1024;
    attributes.hidden = NO;
    
//    CGFloat yCenterOffset = currentBounds.origin.y + currentBounds.size.height - attributes.size.height/2.0f;
    
    attributes.center = CGPointMake(CGRectGetMidX(currentBounds), [[UIScreen mainScreen] bounds].size.height - currentBounds.size.height);
    
    NSLog(@"Updated footer attributes");
}


@end
