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

#define CardGameScoreStoreKey @"MatchismoCardGameScoreStore"

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
    if (!_allGameScores) _allGameScores = [self loadGameScoresFromStore];
    
    return _allGameScores;
}

+ (NSArray *)allScores {
    NSMutableArray *allScores = [@[] mutableCopy];
    
    for (NSString *key in [self allGameScores]) {
        NSDictionary *thisScore = [self allGameScores][key];
                
        CardGameScore *score = [[CardGameScore alloc] initWithScore:[thisScore[@"score"] intValue]
                                                         typeOfGame:thisScore[@"typeOfGame"]
                                                      gameStartTime:thisScore[@"gameStartTime"]];
        
        [allScores addObject:score];
    }
    
    return [allScores copy];
}

+ (NSArray *)allScoresOrderedByGameStartTime {
    return [[self allScores] sortedArrayUsingSelector:@selector(gameStartTimeCompare:)];
}

- (NSComparisonResult)gameStartTimeCompare:(CardGameScore *) otherGameScore {
    return [self.gameStartTime compare:otherGameScore.gameStartTime];
}

- (void)recordGameScore:(int)scoreFromGame {
    NSDictionary *score = @{@"score": @(scoreFromGame),
                            @"typeOfGame": self.typeOfGame,
                            @"gameStartTime":self.gameStartTime};
        
    [[[self class] allGameScores] setObject:score forKey:[self.gameStartTime description]];
    
    [self synchronize];
}

- (void)synchronize {
    [[NSUserDefaults standardUserDefaults] setObject:[[[self class] allGameScores] copy] forKey:CardGameScoreStoreKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSMutableDictionary*)loadGameScoresFromStore {
    NSMutableDictionary *allScores = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:CardGameScoreStoreKey] mutableCopy];
    
    if (!allScores) allScores = [[NSMutableDictionary alloc] init];
    
    return allScores;
}

@end
