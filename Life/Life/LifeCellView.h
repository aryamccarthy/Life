//
//  LifeCellView.h
//  Life
//
//  Created by Arya McCarthy on 12/9/14.
//  Copyright (c) 2014 Arya McCarthy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LifeCellView : UIView
- (void)setAge:(NSNumber *)age;
- (instancetype)initForRow:(NSUInteger)row andCol:(NSUInteger)col;
@end
