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

@interface TwoCardGameViewController()
@end

@implementation TwoCardGameViewController
@synthesize deck = _deck;

- (NSUInteger)flipCost {
    return 1;
}

- (NSUInteger)matchBonus {
    return 4;
}

- (NSUInteger)mismatchPenalty {
    return 2;
}

- (NSUInteger)numberOfCardsToMatch {
    return 2;
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
