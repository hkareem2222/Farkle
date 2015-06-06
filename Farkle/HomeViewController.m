//
//  ViewController.m
//  Farkle
//
//  Created by Husein Kareem on 6/6/15.
//  Copyright (c) 2015 Husein Kareem. All rights reserved.
//

#import "HomeViewController.h"
#import "DieLabel.h"

@interface HomeViewController () <DieLabelDelegate>
@property (strong, nonatomic) IBOutletCollection(DieLabel) NSArray *dieLabels;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *playerOneScore;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoScore;
@property (weak, nonatomic) IBOutlet UILabel *roundScore;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)dieLabel:(DieLabel *)die {
    die.backgroundColor = [UIColor blackColor];
    die.dieSelected = YES;
    self.button.enabled = YES;
//    [self updateScore];
}

-(void)calculateRoundScore {
    NSNumber *score = 0;
    for (DieLabel *dieLabel in self.dieLabels) {
        if ([dieLabel.text isEqualToString:@"1"]) {
        }
    }
}

- (IBAction)onRollButtonPressed:(UIButton *)sender {
    for (DieLabel *label in self.dieLabels) {
        if (!label.dieSelected) {
            [label rollDie];
        }
    }
    self.button.enabled = NO;
}

@end
