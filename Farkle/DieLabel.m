//
//  DieLabel.m
//  Farkle
//
//  Created by Husein Kareem on 6/6/15.
//  Copyright (c) 2015 Husein Kareem. All rights reserved.
//

#import "DieLabel.h"
#import <stdlib.h>

@implementation DieLabel

-(id)initWithCoder:(NSCoder *)aDecoder {

    self = [super initWithCoder:aDecoder];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(calledWhenTapped)];
    [self addGestureRecognizer:tapGesture];
    self.userInteractionEnabled = YES;
    return self;
}

-(void)calledWhenTapped {
    [self.delegate dieLabel:self];
}

-(void)rollDie {
    int number = arc4random_uniform(6) + 1;
    self.text = [NSString stringWithFormat:@"%i", number];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
