//
//  BasicLifeModel.m
//  Life
//
//  Created by Arya McCarthy on 12/8/14.
//  Copyright (c) 2014 Arya McCarthy. All rights reserved.
//

#import "BasicLifeModel.h"
#import "Grid.h"
#import "LifeConstants.h"
#import <UIKit/UIKit.h>

@interface BasicLifeModel ()
@property (nonatomic, strong) Grid *board;
@end

@implementation BasicLifeModel

- (Grid *)board
{
  if (!_board) {
    _board = [[Grid alloc] initWithRandomValues];
  }
  return _board;
}

- (void)update
{
  Grid *newBoard = [[Grid alloc] init];
  for (NSUInteger i = 0; i < newBoard.rows; ++i) {
    for (NSUInteger j = 0; j < newBoard.cols; ++j) {
      NSUInteger neighbors = [self.board countNeighbors:i and:j];
      NSNumber *age = [self.board elementAt:i and:j];
      switch (neighbors) {
        case 2:
          if (age < [NSNumber numberWithUnsignedInteger:kMaxAge]) {
            NSUInteger rawAge = [age unsignedIntegerValue];
            rawAge += (rawAge != 0) ? 1 : 0;
            [newBoard setElementAt:i
                               and:j
                                to:[NSNumber numberWithUnsignedInteger:rawAge]];
          }
          break;
        case 3:
          if (age < [NSNumber numberWithUnsignedInteger:kMaxAge]) {
            NSUInteger rawAge = [age unsignedIntegerValue];
            rawAge += 1;
            [newBoard setElementAt:i
                               and:j
                                to:[NSNumber numberWithUnsignedInteger:rawAge]];
          }
          break;
        default:
          [newBoard setElementAt:i and:j to:@0];
          break;
      }
    }
  }
  self.board = newBoard;
}

- (CGSize)size
{
  return CGSizeMake(self.board.cols, self.board.rows);
}

- (NSNumber *)valueAtRow:(NSUInteger)row and:(NSUInteger)col
{
  return [self.board elementAt:row and:col];
}

- (NSString *)description
{
  NSString *output = @"\n";
  for (int i = 0; i < self.board.rows; ++i) {
    output = [output stringByAppendingString:@" "];
    for (int j = 0; j < self.board.cols; ++j) {
      NSNumber *age = [self.board elementAt:i and:j];
      output = [output stringByAppendingString:[age stringValue]];
      NSString *spacer = [age unsignedIntegerValue] > 9 ? @" " : @"  ";
      output = [output stringByAppendingString:spacer];
    }
    output = [output stringByAppendingString:@"\n"];
  }
  return output;
}
@end
