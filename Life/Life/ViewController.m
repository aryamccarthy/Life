//
//  ViewController.m
//  Life
//
//  Created by Arya McCarthy on 12/8/14.
//  Copyright (c) 2014 Arya McCarthy. All rights reserved.
//

#import "ViewController.h"
#import "LifeModel.h"
#import "LifeConstants.h"
#import "BasicLifeModel.h"
#import "LifeViewControllerProtocol.h"
#import "TimerDelegate.h"
#import "TimerControl.h"
#import "TimerControlButton.h"

@interface ViewController ()
@property (strong, nonatomic) id<TimerDelegate> timer;
@property (weak, nonatomic) id<LifeViewControllerProtocol> lifeVC;
@end

@implementation ViewController

- (id<TimerDelegate>)makeTimer
{
  id<TimerDelegate> timer = [[TimerControl alloc] init];
  [timer setTarget:self selector:@selector(update)];
  return timer;
}

- (id<TimerDelegate>)timer
{
  if (!_timer) {
    _timer = [self makeTimer];
  }
  return _timer;
}

- (id<LifeViewControllerProtocol>)lifeVC
{
  if (!_lifeVC) {
    _lifeVC = [[self childViewControllers] firstObject];
  }
  return _lifeVC;
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

- (IBAction)speedButtonPressed:(TimerControlButton *)sender {
  [self.timer setControl:sender];
  [self.timer alterMode];
}

- (IBAction)resetPressed:(UIBarButtonItem *)sender {
  [self reset];
}

- (IBAction)tapped:(UITapGestureRecognizer *)sender {
  [self update];
}

- (void)reset {
  [self.lifeVC reset];
}

- (void)update {
  if (self.navigationController.visibleViewController == self) {
    [self.lifeVC update];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
