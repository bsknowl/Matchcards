//
//  PlayingCard.m
//  MatchCards
//
//  Created by BRIAN KNOWLTON on 12/14/13.
//  Copyright (c) 2013 edu.ucdavis@bsknowlton. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

//override match
- (int)match:(NSArray *)otherCards
{
    
    int score = 0;
    NSUInteger numOtherCards = [otherCards count];
    
    
    if(numOtherCards == 1)
    {
        for (Card *card in otherCards)
        {
            if([card isKindOfClass:[PlayingCard class]])
            {
                PlayingCard *otherCard = (PlayingCard *)card;
                if([self.suit isEqualToString:otherCard.suit])
                {
                    score += 1;
                } else if (self.rank == otherCard.rank)
                {
                    score += 4;
                }
            }
        }
    }
    if(numOtherCards > 1)
    {
        score += [[otherCards firstObject] match:[otherCards subarrayWithRange:NSMakeRange(1, numOtherCards - 1)]];
    }
    /*
    
    if ([otherCards count] == 1) {
        // gets the first object whether nil or contains object
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        } else if([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        }
 
    } else if ([otherCards count] == 2){
        PlayingCard *firstCard = [otherCards objectAtIndex:0];
        PlayingCard *secondCard = [otherCards objectAtIndex:1];
        
        if ((firstCard.rank == self.rank) && (secondCard.rank == self.rank)) {
            score = 24;
        } else if ((firstCard.rank == self.rank) && [secondCard.suit isEqualToString:self.suit]){
            score = 5;
        } else if ([firstCard.suit isEqualToString:self.suit] && (secondCard.rank == self.rank)){
            score = 5;
        } else if ((firstCard.rank) == self.rank || (secondCard.rank == self.rank)){
            score = 4;
        } else if ([firstCard.suit isEqualToString:self.suit] && [secondCard.suit isEqualToString:self.suit]){
            score = 3;
        }  else if ([firstCard.suit isEqualToString:self.suit] || [secondCard.suit isEqualToString:self.suit]) {
            score = 1;
        }
        
    }
    */
    return score;
}

// synthesize needed values
@synthesize suit = _suit;

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank{ return [[self rankStrings] count]-1;}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}
@end
