//
//  DieLabel.h
//  Farkle
//
//  Created by Husein Kareem on 6/6/15.
//  Copyright (c) 2015 Husein Kareem. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DieLabel;
@protocol DieLabelDelegate <NSObject>
-(void)dieLabel:(DieLabel *)die;
@end

@interface DieLabel : UILabel

@property (nonatomic, assign) id <DieLabelDelegate> delegate;
@property BOOL dieSelected;

-(void)rollDie;

@end
