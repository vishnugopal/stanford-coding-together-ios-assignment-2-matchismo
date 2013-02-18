//
//  SuitCardDeck.m
//  Matchismo II
//
//  Created by Vishnu Gopal on 18/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import "SuitCardDeck.h"
#import "SuitCard.h"

@implementation SuitCardDeck

- (id)init {
    self = [super init];
    if (self) {
        for (int number = 0; number < [SuitCard maxNumbers]; number++) {
            for (NSString *symbol in [SuitCard validSymbols]) {
                for (NSNumber *shading in [SuitCard validShadings]) {
                    for (NSNumber *color in [SuitCard validColors]) {
                        SuitCard* suitCard = [[SuitCard alloc] init];
                        suitCard.number = number;
                        suitCard.symbol = symbol;
                        suitCard.shading = shading;
                        suitCard.color = color;
                        [self addCard:suitCard atTop:YES];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
