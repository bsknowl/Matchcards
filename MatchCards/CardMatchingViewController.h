      
//
//  CardMatchingViewController.h
//  MatchCards
//
//  Created by BRIAN KNOWLTON on 12/13/13.
//  Copyright (c) 2013 edu.ucdavis@bsknowlton. All rights reserved.
//
// Abstract Class PlayingCard.h

#import <UIKit/UIKit.h>
#include "Deck.h"

@interface CardMatchingViewController : UIViewController


- (Deck *)createDeck;   // abstract

- (void)updateUI;


@property (strong, nonatomic) NSMutableArray *flipHistory;
@property (weak, nonatomic) IBOutlet UITextView *flipDescription;

@end
