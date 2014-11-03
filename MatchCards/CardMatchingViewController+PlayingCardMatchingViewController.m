//
//  CardMatchingViewController+PlayingCardMatchingViewController.m
//  MatchCards
//
//  Created by BRIAN KNOWLTON on 10/22/14.
//  Copyright (c) 2014 edu.ucdavis@bsknowlton. All rights reserved.
//

#import "CardMatchingViewController+PlayingCardMatchingViewController.h"
#import "PlayingCardDeck.h"


@implementation PlayingCardMatchingViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

@end

