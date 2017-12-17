
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
#import "SharedConstants.h"

@interface DecisionsCollectionViewController () <UITextFieldDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *decisionCells;
@property (nonatomic, strong) NSMutableDictionary *decisions;
@property (nonatomic, strong) DecisionsFooterView *footerView;
@property (nonatomic, assign) BOOL footerNeedsUpdate;

@end

@implementation DecisionsCollectionViewController

static NSString * const reuseIdentifier = @"DecisionsCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.decisionCells = [NSMutableArray arrayWithCapacity:[DefaultManager sharedInstance].numberOfDecisions];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HelpYouDecideDecisionsPageLoaded object:nil];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DecisionsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //Holding reference to cells for later use
    [self.decisionCells addObject:cell];
    
    return cell;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.decisionCells = nil;
    self.decisions = nil;
}

- (IBAction)saveAllDecisionsAndRoll:(id)sender {
    NSMutableArray *decisions = [NSMutableArray arrayWithCapacity:self.decisionCells.count];
    
    for (DecisionsCollectionViewCell *cell in self.decisionCells) {
        [decisions addObject:cell.decision];
    }
    
    [[DefaultManager sharedInstance] storeDecisionsAndRollFromArray:decisions];
    
    [self performSegueWithIdentifier:@"LetsRollSegue" sender:nil];
#ifdef DEBUG
    NSLog(@"LetsRollSegue Performed");
#endif
}

- (void)decisionUpdatedFromCell {
    BOOL allDecisionsEntered = YES;
    for (DecisionsCollectionViewCell *cell in self.decisionCells) {
        if (!cell.hasInput) {
            allDecisionsEntered = NO;
            break;
        }
    }
    if (allDecisionsEntered) {
        NSLog(@"enabling roll button");
#ifdef DEBUG
        [self.footerView enableRollButton];
#endif
    } else {
#ifdef DEBUG
        NSLog(@"disabling roll button");
#endif
        [self.footerView disableRollButton];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *emptyView;
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        DecisionsFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"DecisionsFooterView" forIndexPath:indexPath];
        self.footerView = footerView;
        
        return footerView;
    }
    
    return emptyView;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self decisionUpdatedFromCell];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
#ifdef DEBUG
    NSLog(@"Text field begun editing");
#endif
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return DecisionsCollectionViewCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return DecisionsCollectionViewSectionDecisions == section ? [[DefaultManager sharedInstance] numberOfDecisions] : 0;
}


#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    if (section == DecisionsCollectionViewSectionFooter) {
        return CGSizeMake(self.collectionView.bounds.size.width, 100.0f);
    }
    
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.bounds.size.width, 75.0f);
}

#pragma mark <UIScrollViewDelegate>

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    UICollectionReusableView *decisionsFooterView = (id)[self.collectionView supplementaryViewForElementKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:DecisionsCollectionViewSectionFooter]];
//
//}

@end
