//
//  SuitCardDeck.m
//  Matchismo II
//
//  Created by Vishnu Gopal on 18/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (id)init {
    self = [super init];
    if (self) {
        for (int number = 1; number <= [SetCard maxNumbers]; number++) {
            for (NSString *symbol in [SetCard validSymbols]) {
                for (NSNumber *shading in [SetCard validShadings]) {
                    for (NSNumber *color in [SetCard validColors]) {
                        SetCard* setCard = [[SetCard alloc] init];
                        setCard.number = number;
                        setCard.symbol = symbol;
                        setCard.shading = shading;
                        setCard.color = color;
                        [self addCard:setCard atTop:YES];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
