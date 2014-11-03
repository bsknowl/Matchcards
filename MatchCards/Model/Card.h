//
//  Card.h
//  MatchCards
//
//  Created by BRIAN KNOWLTON on 12/14/13.
//  Copyright (c) 2013 edu.ucdavis@bsknowlton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter =  isMatched)
            BOOL matched;

- (int)match:(NSArray *)otherCards;


@end
