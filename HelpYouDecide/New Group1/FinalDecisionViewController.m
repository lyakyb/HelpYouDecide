//
//  FinalDecisionViewController.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-06.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import "FinalDecisionViewController.h"
#import "DefaultManager.h"

@interface FinalDecisionViewController () <FinalDecisionViewDelegate>

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *retryTimer;

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
        [weakSelf.view showFinalDecision];
        NSLog(@"show final decision");
    }];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)noButtonPressed {
    [self.view hideRetrySuggestion];
}

- (void)yesButtonPressed {
}

- (void)decisionAppeared {
    __weak typeof(self) weakSelf = self;
    self.retryTimer = [NSTimer timerWithTimeInterval:3.f repeats:NO block:^(NSTimer * _Nonnull timer) {
        [weakSelf.view showRetrySuggestion];
        NSLog(@"show final decision");
    }];
    [[NSRunLoop mainRunLoop] addTimer:self.retryTimer forMode:NSRunLoopCommonModes];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
