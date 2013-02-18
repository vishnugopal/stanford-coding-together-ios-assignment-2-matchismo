//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Vishnu Gopal on 17/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck*)deck;

//convenience initializer
- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck*)deck
           withFlipCost:(NSUInteger)flipCost
             matchBonus:(NSUInteger)matchBonus
        mismatchPenalty:(NSUInteger)mismatchPenalty
    numberOfCardsToMatch:(NSUInteger)numberOfCardsToMatch;


- (void)flipCardAtIndex:(NSUInteger)index;
- (Card*)cardAtIndex:(NSUInteger)index;

@property (nonatomic) NSUInteger numberOfCardsToMatch;
@property (nonatomic) NSUInteger flipCost;
@property (nonatomic) NSUInteger matchBonus;
@property (nonatomic) NSUInteger mismatchPenalty;
@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) int lastScore;
@property (nonatomic, readonly) Card* lastFlippedCard;
@property (nonatomic, readonly) NSArray* lastMatchedCards;

@end
