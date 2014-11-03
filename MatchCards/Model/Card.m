//
//  Card.m
//  MatchCards
//
//  Created by BRIAN KNOWLTON on 12/14/13.
//  Copyright (c) 2013 edu.ucdavis@bsknowlton. All rights reserved.
//

#import "Card.h"
@interface Card()

@end

@implementation Card

//@synthesize contents = _contents;
//@synthesize chosen = _chosen;
//@synthesize matched = _matched;

/*- (BOOL)chosen
{
    return _chosen;
}

- (void)setChosen:(BOOL)chosen
{
    _chosen = chosen;
}

- (BOOL)matched
{
    return _matched;
}

- (void)setMatched:(BOOL)matched
{
    _matched = matched;
}

- (NSString *)contents
{
    return _contents;
}

- (void)setContents:(NSString *)contents
{
    _contents = contents;
}
*/
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}
@end
