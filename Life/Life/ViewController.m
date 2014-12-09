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

@interface ViewController ()
@property (nonatomic, strong) LifeModel *model;
@property (weak, nonatomic) IBOutlet UIView *container;
@property (strong, nonatomic) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *speedLabel;
@end

@implementation ViewController

- (LifeModel *)model
{
  if (!_model) {
    _model = [[BasicLifeModel alloc] init];
  }
  return _model;
}

- (void)initializeGrid {
  // Do any additional setup after loading the view, typically from a nib.
  UIColor *baseColor = [UIColor colorWithRed:13/255.0
                                      green:112/255.0
                                       blue:0/255.0
                                      alpha:1.0];
  for (int i = 0; i < self.model.size.height; ++i) {
    for (int j = 0; j < self.model.size.width; ++j) {
      double age = (double)[[self.model valueAtRow:i and:j] unsignedIntegerValue];

      UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(kCellDimension * j, kCellDimension * i, kCellDimension, kCellDimension)];
      cell.backgroundColor = baseColor;
      cell.alpha = age == 0 ? 0 : 1 - age/kMaxAge;
      [self.container addSubview:cell];
    }
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self initializeGrid];
  [self speedButtonPressed:self.speedLabel];
}

- (IBAction)speedButtonPressed:(UIBarButtonItem *)sender {
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
}

- (IBAction)resetPressed:(UIBarButtonItem *)sender {
  self.model = [[BasicLifeModel alloc] init];
  [self matchDisplayToModel];

}

- (IBAction)tapped:(UITapGestureRecognizer *)sender {
  [self update];
}

- (void)update
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
  for (UIView *view in self.container.subviews)
    if (view.alpha) {
      return false;
    }
  return true;
}

- (void)matchDisplayToModel
{
  for (UIView *view in self.container.subviews)
  {
    NSUInteger row = view.frame.origin.y / kCellDimension;
    NSUInteger col = view.frame.origin.x / kCellDimension;
    double age = (double)[[self.model valueAtRow:row and:col] unsignedIntegerValue];
    view.alpha = age == 0 ? 0 : 1 - age/kMaxAge;
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
