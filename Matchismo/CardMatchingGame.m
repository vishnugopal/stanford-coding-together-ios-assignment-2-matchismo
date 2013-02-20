//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Vishnu Gopal on 17/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic, readwrite) int score;
@property (nonatomic, readwrite) int lastScore;
@property (nonatomic, readwrite) Card* lastFlippedCard;
@property (nonatomic, readwrite) NSArray* lastMatchedCards;
@property (nonatomic) NSMutableArray* cardsInMatchQueue;
@end

@implementation CardMatchingGame

- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
                break;
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    _numberOfCardsToMatch = 2;
    _gameStart = [NSDate date];
    
    return self;
}

- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck*)deck
           withFlipCost:(NSUInteger)flipCost
             matchBonus:(NSUInteger)matchBonus
        mismatchPenalty:(NSUInteger)mismatchPenalty
   numberOfCardsToMatch:(NSUInteger)numberOfCardsToMatch {
    self = [self initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck];
    
    if (self) {
        _flipCost = flipCost;
        _matchBonus = matchBonus;
        _mismatchPenalty = mismatchPenalty;
        _numberOfCardsToMatch = numberOfCardsToMatch;
    }
    
    return self;
}

- (NSTimeInterval)gameDuration {
    return [[NSDate date] timeIntervalSinceDate:self.gameStart];
}

- (NSMutableArray *)cards {
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)cardsInMatchQueue {
    if(!_cardsInMatchQueue) _cardsInMatchQueue = [[NSMutableArray alloc] init];
    
    return _cardsInMatchQueue;
}


- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (void)flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    self.lastFlippedCard = nil;
    self.lastMatchedCards = nil;
    self.lastScore = 0;
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            self.lastFlippedCard = card;
            [self.cardsInMatchQueue addObject:card];
            if ([self.cardsInMatchQueue count] == self.numberOfCardsToMatch) {
                [self finalizeTurnScore];
            }
            self.score -= self.flipCost;
        } else {
            [self.cardsInMatchQueue removeObject:card];
        }
        card.faceUp = !card.isFaceUp;
    }
}

- (void)finalizeTurnScore {
    self.lastMatchedCards = [self.cardsInMatchQueue copy];
    
    Card* card = [self.cardsInMatchQueue lastObject];
    [self.cardsInMatchQueue removeLastObject];
    
    int matchScore = [card match:self.cardsInMatchQueue];
    if (matchScore) {
        for (Card* otherCard in self.cardsInMatchQueue) {
            otherCard.unplayable = YES;
        }
        card.unplayable = YES;
        self.lastScore = matchScore * self.matchBonus;
        self.cardsInMatchQueue = nil;
    } else {
        for (Card* otherCard in self.cardsInMatchQueue) {
            otherCard.faceUp = NO;
        }
        self.lastScore = -self.mismatchPenalty;
        self.cardsInMatchQueue = nil;
        [self.cardsInMatchQueue addObject:card];
    }
    self.score += self.lastScore;
}

@end
