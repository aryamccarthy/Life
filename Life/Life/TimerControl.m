//
//  TimerControl.m
//  Life
//
//  Created by Arya McCarthy on 12/9/14.
//  Copyright (c) 2014 Arya McCarthy. All rights reserved.
//

#import "TimerControl.h"
#import "TimerControlButton.h"

typedef NS_ENUM(NSUInteger, TimerControlMode) {
  TimerControlModePaused,
  TimerControlModeSlow,
  TimerControlModeFast,
};

@interface TimerControl ()
@property (weak, nonatomic) UIBarButtonItem *control;
@property (weak, nonatomic) id target;
@property (nonatomic) SEL selector;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) TimerControlMode mode;
@end

@implementation TimerControl

- (TimerControlMode)mode
{
  if (!_mode) {
    _mode = TimerControlModePaused;
  }
  return _mode;
}

- (void)alterMode:(UIBarButtonItem *)sender
{
  self.control = sender;
  if (self.mode == TimerControlModePaused) {
    [self enterFastMode];
  } else if (self.mode == TimerControlModeFast) {
    [self enterSlowMode];
  } else if (self.mode == TimerControlModeSlow) {
    [self enterPausedMode];
  }
}

- (void)enterPausedMode
{
  self.mode = TimerControlModePaused;

  [self.timer invalidate];
  self.timer = nil;

  NSLog(@"Paused.");
  if ([self.control isKindOfClass:[TimerControlButton class]]) {
    TimerControlButton *tc = (TimerControlButton *)self.control;
    tc.title = [TimerControlButton pausedTitle];
  }
}

- (void)enterFastMode
{
  self.mode = TimerControlModeFast;

  [self.timer invalidate];
  self.timer = [NSTimer timerWithTimeInterval:0.2f target:self.target selector:self.selector userInfo:nil repeats:YES];
  [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
  NSLog(@"Fast.");

  if ([self.control isKindOfClass:[TimerControlButton class]]) {
    TimerControlButton *tc = (TimerControlButton *)self.control;
    tc.title = [TimerControlButton fastTitle];
  }
}

- (void)enterSlowMode
{
  self.mode = TimerControlModeSlow;

  [self.timer invalidate];
  self.timer = [NSTimer timerWithTimeInterval:1.0f target:self.target selector:self.selector userInfo:nil repeats:YES];
  [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
  NSLog(@"Slow.");

  if ([self.control isKindOfClass:[TimerControlButton class]]) {
    TimerControlButton *tc = (TimerControlButton *)self.control;
    tc.title = [TimerControlButton slowTitle];
  }
}

- (void)setTarget:(id)target selector:(SEL)selector
{
  self.target = target;
  self.selector = selector;
}
@end
