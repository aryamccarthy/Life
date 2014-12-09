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

#pragma mark Initializers
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

- (instancetype)initWithRandomValues
{
  self = [self init];
  [self randomize];
  return self;
}

#pragma mark Setters and Getters

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

#pragma mark Indexing

- (NSNumber *)elementAt:(NSUInteger)row and:(NSUInteger)col
{
  if (![self inBounds:row and:col]) {
    return @0;
  }
  return self.elements[row * self.cols + col];
}

- (void)setElementAt:(NSUInteger)row and:(NSUInteger)col to:(NSNumber *)value;
{
  if ([self inBounds:row and:col]) {
    self.elements[row * self.cols + col] = value;
  }
}

#pragma mark Helpers

- (void)randomize
{
  for (NSUInteger i = 0; i < [self.elements count]; ++i) {
    self.elements[i] = [NSNumber numberWithInteger:(arc4random() % 2)];
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
