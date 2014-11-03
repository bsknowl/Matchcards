//
//  Deck.h
//  MatchCards
//
//  Created by BRIAN KNOWLTON on 12/14/13.
//  Copyright (c) 2013 edu.ucdavis@bsknowlton. All rights reserved.
//

#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
