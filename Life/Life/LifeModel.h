//
//  LifeModel.h
//  Life
//
//  Created by Arya McCarthy on 12/8/14.
//  Copyright (c) 2014 Arya McCarthy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LifeModel : NSObject
- (void)update;
- (CGSize)size;
- (NSNumber *)valueAtRow:(NSUInteger)row and:(NSUInteger)col;
@end
