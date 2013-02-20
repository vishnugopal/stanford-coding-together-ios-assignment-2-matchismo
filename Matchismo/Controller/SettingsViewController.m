//
//  SettingsViewController.m
//  Matchismo II
//
//  Created by Vishnu Gopal on 20/02/13.
//  Copyright (c) 2013 Twicecraft. All rights reserved.
//

#import "SettingsViewController.h"
#import "CardGameSettings.h"

@interface SettingsViewController ()
@property (nonatomic) int twoCardFlipCost;
@property (nonatomic) int twoCardMatchBonus;
@property (nonatomic) int twoCardMismatchPenalty;
@property (nonatomic) int setCardFlipCost;
@property (nonatomic) int setCardMatchBonus;
@property (nonatomic) int setCardMismatchPenalty;

@property (weak, nonatomic) IBOutlet UILabel *twoCardFlipCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoCardMatchBonusLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoCardMismatchPenaltyLabel;
@property (weak, nonatomic) IBOutlet UILabel *setCardFlipCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *setCardMatchBonusLabel;
@property (weak, nonatomic) IBOutlet UILabel *setCardMismatchPenaltyLabel;


@property (weak, nonatomic) IBOutlet UIStepper *twoCardFlipCostStepper;
@property (weak, nonatomic) IBOutlet UIStepper *twoCardMatchBonusStepper;
@property (weak, nonatomic) IBOutlet UIStepper *twoCardMismatchPenaltyStepper;
@property (weak, nonatomic) IBOutlet UIStepper *setCardFlipCostStepper;
@property (weak, nonatomic) IBOutlet UIStepper *setCardMatchBonusStepper;
@property (weak, nonatomic) IBOutlet UIStepper *setCardMismatchPenaltyStepper;


@end

@implementation SettingsViewController

- (int)twoCardFlipCost {
    return [CardGameSettings integerValueForKey:TwoCardGameViewControllerFlipCostKey];
}

- (void)setTwoCardFlipCost:(int)twoCardFlipCost {
    [CardGameSettings setValue:@(twoCardFlipCost) forKey:TwoCardGameViewControllerFlipCostKey];
    self.twoCardFlipCostLabel.text = [NSString stringWithFormat:@"Flip Cost: %d", twoCardFlipCost];
    self.twoCardFlipCostStepper.value = twoCardFlipCost;
}

- (int)twoCardMatchBonus {
    return [CardGameSettings integerValueForKey:TwoCardGameViewControllerMatchBonusKey];
}

- (void)setTwoCardMatchBonus:(int)twoCardMatchBonus {
    [CardGameSettings setValue:@(twoCardMatchBonus) forKey:TwoCardGameViewControllerMatchBonusKey];
    self.twoCardMatchBonusLabel.text = [NSString stringWithFormat:@"Match Bonus: %d", twoCardMatchBonus];
    self.twoCardMatchBonusStepper.value = twoCardMatchBonus;
}

- (int)twoCardMismatchPenalty {
    return [CardGameSettings integerValueForKey:TwoCardGameViewControllerMisMatchPenaltyKey];
}

- (void)setTwoCardMismatchPenalty:(int)twoCardMismatchPenalty {
    [CardGameSettings setValue:@(twoCardMismatchPenalty) forKey:TwoCardGameViewControllerMisMatchPenaltyKey];
    self.twoCardMismatchPenaltyLabel.text = [NSString stringWithFormat:@"Mismatch Penalty: %d", twoCardMismatchPenalty];
    self.twoCardMismatchPenaltyStepper.value = twoCardMismatchPenalty;
}

- (int)setCardFlipCost {
    return [CardGameSettings integerValueForKey:SetGameViewControllerFlipCostKey];
}

- (void)setSetCardFlipCost:(int)setCardFlipCost {
    [CardGameSettings setValue:@(setCardFlipCost) forKey:SetGameViewControllerFlipCostKey];
    self.setCardFlipCostLabel.text = [NSString stringWithFormat:@"Flip Cost: %d", setCardFlipCost];
    self.setCardFlipCostStepper.value = setCardFlipCost;
}

- (int)setCardMatchBonus {
    return [CardGameSettings integerValueForKey:SetGameViewControllerMatchBonusKey];
}

- (void)setSetCardMatchBonus:(int)setCardMatchBonus {
    [CardGameSettings setValue:@(setCardMatchBonus) forKey:SetGameViewControllerMatchBonusKey];
    self.setCardMatchBonusLabel.text = [NSString stringWithFormat:@"Match Bonus: %d", setCardMatchBonus];
    self.setCardMatchBonusStepper.value = setCardMatchBonus;
}

- (int)setCardMismatchPenalty {
    return [CardGameSettings integerValueForKey:SetGameViewControllerMisMatchPenaltyKey];
}

- (void)setSetCardMismatchPenalty:(int)setCardMismatchPenalty {
    [CardGameSettings setValue:@(setCardMismatchPenalty) forKey:SetGameViewControllerMisMatchPenaltyKey];
    self.setCardMismatchPenaltyLabel.text = [NSString stringWithFormat:@"Mismatch Penalty: %d", setCardMismatchPenalty];
    self.setCardMismatchPenaltyStepper.value = setCardMismatchPenalty;
}

- (IBAction)updateTwoCardFlipCost:(UIStepper *)sender {
    self.twoCardFlipCost = sender.value;
}

- (IBAction)updateTwoCardMatchBonus:(UIStepper *)sender {
    self.twoCardMatchBonus = sender.value;
}

- (IBAction)updateTwoCardMismatchPenalty:(UIStepper *)sender {
    self.twoCardMismatchPenalty = sender.value;
}

- (IBAction)updateSetCardFlipCost:(UIStepper *)sender {
    self.setCardFlipCost = sender.value;
}

- (IBAction)updateSetCardMatchBonus:(UIStepper *)sender {
    self.setCardMatchBonus = sender.value;
}

- (IBAction)updateSetCardMismatchPenalty:(UIStepper *)sender {
    self.setCardMismatchPenalty = sender.value;
}

- (void)viewDidLoad {
    /* Reload all the values so that they appear correctly */
    self.twoCardFlipCost = self.twoCardFlipCost;
    self.twoCardMatchBonus = self.twoCardMatchBonus;
    self.twoCardMismatchPenalty = self.twoCardMismatchPenalty;
    
    self.setCardFlipCost = self.setCardFlipCost;
    self.setCardMatchBonus = self.setCardMatchBonus;
    self.setCardMismatchPenalty = self.setCardMismatchPenalty;
}


@end
