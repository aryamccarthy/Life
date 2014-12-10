//
//  Grid.h
//  Life
//
//  Created by Arya McCarthy on 12/8/14.
//  Copyright (c) 2014 Arya McCarthy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Grid : NSObject
@property (nonatomic, readonly) NSUInteger rows;
@property (nonatomic, readonly) NSUInteger cols;
- (instancetype)initWithRandomValues;
- (instancetype)initWithRows:(NSUInteger)rows columns:(NSUInteger)cols;
- (NSInteger)countNeighbors:(NSUInteger)row and:(NSUInteger)col;
- (NSNumber *)elementAt:(NSUInteger)row and:(NSUInteger)col;
- (void)setElementAt:(NSUInteger)row and:(NSUInteger)col to:(NSNumber *)value;
- (void)randomize;
@end
