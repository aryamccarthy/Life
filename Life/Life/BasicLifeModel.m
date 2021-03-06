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

- (instancetype)initWithRows:(NSUInteger)rows cols:(NSUInteger)cols
{
  self = [super init];
  if (self) {
    [self setBoard:[[Grid alloc] initWithRows:rows columns:cols]];
    [self.board randomize];
  }
  return self;
}

- (Grid *)board
{
  if (!_board) {
    _board = [[Grid alloc] initWithRandomValues];
  }
  return _board;
}

- (void)update
{
  Grid *newBoard = [[Grid alloc] initWithRows:self.board.rows columns:self.board.cols];
  for (NSUInteger i = 0; i < newBoard.rows; ++i) {
    for (NSUInteger j = 0; j < newBoard.cols; ++j) {
      NSUInteger neighbors = [self.board countNeighbors:i and:j];
      NSNumber *age = [self.board elementAt:i and:j];
      NSUInteger rawAge = [age unsignedIntegerValue];
      switch (neighbors) {
        case 2:
          if (rawAge < kMaxAge && rawAge != 0) {
            rawAge += 1;
          }
          [newBoard setElementAt:i
                             and:j
                              to:[NSNumber numberWithUnsignedInteger:rawAge]];
          break;
        case 3:
          if (rawAge < kMaxAge) {
            rawAge += 1;
          }
          [newBoard setElementAt:i
                             and:j
                              to:[NSNumber numberWithUnsignedInteger:rawAge]];
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
