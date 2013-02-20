//
//  TwoCardGameViewController.m
//  Matchismo II
//
//  Created by Vishnu Gopal on 18/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import "TwoCardGameViewController.h"
#import "CardGameViewControllerPrivateProperties.h"
#import "PlayingCardDeck.h"
#import "CardGameSettings.h"

@interface TwoCardGameViewController()
@end

@implementation TwoCardGameViewController
@synthesize deck = _deck;

- (NSUInteger)flipCost {
    int flipCostFromStore = [CardGameSettings integerValueForKey:TwoCardGameViewControllerFlipCostKey];
    
    if (flipCostFromStore == 0) {
        [CardGameSettings setValue:@1 forKey:TwoCardGameViewControllerFlipCostKey];
        flipCostFromStore = 1;
    }
    
    return flipCostFromStore;
}

- (NSUInteger)matchBonus {
    int matchBonusFromStore = [CardGameSettings integerValueForKey:TwoCardGameViewControllerMatchBonusKey];
    
    if (matchBonusFromStore == 0) {
        [CardGameSettings setValue:@4 forKey:TwoCardGameViewControllerMatchBonusKey];
        matchBonusFromStore = 4;
    }
    
    return matchBonusFromStore;
}

- (NSUInteger)mismatchPenalty {
    int mismatchPenaltyFromStore = [CardGameSettings integerValueForKey:TwoCardGameViewControllerMisMatchPenaltyKey];
    
    if (mismatchPenaltyFromStore == 0) {
        [CardGameSettings setValue:@2 forKey:TwoCardGameViewControllerMisMatchPenaltyKey];
        mismatchPenaltyFromStore = 2;
    }
    
    return mismatchPenaltyFromStore;
}

- (NSUInteger)numberOfCardsToMatch {
    return 2;
}

- (NSString *)typeOfGame {
    return @"Two Card Matching Game";
}

- (Deck *)deck {
    if (!_deck) _deck = [[PlayingCardDeck alloc] init];
    
    return _deck;
}

- (void)updateButtonsAndLabels {
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3: 1.0;
        [cardButton setBackgroundImage:self.cardBackImage forState:UIControlStateNormal];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.commentaryLabel.text = self.currentCommentary;
}

@end
