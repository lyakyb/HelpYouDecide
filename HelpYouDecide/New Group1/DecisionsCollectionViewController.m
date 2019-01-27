
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

@property (nonatomic, strong) NSMutableArray *decisionCells;
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
    
    self.decisionCells = [NSMutableArray arrayWithCapacity:[[DefaultManager sharedInstance] numberOfDecisions]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HelpYouDecideDecisionsPageLoaded object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(managerReadyToRoll) name:HelpYouDecideReadyToRoll object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(managerNotReadyToRoll) name:HelpYouDecideNotReadyToRoll object:nil];

//    [(UICollectionViewFlowLayout*)self.collectionViewLayout setSectionFootersPinToVisibleBounds:YES];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DecisionsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.delegate = self;
    [cell updatePlaceHolderTextTo:[[LocalizationManager sharedInstance] stringForPromptKey:HelpYouDecideInputPromptKey]];
    [self.decisionCells addObject:cell];
    return cell;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    self.decisionCells = nil;
}

- (void)managerReadyToRoll {
    [self.footerView enableRollButton];
}

- (void)managerNotReadyToRoll {
    [self.footerView disableRollButton];
}

- (IBAction)saveAllDecisionsAndRoll:(id)sender {
    if (self.editingDecision != nil) {
    }
    
    [[DefaultManager sharedInstance] roll];
    
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
        
        if ([device containsString:@"iPhone X"]) {
            footerHeight = footerHeight + [[[UIApplication sharedApplication] keyWindow] safeAreaInsets].bottom / 2;
        }
        
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
- (void)textFieldUpdatingFromValue:(NSString *)text sender:(DecisionsCollectionViewCell *)sender{
    self.editingDecision = text;
    [sender disableWarning];
}

- (void)textFieldUpdatedToValue:(NSString *)text sender:(DecisionsCollectionViewCell *)sender{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:[DefaultManager sharedInstance].numberOfDecisions];
    
    [self.decisionCells enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __block NSString *decision = [((DecisionsCollectionViewCell *)obj) decision];
        
        if (dict[decision] == nil && [decision length] != 0) {
            [dict setObject:[NSMutableArray arrayWithObject:[NSNumber numberWithUnsignedInteger:idx]] forKey:decision];
            [arr addObject:decision];
        } else {
            [((NSMutableArray*)[dict objectForKey:decision]) addObject:[NSNumber numberWithUnsignedInteger:idx]];
        }
    }];
    
    __weak typeof(self) weakSelf = self;
    
    for (int i=0; i<dict.allKeys.count; i++) {
        NSArray *cells = [dict objectForKey:arr[i]];
        if (cells.count > 1) {
            [cells enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [((DecisionsCollectionViewCell *)weakSelf.decisionCells[[obj integerValue]]) enableWarning];
            }];
        } else {
            [((DecisionsCollectionViewCell *)[weakSelf.decisionCells objectAtIndex:[cells[0] integerValue]]) disableWarning];
        }
    }
    
    [[DefaultManager sharedInstance] updateWithArray:arr];
    
//    NSMutableDictionary *currVals = [NSMutableDictionary new];
//    NSMutableArray *dupArr = [[NSMutableArray alloc] initWithCapacity:[DefaultManager sharedInstance].numberOfDecisions];
//    __weak typeof(self) weakSelf = self;
//    [self.decisionCells enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        DecisionsCollectionViewCell *cell = (DecisionsCollectionViewCell *)obj;
//        if (currVals[text] == nil) {
//            [currVals setObject:[NSMutableArray arrayWithObject:[NSNumber numberWithUnsignedInteger:idx]] forKey:cell.decision];
//        } else {
//            [((NSMutableArray*)[currVals objectForKey:cell.decision]) addObject:[NSNumber numberWithUnsignedInteger:idx]];
//        }
//        if (![dupArr containsObject:cell.decision] && [cell.decision isEqualToString:@""]) {
//            [dupArr addObject:cell.decision];
//        }
//    }];
//
//    for (int i=0; i<currVals.allKeys.count; i++) {
//        NSArray *cells = [currVals objectForKey:dupArr[i]];
//        if (cells.count > 1) {
//            [cells enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [((DecisionsCollectionViewCell *)weakSelf.decisionCells[[obj integerValue]]) enableWarning];
//            }];
//        } else {
//            [((DecisionsCollectionViewCell *)[weakSelf.decisionCells objectAtIndex:[cells[0] integerValue]]) disableWarning];
//        }
//    }
//
//    [[DefaultManager sharedInstance] updateFromArray:dupArr];
}

@end
