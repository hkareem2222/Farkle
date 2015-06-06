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
@property NSInteger roundScoreTotal;
@property NSInteger score;
@property NSInteger specialscore;


@property int selectedCount;
@property NSMutableArray *currentSelectedDice;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentSelectedDice = [NSMutableArray new];
    self.roundScoreTotal = 0;
    for (DieLabel *die in self.dieLabels) {
        die.delegate = self;
    }
}

-(void)dieLabel:(DieLabel *)die {
    die.backgroundColor = [UIColor blackColor];
    die.dieSelected = YES;
    self.button.enabled = YES;
    [self.currentSelectedDice addObject:die];
    [self calculateNormalScore];
    [self calculateSpecialScore];
    [self allSelected];
}

-(void)calculateNormalScore {
    self.score = 0;
    NSInteger occurrencesOne = 0;
    NSInteger occurrencesTwo = 0;
    NSInteger occurrencesThree = 0;
    NSInteger occurrencesFour = 0;
    NSInteger occurencesFive = 0;
    NSInteger occurrencesSix = 0;
    for (DieLabel *dieLabel in self.currentSelectedDice) {
        if ([dieLabel.text isEqualToString:@"1"]) {
            occurrencesOne += 1;
            if (occurrencesOne == 3) {
                self.score += 1000;
            }
        }
        if ([dieLabel.text isEqualToString:@"2"]) {
            occurrencesTwo += 1;
            if (occurrencesTwo == 3) {
                self.score += 200;
            }
        }
        if ([dieLabel.text isEqualToString:@"3"]) {
            occurrencesThree += 1;
            if (occurrencesThree == 3) {
                self.score += 300;
            }
        }
        if ([dieLabel.text isEqualToString:@"4"]) {
            occurrencesFour += 1;
            if (occurrencesFour == 3) {
                self.score += 400;
            }
        }
        if ([dieLabel.text isEqualToString:@"5"]) {
            occurencesFive += 1;
            if (occurencesFive == 3) {
                self.score += 500;
            }
        }
        if ([dieLabel.text isEqualToString:@"6"]) {
            occurrencesSix += 1;
            if (occurrencesSix == 3) {
                self.score += 600;
            }
        }

    }

    self.roundScore.text = [NSString stringWithFormat:@"Round Score: %li", self.roundScoreTotal + self.score + self.specialscore];
}


-(void)calculateSpecialScore {
    self.specialscore = 0;
    NSInteger occurrencesOne = 0;
    NSInteger occurencesFive = 0;
    for (DieLabel *dieLabel in self.currentSelectedDice) {
        if ([dieLabel.text isEqualToString:@"1"]) {
            occurrencesOne += 1;
            if (occurrencesOne == 1) {
                self.specialscore += 100;
            }
            if (occurrencesOne == 2) {
                self.specialscore += 200;
            }
        }
        if ([dieLabel.text isEqualToString:@"5"]) {
            occurencesFive += 1;
            if (occurencesFive == 1) {
                self.specialscore += 50;
            }
            if (occurencesFive == 2) {
                self.specialscore += 100;
            }
        }
    }
    self.roundScore.text = [NSString stringWithFormat:@"Round Score: %li", self.roundScoreTotal + self.score + self.specialscore];
}

- (IBAction)onRollButtonPressed:(UIButton *)sender {
    self.roundScoreTotal += self.score;
    for (DieLabel *label in self.dieLabels) {
        if (!label.dieSelected) {
//            [label rollDie];
        }
    }
    self.currentSelectedDice = [NSMutableArray new];
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
//                [label rollDie];
            }
            self.button.enabled = YES;
            self.roundScoreTotal = 0;
            self.roundScore.text = @"Round Score: 0";
        }
    }
}


@end
