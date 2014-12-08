//
//  Grid.m
//  Life
//
//  Created by Arya McCarthy on 12/8/14.
//  Copyright (c) 2014 Arya McCarthy. All rights reserved.
//

#import "Grid.h"
#import "LifeConstants.h"
#import "NSMutableArray+initWithSize.h"

@interface Grid ()
@property (nonatomic, strong) NSMutableArray *elements;
@property (nonatomic) NSUInteger rows;
@property (nonatomic) NSUInteger cols;
@end

@implementation Grid
- (instancetype)initWithRows:(NSUInteger)rows columns:(NSUInteger)cols
{
  self = [super init];
  if (self) {
    self.rows = rows;
    self.cols = cols;
    self.elements = [[NSMutableArray alloc]
                     initWithSize:(self.rows * self.cols)];
  }
  return self;
}

- (instancetype)init
{
  return [self initWithRows:kNumRows columns:kNumCols];
}

- (void)setRows:(NSUInteger)rows
{
  if (rows != 0) {
    _rows = rows;
  }
}

- (void)setCols:(NSUInteger)cols
{
  if (cols != 0) {
    _cols = cols;
  }
}

- (NSNumber *)elementAt:(NSUInteger)row and:(NSUInteger)col
{
  if (![self inBounds:row and:col]) {
    return @0;
  }
  return self.elements[row * self.rows + self.cols];
}

- (void)setElementAt:(NSUInteger)row and:(NSUInteger)col to:(NSNumber *)value;
{
  if ([self inBounds:row and:col]) {
    self.elements[row * self.rows + self.cols] = value;
  }
}

- (BOOL)inBounds:(NSUInteger)row and:(NSUInteger)col
{
  return /*row >= 0 && col >= 0 &&*/ row < self.rows && col < self.cols;
}

-(NSInteger)countNeighbors:(NSUInteger)row and:(NSUInteger)col
{
  NSInteger count = 0;
  for (int dRow = -1; dRow <= 1; ++dRow) {
    for (int dCol = -1; dCol <= 1; ++dCol) {
      if (!(dCol == 0 && dRow == 0)) {
        count += [self isCellOccupied:row+dRow and:col+dCol];
      }
    }
  }
  return count;
}

-(BOOL)isCellOccupied:(NSUInteger)row and:(NSUInteger)col
{
  return [self inBounds:row and:col] && (![[self elementAt:row and:col] isEqualToNumber:@0]);
}

@end
