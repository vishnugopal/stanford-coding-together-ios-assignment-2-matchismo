//
//  SuitCard.m
//  Matchismo II
//
//  Created by Vishnu Gopal on 18/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import "SuitCard.h"


@implementation SuitCard

#define SuitCardShadingSolid @1
#define SuitCardShadingStriped @2
#define SuitCardShadingOpen @3
#define SuitCardShadingInvalid @0

#define SuitCardColorRed @1
#define SuitCardColorGreen @2
#define SuitCardColorPurple @3
#define SuitCardColorInvalid @0


+ (NSUInteger)maxNumbers {
    return 3;
}

+ (NSArray *)validSymbols {
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *)validShadings {
    return @[SuitCardShadingSolid, SuitCardShadingStriped, SuitCardShadingOpen];
}

+ (NSArray *)validColors {
    return @[SuitCardColorRed, SuitCardColorGreen, SuitCardColorPurple];
}

- (NSString *)contents {
    NSString* contentString = @"";
    for (int i = 0; i < self.number; i++) {
        contentString = [contentString stringByAppendingString:self.symbol];
    }
    
    return contentString;
}

@synthesize symbol = _symbol;

- (void)setSymbol:(NSString *)symbol {
    if ([[SuitCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (NSString *)symbol {
    return _symbol ? _symbol : @"?";
}

@synthesize shading = _shading;

- (void)setShading:(NSNumber *)shading {
    if ([[SuitCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

- (NSNumber *)shading {
    return _shading ? _shading : SuitCardShadingInvalid;
}

@synthesize color = _color;

- (void)setColor:(NSNumber *)color {
    if ([[SuitCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (NSNumber *)color {
    return _color ? _color : SuitCardColorInvalid;
}

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if ([otherCards count] == 2) {
        id firstCard = [otherCards objectAtIndex:0];
        id secondCard = [otherCards objectAtIndex:1];
        
        if ([firstCard isKindOfClass:[SuitCard class]] &&
            [secondCard isKindOfClass:[SuitCard class]]) {
            SuitCard *firstSuitCard = (SuitCard *)firstCard;
            SuitCard *secondSuitCard = (SuitCard *)secondCard;
            
            /* If all of either number, symbol, shading or color is the same, we have a lower score */
            if (self.number == firstSuitCard.number && firstSuitCard.number == secondSuitCard.number) {
                score = 1;
            } else if ([self.symbol isEqualToString:firstSuitCard.symbol] && [firstSuitCard.symbol isEqualToString:secondSuitCard.symbol]) {
                score =  1;
            } else if (self.shading == firstSuitCard.shading && firstSuitCard.shading == secondSuitCard.shading) {
                score = 1;
            } else if (self.color == firstSuitCard.color && firstSuitCard.color == secondSuitCard.color) {
                score = 1;
            }
            
            /* If all of either number, symbol, shading or color are different, we have a higher score */
            if (self.number != firstSuitCard.number && firstSuitCard.number != secondSuitCard.number && self.number != secondSuitCard.number) {
                score = 2;
            } else if ((![self.symbol isEqualToString:firstSuitCard.symbol]) && (![firstSuitCard.symbol isEqualToString:secondSuitCard.symbol]) && (![self.symbol isEqualToString:secondSuitCard.symbol])) {
                score =  2;
            } else if (self.shading != firstSuitCard.shading && firstSuitCard.shading != secondSuitCard.shading && self.shading != secondSuitCard.shading) {
                score = 2;
            } else if (self.color != firstSuitCard.color && firstSuitCard.color != secondSuitCard.color && self.color != secondSuitCard.color) {
                score = 2;
            }
        }
    }
    
    return score;
}

@end
