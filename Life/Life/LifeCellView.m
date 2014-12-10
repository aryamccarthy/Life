//
//  LifeCellView.m
//  Life
//
//  Created by Arya McCarthy on 12/9/14.
//  Copyright (c) 2014 Arya McCarthy. All rights reserved.
//

#import "LifeCellView.h"
#import "LifeConstants.h"

UIColor* colorFromRGB(NSUInteger r, NSUInteger g, NSUInteger b)
{
  return [UIColor colorWithRed:r/255.0 green:g/255.0 blue: b/255.0 alpha:1.0f];
}

@implementation LifeCellView

- (UIColor *)baseColor
{
  return colorFromRGB(13, 112, 0);
}

- (void)setAge:(NSNumber *)age
{
  NSUInteger rawAge = [age unsignedIntegerValue];
  self.alpha = rawAge == 0 ? 0 : 1 - pow((rawAge - 1.0)/kMaxAge, 0.5);
}

- (instancetype)initForRow:(NSUInteger)row andCol:(NSUInteger)col
{
  self = [super initWithFrame:CGRectMake(kCellDimension * row, kCellDimension * col, kCellDimension, kCellDimension)];
  if (self) {
    self.backgroundColor = [self baseColor];
  }
  return self;
}

@end
