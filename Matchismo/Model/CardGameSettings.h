//
//  CardGameSettings.h
//  Matchismo II
//
//  Created by Vishnu Gopal on 20/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TwoCardGameViewControllerFlipCostKey @"TwoCardGameViewController.flipCost"
#define TwoCardGameViewControllerMatchBonusKey @"TwoCardGameViewController.matchBonus"
#define TwoCardGameViewControllerMisMatchPenaltyKey @"TwoCardGameViewController.mismatchPenalty"
#define SetGameViewControllerFlipCostKey @"SetGameViewController.flipCost"
#define SetGameViewControllerMatchBonusKey @"SetGameViewController.matchBonus"
#define SetGameViewControllerMisMatchPenaltyKey @"SetGameViewController.mismatchPenalty"


@interface CardGameSettings : NSObject

+ (id)valueForKey:(NSString *)key;
+ (int)integerValueForKey:(NSString *)key;
+ (void)setValue:(id)value forKey:(NSString *)key;

@end
