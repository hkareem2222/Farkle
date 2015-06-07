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
@property (weak, nonatomic) IBOutlet UIButton *rollButton;
@property (weak, nonatomic) IBOutlet UILabel *playerOneScore;
@property (weak, nonatomic) IBOutlet UILabel *playerTwoScore;
@property (weak, nonatomic) IBOutlet UILabel *roundScore;
@property NSInteger roundScoreTotal;
@property NSInteger score;
@property NSInteger specialscore;
@property NSInteger pOneScore;
@property NSInteger pTwoScore;
@property BOOL pOneScoring;
@property int selectedCount;
@property NSMutableArray *currentSelectedDice;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //inital setup
    self.currentSelectedDice = [NSMutableArray new];
    self.roundScoreTotal = 0;
    self.pOneScoring = YES;
    //setting up delegate
    for (DieLabel *die in self.dieLabels) {
        die.delegate = self;
        die.backgroundColor = [UIColor redColor];
    }
}

-(void)dieLabel:(DieLabel *)die {
    die.backgroundColor = [UIColor blackColor];
    die.dieSelected = YES;
    self.rollButton.enabled = YES;
    if (![self.currentSelectedDice containsObject:die]) {
        [self.currentSelectedDice addObject:die];
    }
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
                self.score += 800;
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
                self.score += 400;
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
                self.specialscore += 100;
            }
        }
        if ([dieLabel.text isEqualToString:@"5"]) {
            occurencesFive += 1;
            if (occurencesFive == 1) {
                self.specialscore += 50;
            }
            if (occurencesFive == 2) {
                self.specialscore += 50;
            }
        }
    }

    self.roundScore.text = [NSString stringWithFormat:@"Round Score: %li", self.roundScoreTotal + self.score + self.specialscore];
}

- (IBAction)onRollButtonPressed:(UIButton *)sender {
    self.roundScoreTotal += self.score;
    self.roundScoreTotal += self.specialscore;

    for (DieLabel *label in self.dieLabels) {
        if (!label.dieSelected) {
            [label rollDie];
        }
    }

    self.currentSelectedDice = [NSMutableArray new];
    self.rollButton.enabled = NO;
}
- (IBAction)onBankScoreButton:(UIButton *)sender {
    if (self.pOneScoring) {
        self.playerOneScore.text = [NSString stringWithFormat:@"Player 1 Total: %li", self.pOneScore + self.roundScoreTotal + self.score + self.specialscore];
        self.pOneScore += self.roundScoreTotal + self.score + self.specialscore;
    } else {
        self.playerTwoScore.text = [NSString stringWithFormat:@"Player 2 Total: %li", self.pTwoScore + self.roundScoreTotal + self.score + self.specialscore];
        self.pTwoScore += self.roundScoreTotal + self.score + self.specialscore;
    }
    self.pOneScoring = !self.pOneScoring;
    self.rollButton.enabled = YES;
    self.roundScoreTotal = 0;
    self.score = 0;
    self.specialscore = 0;
    self.currentSelectedDice = [NSMutableArray new];
    for (DieLabel *label in self.dieLabels) {
        label.backgroundColor = [UIColor redColor];
        [label rollDie];
    }
    self.roundScore.text = @"Round Score: 0";
}

-(void)allSelected {
//    self.selectedCount = 0;
//
//    for (DieLabel *label in self.dieLabels) {
//        if (label.dieSelected) {
//            self.selectedCount = self.selectedCount + 1;
//        }
//        if (self.selectedCount == 6) {
//            for (DieLabel *label in self.dieLabels) {
//                label.dieSelected = NO;
//                label.backgroundColor = [UIColor redColor];
////                [label rollDie];
//            }
//            if (self.pOneScoring) {
//                self.playerOneScore.text = [NSString stringWithFormat:@"Player 1 Total: %li", self.pOneScore + self.roundScoreTotal + self.score + self.specialscore];
//                self.pOneScore += self.roundScoreTotal + self.score + self.specialscore;
//            } else {
//                self.playerTwoScore.text = [NSString stringWithFormat:@"Player 2 Total: %li", self.pTwoScore + self.roundScoreTotal + self.score + self.specialscore];
//                self.pTwoScore += self.roundScoreTotal + self.score + self.specialscore;
//            }
//            self.pOneScoring = !self.pOneScoring;
//            self.rollButton.enabled = YES;
//            self.roundScoreTotal = 0;
//            self.score = 0;
//            self.specialscore = 0;
//            self.currentSelectedDice = [NSMutableArray new];
//            self.roundScore.text = @"Round Score: 0";
//        }
//    }
}


@end
