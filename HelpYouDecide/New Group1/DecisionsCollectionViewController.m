
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

@interface DecisionsCollectionViewController () <UITextFieldDelegate, UICollectionViewDelegateFlowLayout, DecisionsCollectionViewCellDelegate>

@property (nonatomic, strong) NSMutableArray *decisionCells;
@property (nonatomic, strong) NSMutableDictionary *decisions;

@end

@implementation DecisionsCollectionViewController

static NSString * const reuseIdentifier = @"DecisionsCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.decisionCells = [NSMutableArray arrayWithCapacity:[DefaultManager sharedInstance].numberOfDecisions];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveAllDecisionsAndRoll) name:HelpYouDecideLetsRoll object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:HelpYouDecideDecisionsPageLoaded object:nil];
    
    NSLog(@"HelpYouDecideDecisionsPageLoaded Posted");
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HelpYouDecideLetsRoll object:nil];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DecisionsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //Holding reference to cells for later use
    [self.decisionCells addObject:cell];
    cell.delegate = self;
    
    return cell;
}

- (void)saveAllDecisionsAndRoll {
    NSMutableArray *decisions = [NSMutableArray arrayWithCapacity:self.decisionCells.count];
    
    for (DecisionsCollectionViewCell *cell in self.decisionCells) {
        [decisions addObject:cell.decision];
    }
    
    [[DefaultManager sharedInstance] storeDecisionsFromArray:decisions];
    [self performSegueWithIdentifier:@"LetsRollSegue" sender:nil];
}

- (void)decisionUpdatedFromCell:(DecisionsCollectionViewCell *)cell {
//    NSString *index = [NSString stringWithFormat:@"%lu", (unsigned long)[self.decisionCells indexOfObject:cell]];
//    
//    [self.decisions setObject:[NSNumber numberWithBool:[cell hasInput]] forKey:index];
    BOOL allDecisionsEntered = YES;
    for (DecisionsCollectionViewCell *cell in self.decisionCells) {
        if (!cell.hasInput) {
            allDecisionsEntered = NO;
        }
    }
    
    if (allDecisionsEntered) {
        [[NSNotificationCenter defaultCenter] postNotificationName:HelpYouDecideAllDecisionsTyped object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:HelpYouDecideDecisionsNotTyped object:nil];
    }
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


#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.bounds.size.width, 75.0f);
}

#pragma mark <UIScrollViewDelegate>

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    UICollectionReusableView *decisionsFooterView = (id)[self.collectionView supplementaryViewForElementKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:DecisionsCollectionViewSectionFooter]];
//
//}

@end
