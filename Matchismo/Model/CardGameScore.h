//
//  CardGameScore.h
//  Matchismo II
//
//  Created by Vishnu Gopal on 20/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardMatchingGame.h"

@interface CardGameScore : NSObject

//designated initializer
- (id)initWithScore:(int)score typeOfGame:(NSString*)typeOfGame gameStartTime:(NSDate*)gameStartTime;

//convenience initializer
- (id)initWithCardMatchingGame:(CardMatchingGame *)cardMatchingGame typeOfGame:(NSString*)typeOfGame;

- (void)recordGameScore:(int)scoreFromGame;
+ (NSArray *)allScores;
+ (NSArray *)allScoresOrderedByGameStartTime;

@property (nonatomic, readonly) int score;
@property (nonatomic, readonly, strong) NSString* typeOfGame;
@property (nonatomic, readonly, strong) NSDate* gameStartTime;
@end
