//
//  ScoresViewController.m
//  Matchismo II
//
//  Created by Vishnu Gopal on 20/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import "ScoresViewController.h"
#import "CardGameScore.h"

@interface ScoresViewController ()

@end

@implementation ScoresViewController

- (NSString*)scoresAsText {
    NSString *scoresAsText = @"";
    
    for (CardGameScore *gameScore in [CardGameScore allScoresOrderedByGameStartTime]) {
        scoresAsText = [scoresAsText stringByAppendingFormat:@"%@ at %@: %d points\n", gameScore.typeOfGame, gameScore.gameStartTime, gameScore.score];
    }
    
    return scoresAsText;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.scoresDetail.text = [self scoresAsText];
}

@end
