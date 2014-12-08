//
//  NSMutableArray+initWithSize.h
//  Life
//
//  Created by Arya McCarthy on 12/8/14.
//  Copyright (c) 2014 Arya McCarthy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (initWithSize)
/*!
 * Return preallocated array of given size.
 *
 * Preferable to -initWithCapacity because you can index into every address,
 * rather than having to grow to the desired capacity first.
 */
- (instancetype)initWithSize:(NSUInteger)size;

@end
