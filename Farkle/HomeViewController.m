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
@property NSMutableArray *selectedDice;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedDice = [NSMutableArray new];

    for (DieLabel *die in self.dieLabels) {
        die.delegate = self;
    }
}

-(void)dieLabel:(DieLabel *)die {
    die.backgroundColor = [UIColor blackColor];
    die.dieSelected = YES;
    self.button.enabled = YES;
    [self allSelected];
    [self.selectedDice addObject:die];
}

-(void)calculateSpecialScore {
    NSInteger score = 0;
    NSInteger occurrencesOne = 0;
    NSInteger occurencesFive = 0;
    for (DieLabel *dieLabel in self.selectedDice) {
        if ([dieLabel.text isEqualToString:@"1"]) {
            occurrencesOne += 1;
            if (occurrencesOne == 3) {
                score = 1000;
            }
        }
        if ([dieLabel.text isEqualToString:@"5"]) {
            occurencesFive += 1;
            if (occurencesFive == 3) {
                score = 500;
            }
        }
    }

    self.roundScore.text = [NSString stringWithFormat:@"Round Score: %li", score];
}

- (IBAction)onRollButtonPressed:(UIButton *)sender {
    for (DieLabel *label in self.dieLabels) {
        if (!label.dieSelected) {
            [label rollDie];
        }
    }
    [self calculateSpecialScore];
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
