//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Vishnu Gopal on 16/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardGameViewControllerPrivateProperties.h"
#import "PlayingCardDeck.h"

@implementation CardGameViewController
- (CardMatchingGame *)game {
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                         usingDeck:self.deck
                                                      withFlipCost:self.flipCost
                                                        matchBonus:self.matchBonus
                                                   mismatchPenalty:self.mismatchPenalty
                                              numberOfCardsToMatch:self.numberOfCardsToMatch];
    
    return _game;
}

- (UIImage *)cardBackImage {
    if (!_cardBackImage) _cardBackImage = [UIImage imageNamed:@"cardback.png"];
    
    return _cardBackImage;
}


- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateButtonsAndLabels {
    /* Abstract method */
}

- (NSString *)getCommentaryForCurrentGame {
    NSString *commentary = @"";
    int lastScore = [self.game lastScore];
    NSString *matchedCardsAsString = [[self.game lastMatchedCards] componentsJoinedByString:@" & "];
    Card* lastFlippedCard = [self.game lastFlippedCard];
    
    if (matchedCardsAsString) {
        if (lastScore > 0) {
            commentary = [NSString stringWithFormat:@"Matched %@ for %d points", matchedCardsAsString, lastScore];
        } else if (lastScore < 0) {
            commentary = [NSString stringWithFormat:@"%@ don't match! %d point penalty!", matchedCardsAsString, -lastScore];
        }
    } else {
        if (lastFlippedCard) {
            commentary = [NSString stringWithFormat:@"Flipped up %@", lastFlippedCard];
        } else {
            commentary = @"Touch to start!";
        }
    }
    
    return commentary;
}

- (void)updateCommentary {
    self.currentCommentary = [self getCommentaryForCurrentGame];
}

- (void)updateUI {
    [self updateCommentary];
    [self updateButtonsAndLabels];
}

-(void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender {    
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (IBAction)dealGame {
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
}

@end
