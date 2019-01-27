
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
#import "LocalizationManager.h"
#import "DeviceType.h"

@interface DecisionsCollectionViewController () <UICollectionViewDelegateFlowLayout, DecisionsCollectionViewCellDelegate>

@property (nonatomic, strong) NSMutableDictionary *decisions;
@property (nonatomic, strong) NSMutableArray *decisionArray;
@property (nonatomic, strong) DecisionsFooterView *footerView;
@property (nonatomic, assign) BOOL footerNeedsUpdate;
@property (nonatomic, assign) NSInteger decisionCounter;
@property (nonatomic, strong) NSString *editingDecision;

@end

@implementation DecisionsCollectionViewController

static NSString * const reuseIdentifier = @"DecisionsCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.decisionCounter = 0;
    
    self.decisionArray = [NSMutableArray arrayWithCapacity:[DefaultManager sharedInstance].numberOfDecisions];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HelpYouDecideDecisionsPageLoaded object:nil];
    
//    [(UICollectionViewFlowLayout*)self.collectionViewLayout setSectionFootersPinToVisibleBounds:YES];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DecisionsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.delegate = self;
    [cell updatePlaceHolderTextTo:[[LocalizationManager sharedInstance] stringForPromptKey:HelpYouDecideInputPromptKey]];
    
    return cell;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.decisions = nil;
}

- (IBAction)saveAllDecisionsAndRoll:(id)sender {
    if (self.editingDecision != nil) {
        [self.decisionArray addObject:self.editingDecision];
    }
    
    [[DefaultManager sharedInstance] storeDecisionsAndRollFromArray:[self.decisionArray copy]];
    
    [self performSegueWithIdentifier:@"LetsRollSegue" sender:nil];
#ifdef DEBUG
    NSLog(@"LetsRollSegue Performed");
#endif
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *emptyView;
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        DecisionsFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"DecisionsFooterView" forIndexPath:indexPath];
        self.footerView = footerView;
        
        [self.footerView updateButtonTextTo:[[LocalizationManager sharedInstance] stringForPromptKey:HelpYouDecideLetsRollPromptKey]];
        
        return footerView;
    }
    
    return emptyView;
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
        
        CGFloat footerHeight = ([[UIScreen mainScreen] bounds].size.height * 0.15f);
        NSString *device = [DeviceType deviceModel];
        
//        if ([device containsString:@"iPhone X"]) {
//            footerHeight = footerHeight + [[[UIApplication sharedApplication] keyWindow] safeAreaInsets].bottom;
//        }
        
        return CGSizeMake(self.collectionView.bounds.size.width, footerHeight);
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

#pragma mark <DecisionsCollectionViewCellDelegate>
- (void)textFieldUpdatingFromValue:(NSString *)text {
    if ([self.decisionArray containsObject:text]) {
        self.editingDecision = text;
        [self.decisionArray removeObject:text];
    }
}

- (void)textFieldUpdatedToValue:(NSString *)text {
    if (text == nil || text.length == 0) {
        self.decisionCounter--;
        [self.footerView disableRollButton];
        return;
    }
    
    [self.decisionArray addObject:text];
    self.editingDecision = nil;
    
    if (self.decisionCounter == [[DefaultManager sharedInstance] numberOfDecisions] - 1) {
        [self.footerView enableRollButton];
    } else {
        self.decisionCounter++;
    }
}

@end
