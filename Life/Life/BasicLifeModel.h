//
//  BasicLifeModel.h
//  Life
//
//  Created by Arya McCarthy on 12/8/14.
//  Copyright (c) 2014 Arya McCarthy. All rights reserved.
//

#import "LifeModel.h"

@interface BasicLifeModel : NSObject <LifeModel>
- (instancetype)initWithRows:(NSUInteger)rows cols:(NSUInteger)cols;
@end
