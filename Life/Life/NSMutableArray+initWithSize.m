//
//  NSMutableArray+initWithSize.m
//  Life
//
//  Created by Arya McCarthy on 12/8/14.
//  Copyright (c) 2014 Arya McCarthy. All rights reserved.
//

#import "NSMutableArray+initWithSize.h"

@implementation NSMutableArray (initWithSize)
- (instancetype)initWithSize:(NSUInteger)size
{
  self = [self init];
  for (NSUInteger i = 0; i < size; ++i) {
    [self addObject:@0];
  }
  return self;
}
@end
