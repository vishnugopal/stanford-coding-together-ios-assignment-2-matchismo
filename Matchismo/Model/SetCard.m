//
//  SuitCard.m
//  Matchismo II
//
//  Created by Vishnu Gopal on 18/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import "SetCard.h"


@implementation SetCard


+ (NSUInteger)maxNumbers {
    return 3;
}

+ (NSArray *)validSymbols {
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *)validShadings {
    return @[SetCardShadingSolid, SetCardShadingStriped, SetCardShadingOpen];
}

+ (NSArray *)validColors {
    return @[SetCardColorRed, SetCardColorGreen, SetCardColorPurple];
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
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (NSString *)symbol {
    return _symbol ? _symbol : @"?";
}

@synthesize shading = _shading;

- (void)setShading:(NSNumber *)shading {
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

- (NSNumber *)shading {
    return _shading ? _shading : SetCardShadingInvalid;
}

@synthesize color = _color;

- (void)setColor:(NSNumber *)color {
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (NSNumber *)color {
    return _color ? _color : SetCardColorInvalid;
}

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if ([otherCards count] == 2) {
        id firstCard = [otherCards objectAtIndex:0];
        id secondCard = [otherCards objectAtIndex:1];
        
        if ([firstCard isKindOfClass:[SetCard class]] &&
            [secondCard isKindOfClass:[SetCard class]]) {
            SetCard *firstSetCard = (SetCard *)firstCard;
            SetCard *secondSetCard = (SetCard *)secondCard;
            
            /* If all of either number, symbol, shading or color is the same, we have a lower score */
            if (self.number == firstSetCard.number && firstSetCard.number == secondSetCard.number) {
                score = 1;
            } else if ([self.symbol isEqualToString:firstSetCard.symbol] && [firstSetCard.symbol isEqualToString:secondSetCard.symbol]) {
                score =  1;
            } else if (self.shading == firstSetCard.shading && firstSetCard.shading == secondSetCard.shading) {
                score = 1;
            } else if (self.color == firstSetCard.color && firstSetCard.color == secondSetCard.color) {
                score = 1;
            }
            
            /* If all of either number, symbol, shading or color are different, we have a higher score */
            if (self.number != firstSetCard.number && firstSetCard.number != secondSetCard.number && self.number != secondSetCard.number) {
                score = 2;
            } else if ((![self.symbol isEqualToString:firstSetCard.symbol]) && (![firstSetCard.symbol isEqualToString:secondSetCard.symbol]) && (![self.symbol isEqualToString:secondSetCard.symbol])) {
                score =  2;
            } else if (self.shading != firstSetCard.shading && firstSetCard.shading != secondSetCard.shading && self.shading != secondSetCard.shading) {
                score = 2;
            } else if (self.color != firstSetCard.color && firstSetCard.color != firstSetCard.color && self.color != secondSetCard.color) {
                score = 2;
            }
        }
    }
    
    return score;
}

@end
