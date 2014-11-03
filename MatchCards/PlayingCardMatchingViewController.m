//
//  PlayingCardMatchingViewController.m
//  MatchCards
//
//  Created by BRIAN KNOWLTON on 10/23/14.
//  Copyright (c) 2014 edu.ucdavis@bsknowlton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayingCardMatchingViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardMatchingViewController ()

@end

@implementation PlayingCardMatchingViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

@end

