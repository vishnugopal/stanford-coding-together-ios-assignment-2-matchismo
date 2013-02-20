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
                
        cardButton.alpha = [self shadingForCard:card];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.backgroundColor = [UIColor blackColor];
        
        /* Content is visible in all states */
        NSAttributedString *cardContents = [self attributedStringContentsForCard:card];
        [cardButton setAttributedTitle:cardContents forState:UIControlStateNormal];
        [cardButton setAttributedTitle:cardContents forState:UIControlStateSelected];
        [cardButton setAttributedTitle:cardContents forState:UIControlStateSelected|UIControlStateDisabled];
        
        [cardButton setBackgroundImage:self.cardBackImage forState:UIControlStateSelected];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    [self updateCommentaryLabel];
}

- (void)updateCommentaryLabel {
    NSMutableArray *possibleCards = [self.game.lastMatchedCards mutableCopy];
    if (!possibleCards) possibleCards = [[NSMutableArray alloc] init];
    if (self.game.lastFlippedCard) [possibleCards addObject:self.game.lastFlippedCard];
    
    self.commentaryLabel.attributedText = [self createAttributedStringsFor:possibleCards withString:self.currentCommentary];
}

-(NSAttributedString *)createAttributedStringsFor:(NSArray *)cards withString:(NSString *)originalString {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:originalString attributes:@{}];
    
    if (originalString && [originalString length] > 0) {
        NSRange nextRange;
        nextRange.location = 0;
        nextRange.length = 0;
        for (Card *card in cards) {
            if ([card isKindOfClass:[SetCard class]]) {
                SetCard* setCard = (SetCard*)card;
                
                NSRange range;
                if (nextRange.length == 0) {
                    /*
                     For the first card we find the first match.
                     */
                    range = [[attributedString string] rangeOfString:setCard.contents];
                } else {
                    /*
                     For the rest, we start searching only from the last range. This is to make sure we set correct attributes for duplicate symbols.
                     */
                    range = [[attributedString string] rangeOfString:setCard.contents options:NSLiteralSearch range:nextRange];
                }
                
                /*
                 After each card, the next range starts after the last matched range.
                 */
                nextRange.location = range.location + range.length;
                nextRange.length = [originalString length] - nextRange.location;
                
                [attributedString setAttributes:[self attributesForCard:setCard] range:range];
            }
        }
    }
    
    return attributedString;
}

- (CGFloat)shadingForCard:(Card *)card {
    CGFloat alpha = 1;
    
    if ([card isKindOfClass:[SetCard class]]) {
        SetCard* setCard = (SetCard*)card;
        
        /* Set shading */
        if (setCard.isUnplayable) {
            alpha = 0; /*Invisible*/
        } else if ([setCard.shading isEqualToNumber:SetCardShadingSolid]) {
            alpha = 1;
        } else if ([setCard.shading isEqualToNumber:SetCardShadingStriped]) {
            alpha = 0.7;
        } else if ([setCard.shading isEqualToNumber:SetCardShadingOpen]) {
            alpha = 0.3;
        }
    }
    
    return alpha;
}

- (NSAttributedString *)attributedStringContentsForCard:(Card *)card {
    NSAttributedString* attributedString = nil;
    
    if ([card isKindOfClass:[SetCard class]]) {
        SetCard* setCard = (SetCard*)card;
        
        NSDictionary *attributes = [self attributesForCard:setCard];
        
        /* Create the attributed string finally */
        attributedString = [[NSAttributedString alloc] initWithString:card.contents attributes:attributes];
    }
    
    return attributedString;
}

- (NSDictionary *)attributesForCard:(SetCard*)setCard {
    /* Set color */
    UIColor* color = nil;
    if ([setCard.color isEqualToNumber:SetCardColorRed]) {
        color = [UIColor redColor];
    } else if ([setCard.color isEqualToNumber:SetCardColorGreen]) {
        color = [UIColor greenColor];
    } else if ([setCard.color isEqualToNumber:SetCardColorPurple]) {
        color = [UIColor purpleColor];
    }
    
    /* Set font */
    UIFont *font = [UIFont systemFontOfSize:8];
    
    /* Now set attributes */
    NSDictionary *attributes = @{NSFontAttributeName: font,
                                 NSForegroundColorAttributeName: color,
                                 };
    
    return attributes;
}


@end
