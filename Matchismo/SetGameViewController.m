//
//  SetGameViewController.m
//  Matchismo II
//
//  Created by Vishnu Gopal on 18/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import "SetGameViewController.h"
#import "CardMatchingGame.h"
#import "CardGameViewControllerPrivateProperties.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController
@synthesize deck = _deck;

- (NSUInteger)flipCost {
    return 0;
}

- (NSUInteger)matchBonus {
    return 4;
}

- (NSUInteger)mismatchPenalty {
    return 0;
}

- (NSUInteger)numberOfCardsToMatch {
    return 3;
}

- (Deck *)deck {
    if (!_deck) _deck = [[SetCardDeck alloc] init];
    
    return _deck;
}

- (void)updateButtonsAndLabels {
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        
        /* Content is visible in all states */
        NSAttributedString *cardContents = [self attributedStringContentsForCard:card];
        [cardButton setAttributedTitle:cardContents forState:UIControlStateNormal];
        [cardButton setAttributedTitle:cardContents forState:UIControlStateSelected];
        [cardButton setAttributedTitle:cardContents forState:UIControlStateSelected|UIControlStateDisabled];
        
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSAttributedString *)attributedStringContentsForCard:(Card *)card {
    NSAttributedString* attributedString = nil;
    
    if ([card isKindOfClass:[SetCard class]]) {
        SetCard* setCard = (SetCard*)card;
        
        /* Set shading */
        int alpha = 1;
        if (setCard.isUnplayable) {
            alpha = 0; /*Invisible*/
        } else if ([setCard.shading isEqualToNumber:SetCardShadingSolid]) {
            alpha = 1;
        } else if ([setCard.shading isEqualToNumber:SetCardShadingStriped]) {
            alpha = 0.7;
        } else if ([setCard.shading isEqualToNumber:SetCardShadingStriped]) {
            alpha = 0.3;
        }
        
        /* Set color */
        UIColor* color = nil;
        if ([setCard.color isEqualToNumber:SetCardColorRed]) {
            color = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:alpha];
        } else if ([setCard.color isEqualToNumber:SetCardColorGreen]) {
            color = [UIColor colorWithRed:0 green:1.0 blue:0 alpha:alpha];
        } else if ([setCard.color isEqualToNumber:SetCardColorPurple]) {
            color = [UIColor colorWithRed:0.6 green:0 blue:0.6 alpha:alpha];
        }
        
        /* Set font */
        UIFont *font = [UIFont systemFontOfSize:8];
        
        /* Now set attributes */
        NSDictionary *attributes = @{NSFontAttributeName: font,
                                     NSForegroundColorAttributeName: color,
                                     };
        
        /* Create the attributed string finally */
        attributedString = [[NSAttributedString alloc] initWithString:card.contents attributes:attributes];
    }
    
    return attributedString;
}

@end
