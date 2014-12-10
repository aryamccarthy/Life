//
//  TimerDelegate.h
//  Life
//
//  Created by Arya McCarthy on 12/9/14.
//  Copyright (c) 2014 Arya McCarthy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TimerDelegate <NSObject>
- (void)alterMode:(UIBarButtonItem *)sender;
- (void)setTarget:(id)target selector:(SEL)selector;
- (void)setControl:(UIBarButtonItem *)control;
@end
