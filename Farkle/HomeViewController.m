//
//  ViewController.m
//  Farkle
//
//  Created by Husein Kareem on 6/6/15.
//  Copyright (c) 2015 Husein Kareem. All rights reserved.
//

#import "HomeViewController.h"
#import "DieLabel.h"
@interface HomeViewController ()

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

-(void)calculateRoundScore {
    NSNumber *score = 0;
    for (DieLabel *dieLabel in self.dieLabels) {
        if ([dieLabel.text isEqualToString:@"1"]) {
        }
    }

}

- (IBAction)onRollButtonPressed:(UIButton *)sender {

}




@end
