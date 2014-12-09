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

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.navigationController.navigationBar.translucent = YES;
  for (int i = 0; i < self.model.size.height; ++i) {
    for (int j = 0; j < self.model.size.width; ++j) {
      UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(8 * j, 8 * i, 8, 8)];
      cell.backgroundColor = self.view.window.tintColor;//[UIColor colorWithRed:13/255.0 green:112/255.0 blue:0/255.0 alpha:1.0];
      cell.alpha = [[self.model valueAtRow:i and:j] doubleValue]/kMaxAge;
      [self.container addSubview:cell];
    }
  }
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
  [self.model update];
  [self matchDisplayToModel];
}

- (void)matchDisplayToModel
{
  for (UIView *view in self.container.subviews)
  {
    NSUInteger row = view.frame.origin.y / 8;
    NSUInteger col = view.frame.origin.x / 8;
    view.alpha = [[self.model valueAtRow:row and:col] doubleValue] / kMaxAge;
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
  NSLog(@"Tapped.");
  [self.model update];
  NSLog(@"%@", self.model.description);
}
@end
