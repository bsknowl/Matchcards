//
//  CardMatchingViewController.m
//  MatchCards
//
//  Created by BRIAN KNOWLTON on 12/13/13.
//  Copyright (c) 2013 edu.ucdavis@bsknowlton. All rights reserved.
//

#import "CardMatchingViewController.h"
#import "CardMatchingGame.h"
#import "HistoryCardMatchingViewController.h"

@interface CardMatchingViewController ()

// private property
@property (strong, nonatomic) CardMatchingGame *game;


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *toggleSwitch;
@property (strong, nonatomic) IBOutlet UISlider *UIHistoryTextSlider;



@end


@implementation CardMatchingViewController


- (NSMutableArray *)flipHistory
{
    if (!_flipHistory) {
        _flipHistory = [NSMutableArray array];
    }
    return _flipHistory;
}


- (CardMatchingGame *)game
{
    if (!_game){
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
        [self matchToggle:self.toggleSwitch];
    }
    return  _game;
}


- (Deck *)createDeck    // abstract and removed playingCard.h
{
    return nil;
}


// deals new game
- (IBAction)gameRedealButton:(UIButton *)sender
{
    self.game = nil;
    self.toggleSwitch.enabled = YES;
    self.flipHistory = nil;
    [self updateUI];
}


- (IBAction)matchToggle:(UISegmentedControl *)sender
{
    self.game.maxMatchingCards = [[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] integerValue];
}


- (void)setSliderRange
{
    NSInteger maxVal = [self.flipHistory count] - 1;
    self.UIHistoryTextSlider.maximumValue = maxVal;
    [self.UIHistoryTextSlider setValue:maxVal animated:YES];
    
}


- (IBAction)changeSlider:(UISlider *)sender
{
    NSInteger sliderVal;
    sliderVal = lroundf(self.UIHistoryTextSlider.value);
    [self.UIHistoryTextSlider setValue:sliderVal animated:NO];
    
    if ([self.flipHistory count]) {
        self.flipDescription.alpha = (sliderVal + 1 < [self.flipHistory count]) ? 0.6 : 1.0;
        self.flipDescription.text = [self.flipHistory objectAtIndex:sliderVal];
    }
}


- (IBAction)cardFlip:(UIButton *)sender {
    NSInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    self.toggleSwitch.enabled = NO;
    [self updateUI];
}

- (void)updateUI
{
   
    for (UIButton *cardButton in self.cardButtons) {
        NSInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
      //  self.toggleSwitch.enabled = NO;
        
        
    }
    
    
    self.scoreLabel.text = [NSString stringWithFormat:@"score: %ld", (long)self.game.score];
    
    if(self.game)
    {
        NSString *description = @"";
        
        if([self.game.lastChosenCards count])
        {
            NSMutableArray *cardContents = [NSMutableArray array];
            for (Card *card in self.game.lastChosenCards)
            {
                [cardContents addObject:card.contents];
            }
            description = [cardContents componentsJoinedByString:@" "];
        }
        
        if (self.game.lastScore > 0)
        {
            description = [NSString stringWithFormat:@"Matched %@ for %ld points.", description, (long)self.game.lastScore];
        } else if (self.game.lastScore < 0 )
        {
            description = [NSString stringWithFormat:@"%@ don't match! %ld point penalty", description, (long)-self.game.lastScore];
        }
        
        self.flipDescription.text = description;
        self.flipDescription.alpha = 1;
        
        if(![description isEqualToString:@""] && ![[self.flipHistory lastObject] isEqualToString:description])
        {
            [self.flipHistory addObject:description];
            [self setSliderRange];
        }
    }
    
}


- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}


- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ?@"CardFront" : @"CardBack"];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Card History"])
    {
        if([segue.destinationViewController isKindOfClass:[HistoryCardMatchingViewController class]])
        {
            [segue.destinationViewController setTextHistory:self.flipHistory];
        }
        
    }
}

@end
