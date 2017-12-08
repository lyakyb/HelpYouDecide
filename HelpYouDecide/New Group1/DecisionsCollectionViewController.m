//
//  DecisionsCollectionViewController.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-06.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import "DecisionsCollectionViewController.h"
#import "DecisionsFooterView.h"
#import "DecisionsCollectionView.h"
#import "DefaultManager.h"
#import "DecisionsCollectionViewCell.h"

@interface DecisionsCollectionViewController () <UICollectionViewDelegateFlowLayout>

@end

@implementation DecisionsCollectionViewController

static NSString * const reuseIdentifier = @"DecisionsCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.decisions = [NSMutableArray arrayWithCapacity:[DefaultManager sharedInstance].numberOfDecisions];
    
    NSLog(@"DecisionsCollectionVC ViewDidLoad");
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DecisionsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

//#pragma mark - UITextFieldDelegate
//
//- (void)textFieldDidEndEditing:(UITextField *)textField {
//}
//
//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    NSLog(@"Text field begun editing");
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField endEditing:YES];
//    return YES;
//}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return DecisionsCollectionViewCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return DecisionsCollectionViewSectionDecisions == section ? [[DefaultManager sharedInstance] numberOfDecisions] : 0;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *emptyView = [UICollectionReusableView new];
    NSLog(@"Number of Decisions: %ld", [[DefaultManager sharedInstance] numberOfDecisions]);
    if(indexPath.section == DecisionsCollectionViewSectionFooter){
        DecisionsFooterView *reusableView = (id)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"DecisionsFooter" forIndexPath:indexPath];
        return reusableView;
    }
    
    return emptyView;
}


#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    switch (section) {
        case DecisionsCollectionViewSectionFooter:
            return CGSizeMake(self.collectionView.bounds.size.width, 125.0f);
        case DecisionsCollectionViewSectionDecisions:
            if (self.decisions.count) {
                return CGSizeMake(self.collectionView.bounds.size.width, 75.f);
            }
        default:
            return CGSizeZero;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.bounds.size.width, 75.0f);
}

#pragma mark <UIScrollViewDelegate>

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    UICollectionReusableView *decisionsFooterView = (id)[self.collectionView supplementaryViewForElementKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:DecisionsCollectionViewSectionFooter]];
//}

@end
