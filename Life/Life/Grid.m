//
//  Grid.m
//  Life
//
//  Created by Arya McCarthy on 12/8/14.
//  Copyright (c) 2014 Arya McCarthy. All rights reserved.
//

#import "Grid.h"

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
    //TODO set size of array.
  }
  return self;
}

- (instancetype)init
{
  return [self initWithRows:1 columns:1];
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

-(BOOL)inBounds:(NSUInteger)row and:(NSUInteger)col
{
  return row >= 0 && col >= 0 && row < self.rows && col < self.cols;
}



@end
