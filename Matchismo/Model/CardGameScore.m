//
//  CardGameScore.m
//  Matchismo II
//
//  Created by Vishnu Gopal on 20/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import "CardGameScore.h"

@interface CardGameScore()
@end

@implementation CardGameScore

- (id)initWithScore:(int)score typeOfGame:(NSString*)typeOfGame gameStartTime:(NSDate*)gameStartTime {
    self = [super init];
    
    if (self) {
        _score = score;
        _typeOfGame = typeOfGame;
        _gameStartTime = gameStartTime;
    }
    
    return self;
}

- (id)initWithCardMatchingGame:(CardMatchingGame *)cardMatchingGame typeOfGame:(NSString*)typeOfGame {
    self = [self initWithScore:cardMatchingGame.score typeOfGame:typeOfGame gameStartTime:cardMatchingGame.gameStart];
        
    return self;
}

+ (NSMutableDictionary *)allGameScores
{
    static NSMutableDictionary *_allGameScores = nil;
    if (!_allGameScores) _allGameScores = [[NSMutableDictionary alloc] init];
    
    return _allGameScores;
}

+ (NSArray *)allScores {
    NSMutableArray *allScores = [@[] mutableCopy];
    
    for (NSString *key in [self allGameScores]) {
        NSDictionary *thisScore = [self allGameScores][key];
        
        CardGameScore *score = [[CardGameScore alloc] initWithScore:[thisScore[@"score"] intValue] typeOfGame:thisScore[@"typeOfGame"] gameStartTime:thisScore[@"gameStartTime"]];
        
        [allScores addObject:score];
    }
    
    return [allScores copy];
}

- (void)recordGameScore:(int)scoreFromGame {
    NSDictionary *score = @{@"score": @(scoreFromGame),
                            @"typeOfGame": self.typeOfGame,
                            @"gameStartTime":self.gameStartTime};
    
    [[[self class] allGameScores] setObject:score forKey:self.gameStartTime];
}

@end
