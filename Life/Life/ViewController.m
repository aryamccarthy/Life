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

@interface ViewController ()
//@property (nonatomic, strong) id<LifeModel> model;
@property (weak, nonatomic) IBOutlet UIView *containerView;
//@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *speedLabel;
@property (strong, nonatomic) id<TimerDelegate> timer;
@property (weak, nonatomic) id<LifeViewControllerProtocol> lifeVC;
@end

@implementation ViewController

- (id<TimerDelegate>)makeTimer
{
  id<TimerDelegate> timer = [[TimerControl alloc] init];
  [timer setTarget:self selector:@selector(update)];
  [timer setControl:self.speedLabel];
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

/*- (id<LifeModel>)model
{
  if (!_model) {
    _model = [[BasicLifeModel alloc] init];
  }
  return _model;
}*/

/*- (void)initializeGrid {
  // Do any additional setup after loading the view, typically from a nib.
  UIColor *baseColor = colorFromRGB(13, 112, 0);
  for (int i = 0; i < self.model.size.height; ++i) {
    for (int j = 0; j < self.model.size.width; ++j) {
      NSUInteger age = [[self.model valueAtRow:i and:j] unsignedIntegerValue];

      UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(kCellDimension * j, kCellDimension * i, kCellDimension, kCellDimension)];
      //cell.backgroundColor = self.colors[age];
      cell.backgroundColor = baseColor;
      cell.alpha = age == 0 ? 0 : 1 - pow((age-1.0)/kMaxAge, 0.5);
      [self.containerView addSubview:cell];
    }
  }
}*/

- (void)viewDidLoad {
  [super viewDidLoad];
  NSLog(@"%@", [[[self childViewControllers] firstObject] description]);
//  [self initializeGrid];
//  [self speedButtonPressed:self.speedLabel];
}

- (IBAction)speedButtonPressed:(UIBarButtonItem *)sender {
  [self.timer alterMode:sender];
}
/*- (IBAction)speedButtonPressed:(UIBarButtonItem *)sender {
  if ([sender.title isEqualToString:@"Slow"]) {
    sender.title = @"Fast";
    [self.timer invalidate];
    self.timer = [NSTimer timerWithTimeInterval:0.25f target:self selector:@selector(update) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
  }
  else if ([sender.title isEqualToString:@"Fast"]) {
    sender.title = @"Paused";
    [self.timer invalidate];
    self.timer = nil;
  }
  else if ([sender.title isEqualToString:@"Paused"]) {
    sender.title = @"Slow";
    [self.timer invalidate];
    self.timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(update) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
  }
}*/

/*- (IBAction)resetPressed:(UIBarButtonItem *)sender {
  self.model = [[BasicLifeModel alloc] init];
  [self matchDisplayToModel];

}*/

/*- (IBAction)tapped:(UITapGestureRecognizer *)sender {
  [self update];
}*/

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


/*- (void)update
{
  if (self.navigationController.visibleViewController == self) {
    [self.model update];
    [self matchDisplayToModel];
    if ([self hasTerminated]) {
      [self.timer invalidate];
      UIAlertController *doneNotifier = [UIAlertController alertControllerWithTitle:@"Game over" message:@"The simulation will not update anymore from this point; hit Reset to start another round." preferredStyle:UIAlertControllerStyleAlert];
      UIAlertAction *reset = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self resetPressed:nil];
        if (self.timer) {
          self.timer = [NSTimer timerWithTimeInterval:self.timer.timeInterval target:self selector:@selector(update) userInfo:nil repeats:YES];
          [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        }
      }];
      [doneNotifier addAction:reset];
      [self presentViewController:doneNotifier animated:YES completion:nil];
    }
  }
}

- (BOOL)hasTerminated
{
  for (UIView *view in self.containerView.subviews)
    if (view.alpha) {
      return false;
    }
  return true;
}

- (void)matchDisplayToModel
{
  for (UIView *view in self.containerView.subviews)
  {
    NSUInteger row = view.frame.origin.y / kCellDimension;
    NSUInteger col = view.frame.origin.x / kCellDimension;
    NSUInteger age = [[self.model valueAtRow:row and:col] unsignedIntegerValue];
    view.alpha = age == 0 ? 0 : 1 - pow((age-1.0)/kMaxAge, 0.5);
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}*/

@end
