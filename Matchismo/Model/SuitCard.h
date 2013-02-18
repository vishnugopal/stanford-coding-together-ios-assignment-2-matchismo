//
//  SuitCard.h
//  Matchismo II
//
//  Created by Vishnu Gopal on 18/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface SuitCard : Card

@property (nonatomic) NSUInteger number;
@property (nonatomic, strong) NSString* symbol;
@property (nonatomic, strong) NSNumber* shading;
@property (nonatomic, strong) NSNumber* color;

+ (NSUInteger)maxNumbers;
+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSArray *)validColors;

@end
