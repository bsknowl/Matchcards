//
//  CardMatchingGame.m
//  MatchCards
//
//  Created by BRIAN KNOWLTON on 12/17/13.
//  Copyright (c) 2013 edu.ucdavis@bsknowlton. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of card
@property (nonatomic, strong) NSArray *lastChosenCards;
@property (nonatomic, readwrite) NSInteger lastScore;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (NSUInteger)maxMatchingCards
{
    if(_maxMatchingCards < 2)
    {
        _maxMatchingCards = 2;
    }
    return _maxMatchingCards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init]; // super's designated initializer
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) { // checks if card not nil. Will crash if is nil!
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
    
}


static const int MISMATCH_PENALTY = 1;
static const int MATCH_BONUS = 5;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    // card to be chosen named card
    Card *card = [self cardAtIndex:index];
    
    // if card is not matched
    // i.e. only allow cards that are not matched to be chosen
    if (!card.isMatched)
    {
        if (card.isChosen)
        {
            card.chosen = NO;
        } else {
            NSMutableArray *otherCards = [NSMutableArray array];
            for (Card *otherCard in self.cards)
            {
                if (otherCard.isChosen && !otherCard.isMatched)
                {
                    [otherCards addObject:otherCard];
                }
            }
                    self.lastScore = 0;
                    self.lastChosenCards = [otherCards arrayByAddingObject:card];
                    if([otherCards count] + 1 == self.maxMatchingCards)
                    {
                        int matchScore = [card match:otherCards];
                        if (matchScore) {
                            self.lastScore = matchScore * MATCH_BONUS;
                            card.matched = YES;
                            for (Card *otherCard in otherCards)
                            {
                                otherCard.matched = YES;
                            }
                        } else {
                            self.lastScore = - MISMATCH_PENALTY;
                            //card.chosen = NO;
                            for (Card *otherCard in otherCards) {
                                otherCard.matched = NO;
                              //  card.chosen = NO;
                                otherCard.chosen = NO;
                            }
                            
                        }
                    }
            self.score += self.lastScore - COST_TO_CHOOSE;
            card.chosen = YES;
        }
        
    }
    /*
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            // match against other chosen cards
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        // mark both as matched when matched.
                        otherCard.matched = YES;
                        card.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;
                }
            }
            
            
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
        
    }
     */
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards
    [index] : nil;
}
@end
