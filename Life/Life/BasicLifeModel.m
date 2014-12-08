//
//  BasicLifeModel.m
//  Life
//
//  Created by Arya McCarthy on 12/8/14.
//  Copyright (c) 2014 Arya McCarthy. All rights reserved.
//

#import "BasicLifeModel.h"
#import "Grid.h"

@interface BasicLifeModel ()
@property (nonatomic, strong) Grid *board;
@end

@implementation BasicLifeModel

- (Grid *)board
{
  if (!_board) {
    _board = [[Grid alloc] init];
  }
  return _board;
}

- (BOOL)update
{
  Grid *newBoard = [[Grid alloc] init];
  for (NSUInteger i = 0; i < newBoard.rows; ++i) {
    for (NSUInteger j = 0; j < newBoard.cols; ++j) {
      <#statements#>
    }
  }
}
@end
