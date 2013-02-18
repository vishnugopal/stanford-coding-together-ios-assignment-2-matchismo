//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Vishnu Gopal on 16/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"


@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentaryLabel;
@property (strong, nonatomic) UIImage* cardBackImage;
@end

@implementation CardGameViewController


- (CardMatchingGame *)game {
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                         usingDeck:[[PlayingCardDeck alloc] init]];
    
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

- (void)updateCommentary {
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
    
    
    self.commentaryLabel.text = commentary;
}

- (void)updateUI {
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
    [self updateCommentary];
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
