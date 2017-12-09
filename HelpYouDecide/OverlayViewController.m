//
//  OverlayViewController.m
//  HelpYouDecide
//
//  Created by Young Bin Kim on 2017-12-08.
//  Copyright © 2017 YoungBin Kim. All rights reserved.
//

#import "OverlayViewController.h"
#import "DefaultManager.h"

@interface OverlayViewController () <OverlayViewDelegate>

@property (nonatomic, strong) UIWindow *rollButtonWindow;

@end

@implementation OverlayViewController
@dynamic view;

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(decisionInputFinished) name:HelpYouDecideAllDecisionsTyped object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(decisionInputUnfinished) name:HelpYouDecideDecisionsNotTyped object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showOverlay) name:HelpYouDecideDecisionsPageLoaded object:nil];
    [self.view disableRollButton];
    [self.view hideRollButton];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.delegate = self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HelpYouDecideAllDecisionsTyped object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HelpYouDecideDecisionsNotTyped object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:HelpYouDecideDecisionsPageLoaded object:nil];
    [self.view.window setUserInteractionEnabled:NO];
}

- (void)showOverlay {
    [self.view showRollButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)decisionInputFinished {
    [self.view enableRollButton];
    [self.view.window setUserInteractionEnabled:YES];
}

- (void)decisionInputUnfinished {
    [self.view disableRollButton];
}

- (void)didPressRollButton {
    [[NSNotificationCenter defaultCenter] postNotificationName:HelpYouDecideLetsRoll object:nil];
    [self.view hideRollButton];
    [self.view disableRollButton];
    [self.view.window setUserInteractionEnabled:NO];
}

@end
