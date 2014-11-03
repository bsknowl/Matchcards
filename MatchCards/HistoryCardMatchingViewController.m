//
//  HistoryCardMatchingViewController.m
//  MatchCards
//
//  Created by BRIAN KNOWLTON on 10/23/14.
//  Copyright (c) 2014 edu.ucdavis@bsknowlton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HistoryCardMatchingViewController.h"

@interface HistoryCardMatchingViewController ()

@property (weak, nonatomic) IBOutlet UITextView *UIHistoryTextView;

@end


@implementation HistoryCardMatchingViewController

// setter for textHistory
- (void)setTextHistory:(NSMutableArray *)textHistory
{
    _textHistory = textHistory;
    if (self.view.window) [self updateUI];
}

// make sure UI is nsync :)
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}


// loads & updates UI
- (void)updateUI
{
    
  if([[self.textHistory firstObject] isKindOfClass:[NSAttributedString class]])
  {
      NSMutableAttributedString *history = [[NSMutableAttributedString alloc] init];
      int i = 1;
      for (NSAttributedString *line in self.textHistory)
      {
          [history appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%2d: ", i++]]];
          [history appendAttributedString:line];
          [history appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n" ] ];
      }
      UIFont *fnt = [self.UIHistoryTextView.textStorage attribute:NSFontAttributeName atIndex:0 effectiveRange:NULL];
      [history addAttribute:NSFontAttributeName value:fnt range:NSMakeRange(0, history.length)];
      self.UIHistoryTextView.attributedText = history;
  }else {
      NSString *history = @"";
      int i = 1;
      for (NSString *line in self.textHistory)
      {
          history = [NSString stringWithFormat:@"%@%2d: %@\n\n", history, i++, line];
      }
      self.UIHistoryTextView.text = history;
  }
    
}




@end