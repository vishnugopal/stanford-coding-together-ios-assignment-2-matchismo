//
//  PlayingCard.m
//  Matchismo
//
//  Created by Vishnu Gopal on 16/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard 

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    if ([otherCards count] == 1) {
        id otherCard = [otherCards lastObject];
        if ([otherCard isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherPlayingCard = (PlayingCard *)otherCard;
            
            if ([otherPlayingCard.suit isEqualToString:self.suit]) {
                score = 1;
            } else if (otherPlayingCard.rank == self.rank) {
                score = 4;
            }
        }
    } else if ([otherCards count] == 2) {
        id firstCard = [otherCards objectAtIndex:0];
        id secondCard = [otherCards objectAtIndex:1];
        
        if ([firstCard isKindOfClass:[PlayingCard class]] &&
                [secondCard isKindOfClass:[PlayingCard class]]) {
            PlayingCard *firstPlayingCard = (PlayingCard *)firstCard;
            PlayingCard *secondPlayingCard = (PlayingCard *)secondCard;
            
            if ([firstPlayingCard.suit isEqualToString:self.suit] && [secondPlayingCard.suit isEqualToString:self.suit]) {
                score = 4;
            } else if ((firstPlayingCard.rank == self.rank) && (secondPlayingCard.rank == self.rank)) {
                score = 16;
            }
        }
    }
    
    return score;
}

-(NSString*)contents {
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray*)validSuits {
    static NSArray *validSuits = nil;
    if(!validSuits) validSuits = @[@"♠", @"♣", @"♥", @"♦"];
    return validSuits;
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray*) rankStrings {
    static NSArray *rankStrings = nil;
    if(!rankStrings) rankStrings = @[@"?",@"A", @"1", @"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    
    return rankStrings;
}

+ (NSUInteger)maxRank {
    return [self.rankStrings count] - 1;
}

@end
