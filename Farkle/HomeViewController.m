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
@property int selectedCount;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (DieLabel *die in self.dieLabels) {
        die.delegate = self;
    }
}

-(void)dieLabel:(DieLabel *)die {
    die.backgroundColor = [UIColor blackColor];
    die.dieSelected = YES;
    self.button.enabled = YES;
    [self calculateRoundScore];
}

-(void)calculateRoundScore {
    NSNumber *score = 0;
    for (DieLabel *dieLabel in self.dieLabels) {
        if ([dieLabel.text isEqualToString:@"1"]) {
        }
    }
    [self allSelected];
}

- (IBAction)onRollButtonPressed:(UIButton *)sender {
    for (DieLabel *label in self.dieLabels) {
        if (!label.dieSelected) {
            [label rollDie];
        }
    }
    self.button.enabled = NO;
}

-(void)allSelected {
    self.selectedCount = 0;
    for (DieLabel *label in self.dieLabels) {
        if (label.dieSelected) {
            self.selectedCount = self.selectedCount + 1;
        }
        if (self.selectedCount == 6) {
            for (DieLabel *label in self.dieLabels) {
                label.dieSelected = NO;
                label.backgroundColor = [UIColor redColor];
                [label rollDie];
            }
            self.button.enabled = YES;
        }
    }
}


@end
