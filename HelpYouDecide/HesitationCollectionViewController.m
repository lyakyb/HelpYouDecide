//
//  HesitationCollectionViewController.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-06.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import "HesitationCollectionViewController.h"
#import "HesitationCollectionViewCell.h"
#import "DefaultManager.h"
#import "FinalDecisionToHesitationCustomUnwindSegue.h"
#import "HesitationCollectionViewHeaderView.h"
#import "LocalizationManager.h"
#import "SharedConstants.h"

@interface HesitationCollectionViewController () <UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) DeviceType deviceType;

@end

static const int NUMBER_OF_ITEMS = 5;
static const NSInteger kIphoneNonPlusWidth = 375;
static const NSInteger kIphonePlusWidth = 414;
static const NSInteger kIpodTouchWidth = 320;
static const NSInteger kTabletWidth = 768;
static NSString * const reuseIdentifier = @"DecisionCell";


@implementation HesitationCollectionViewController

- (void)awakeFromNib {
    [super awakeFromNib];
//    [self.collectionView registerNib:[UINib nibWithNibName:@"NumberOfDecisionsHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"NumberOfDecisionsHeader"];
    
    switch ((NSInteger)[UIScreen mainScreen].bounds.size.width) {
        case kIphoneNonPlusWidth:
            self.deviceType = DeviceTypeRegular;
            break;
        case kIphonePlusWidth:
            self.deviceType = DeviceTypePlus;
            break;
        case kIpodTouchWidth:
            self.deviceType = DeviceTypeTouch;
            break;
        case kTabletWidth:
            self.deviceType = DeviceTypeTablet;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)becomeFirstResponder {
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
#ifdef DEBUG
        NSLog(@"shake detected");
#endif
                
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"HelpYouDecide" message:@"Which language do you prefer?" preferredStyle:UIAlertControllerStyleAlert];
        
        __weak typeof(self) weakSelf = self;
        [alertController addAction:[UIAlertAction actionWithTitle:@"English" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[LocalizationManager sharedInstance] setPreferredLanguage:LocalizationManagerLanguageSettingEnglish];
            [weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];

        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Korean" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[LocalizationManager sharedInstance] setPreferredLanguage:LocalizationManagerLanguageSettingKorean];
            [weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];

    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return HesitationCollectionViewSectionCount;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case HesitationCollectionViewSectionHeader:
            return 0;
            break;
        default:
            return NUMBER_OF_ITEMS;
            break;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HesitationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.numberOfDecisions = !indexPath.item ? 0 : indexPath.item;

//    if (indexPath.item + 1 == NUMBER_OF_ITEMS) {
//        cell.numberOfDecisions = 99;
//        [cell hideLine];
//    }
    
    if (indexPath.item + 1 == NUMBER_OF_ITEMS)
        [cell hideLine];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *emptyView;
    if(indexPath.section == HesitationCollectionViewSectionHeader){
        HesitationCollectionViewHeaderView *reusableView = (id)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"NumberOfDecisionsHeader" forIndexPath:indexPath];
        
        
        [reusableView setFirstLabelTextToString:[[LocalizationManager sharedInstance] stringForPromptKey:HelpYouDecideHesitationFirstPromptKey]];
        [reusableView setSecondLabelTextToString:[[LocalizationManager sharedInstance] stringForPromptKey:HelpYouDecideHesitationSecondPromptKey]];
    
        
        return reusableView;
    }
    return emptyView;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    Control for having more than 5 decision options
//    if (indexPath.item + 1 == NUMBER_OF_ITEMS) {
//        
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"HelpYouDecide" message:@"How many decisions you got?" preferredStyle:UIAlertControllerStyleAlert];
//
//        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//            textField.placeholder = @"6";
//            textField.textColor = [UIColor blackColor];
//            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//            textField.borderStyle = UITextBorderStyleRoundedRect;
//        }];
//
//        __weak typeof(self) weakSelf = self;
//        __block UIAlertController *weakAlertController = alertController;
//        [alertController addAction:[UIAlertAction actionWithTitle:@"Let's go" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//            if (weakAlertController.textFields[0].text.integerValue < NUMBER_OF_ITEMS + 1) {
//                UIAlertController *alertController2 = [UIAlertController alertControllerWithTitle:@"Error!" message:@"You either typed non-number value or a number less than 6! Please try again!" preferredStyle:UIAlertControllerStyleAlert];
//                [alertController2 addAction:[UIAlertAction actionWithTitle:@"Got it!" style:UIAlertActionStyleCancel handler:nil]];
//                [weakSelf presentViewController:alertController2 animated:YES completion:nil];
//            }else{
//                [DefaultManager sharedInstance].numberOfDecisions = [weakAlertController.textFields[0].text integerValue];
//
//                [weakSelf performSegueWithIdentifier:@"HesitationToDecisionsCustomSegue" sender:weakSelf];
//            }
//
//
//        }]];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//#ifdef DEBUG
//            NSLog(@"User cacncelled");
//#endif
//        }]];
//
//        [self presentViewController:alertController animated:YES completion:nil];
//    } else {
//        [DefaultManager sharedInstance].numberOfDecisions = indexPath.item + 2;
//        [self performSegueWithIdentifier:@"HesitationToDecisionsCustomSegue" sender:self];
//    }
    [DefaultManager sharedInstance].numberOfDecisions = indexPath.item + 2;
    [self performSegueWithIdentifier:@"HesitationToDecisionsCustomSegue" sender:self];

#ifdef DEBUG
    NSLog(@"Performing ShowDecisions Segue");
#endif
}


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

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    switch (section) {
        case HesitationCollectionViewSectionHeader:
            return CGSizeMake(self.collectionView.bounds.size.width, 200.0f);
        default:
            return CGSizeZero;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.bounds.size.width, (self.view.bounds.size.height - 200) / 6);
}


- (IBAction)unwindToHesitationViewController:(UIStoryboardSegue*)segue {
}

- (IBAction)returnFromSegueAction:(UIStoryboardSegue *)sender {
    
}

- (UIStoryboardSegue *)segueForUnwindingToViewController:(UIViewController *)toViewController fromViewController:(UIViewController *)fromViewController identifier:(NSString *)identifier {

    if ([identifier isEqualToString:@"FinalDecisionToHesitationUnwindSegue"]) {
        FinalDecisionToHesitationCustomUnwindSegue *customSegue = [[FinalDecisionToHesitationCustomUnwindSegue alloc] initWithIdentifier:identifier source:fromViewController destination:toViewController];
        return customSegue;
    }
    
    return [super segueForUnwindingToViewController:toViewController fromViewController:fromViewController identifier:identifier];

}


@end
