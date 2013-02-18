//
//  SuitCard.h
//  Matchismo II
//
//  Created by Vishnu Gopal on 18/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

#define SetCardShadingSolid @1
#define SetCardShadingStriped @2
#define SetCardShadingOpen @3
#define SetCardShadingInvalid @0

#define SetCardColorRed @1
#define SetCardColorGreen @2
#define SetCardColorPurple @3
#define SetCardColorInvalid @0

@interface SetCard : Card

@property (nonatomic) NSUInteger number;
@property (nonatomic, strong) NSString* symbol;
@property (nonatomic, strong) NSNumber* shading;
@property (nonatomic, strong) NSNumber* color;

+ (NSUInteger)maxNumbers;
+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSArray *)validColors;

@end
