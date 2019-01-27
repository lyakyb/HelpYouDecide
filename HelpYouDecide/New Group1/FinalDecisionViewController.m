//
//  FinalDecisionViewController.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-06.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import "FinalDecisionViewController.h"
#import "DefaultManager.h"
#import "LocalizationManager.h"
#import "SharedConstants.h"
#import "FinalDecisionCollectionView.h"
#import "FinalDecisionCollectionViewCell.h"
#import "DeviceType.h"

@interface FinalDecisionViewController () <FinalDecisionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *retryTimer;
@property (nonatomic, strong) NSTimer *highlightTimer;
@property (nonatomic, weak) IBOutlet FinalDecisionCollectionView *collectionView;
@property (nonatomic, assign) NSUInteger randomNumber;

@end

@implementation FinalDecisionViewController
@dynamic view;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.finalDecision = [[DefaultManager sharedInstance] finalDecision];
    self.view.delegate = self;
    
    [self.view.window makeKeyWindow];
    [self.view.window makeKeyAndVisible];
    
    [self.view setupRetryButton];
    
    [self.view setWinningDecisionTextTo:[[LocalizationManager sharedInstance] stringForPromptKey:HelpYouDecideWinningPromptKey]];
    [self.view setRetryButtonTextTo:[[LocalizationManager sharedInstance] stringForPromptKey:HelpYouDecideRetryPromptKey]];
}

- (void)dealloc {
    [self.timer invalidate];
    [self.retryTimer invalidate];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.view showWinningDecisionLabel];
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer timerWithTimeInterval:4.f repeats:NO block:^(NSTimer * _Nonnull timer) {
        [weakSelf highlightFinalDecision];
        [[weakSelf highlightTimer] invalidate];
#ifdef DEBUG
        NSLog(@"show final decision");
#endif
    }];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    self.highlightTimer = [NSTimer timerWithTimeInterval:0.5f repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf highlightCells];
    }];
    [[NSRunLoop mainRunLoop] addTimer:self.highlightTimer forMode:NSRunLoopCommonModes];
    
    [self.collectionView reloadData];
}

- (void)highlightFinalDecision {
    [self.collectionView.visibleCells enumerateObjectsUsingBlock:^(__kindof UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setBackgroundColor:[UIColor whiteColor]];
    }];
    
    
    [(FinalDecisionCollectionViewCell *)[self.collectionView.visibleCells objectAtIndex:[[DefaultManager sharedInstance] finalDecisionIndex]] finalHighlight];
    
    [self decisionAppeared];
}

- (void)highlightCells {
    int prevNum = self.randomNumber;
    self.randomNumber = arc4random_uniform([[DefaultManager sharedInstance] numberOfDecisions]);
    
    if (self.randomNumber != prevNum) {
        [(FinalDecisionCollectionViewCell *)[self.collectionView.visibleCells objectAtIndex:prevNum] unhighlight];
    }
    
    [(FinalDecisionCollectionViewCell *)[self.collectionView.visibleCells objectAtIndex:self.randomNumber] highlight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)noButtonPressed {
    [self.view hideRetrySuggestion];
}

- (void)retryButtonPressed {
    [[DefaultManager sharedInstance] clearDecisions];
}

- (void)decisionAppeared {
    __weak typeof(self) weakSelf = self;
    self.retryTimer = [NSTimer timerWithTimeInterval:3.f repeats:NO block:^(NSTimer * _Nonnull timer) {
        [weakSelf.view showRetrySuggestion];
#ifdef DEBUG
        NSLog(@"show final decision");
#endif
    }];
    [[NSRunLoop mainRunLoop] addTimer:self.retryTimer forMode:NSRunLoopCommonModes];
}

- (IBAction)showHesitationCollectionViewController:(id)sender {
    [self performSegueWithIdentifier:@"unwind" sender:self];
}

- (void)viewAppeared {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.collectionView appear];
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[DefaultManager sharedInstance] numberOfDecisions];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FinalDecisionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FianlDecisionCollectionViewCell" forIndexPath:indexPath];
    
    cell.decision = [[[DefaultManager sharedInstance] decisions] objectAtIndex:indexPath.item];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height / [[DefaultManager sharedInstance] numberOfDecisions]);
}


@end
