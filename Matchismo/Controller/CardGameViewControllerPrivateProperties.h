//
//  CardGameViewControllerPrivateProperties.h
//  Matchismo II
//
//  Created by Vishnu Gopal on 18/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import "CardMatchingGame.h"
#import "CardGameScore.h"

/* Private Interface */
@interface CardGameViewController()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentaryLabel;
@property (strong, nonatomic) UIImage* cardBackImage;
@property (nonatomic) NSUInteger flipCost;
@property (nonatomic) NSUInteger matchBonus;
@property (nonatomic) NSUInteger mismatchPenalty;
@property (nonatomic) NSUInteger numberOfCardsToMatch;
@property (nonatomic, strong) Deck* deck;
@property (strong, nonatomic) NSString* currentCommentary;
@property (strong, nonatomic) NSString* typeOfGame;
@property (strong, nonatomic) CardGameScore *cardGameScore;
@end