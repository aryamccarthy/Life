//
//  LifeModel.h
//  Life
//
//  Created by Arya McCarthy on 12/9/14.
//  Copyright (c) 2014 Arya McCarthy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LifeModel <NSObject>
- (void)update;
- (CGSize)size;
- (NSNumber *)valueAtRow:(NSUInteger)row and:(NSUInteger)col;
@end
