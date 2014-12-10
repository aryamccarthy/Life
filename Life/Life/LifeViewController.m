//
//  LifeViewController.m
//  Life
//
//  Created by Arya McCarthy on 12/9/14.
//  Copyright (c) 2014 Arya McCarthy. All rights reserved.
//

#import "LifeViewController.h"
#import "LifeModel.h"
#import "BasicLifeModel.h"
#import "LifeConstants.h"
#import "LifeCellView.h"

@interface LifeViewController ()
@property (strong, nonatomic) id<LifeModel> model;
@end

@implementation LifeViewController

- (id<LifeModel>)makeModel
{
  [self.view setNeedsDisplay];
  [self.view layoutIfNeeded];
  NSUInteger rows = self.view.bounds.size.height / kCellDimension;
  NSUInteger cols = self.view.bounds.size.width / kCellDimension;
  NSLog(@"%@", self.view.superview.class);
  return [[BasicLifeModel alloc] initWithRows:rows cols:cols];
}

- (id<LifeModel>)model
{
  if (!_model)
    _model = [self makeModel];
  return _model;
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [self initializeGrid];
}

- (void)initializeGrid
{
  for (int i = 0; i < self.model.size.height; ++i) {
    for (int j = 0; j < self.model.size.width; ++j) {
      LifeCellView *cell = [[LifeCellView alloc] initForRow:j andCol:i];
      NSNumber *age = [self.model valueAtRow:i and:j];
      [cell setAge:age];
      [self.view addSubview:cell];
    }
  }
}

- (void)reset
{
  self.model = [self makeModel];
  [self matchDisplayToModel];
}

- (void)update
{
  [self.model update];
  [self matchDisplayToModel];
}

- (void)matchDisplayToModel
{
  for (UIView *view in self.view.subviews) {
    if ([view isKindOfClass:[LifeCellView class]]) {
      LifeCellView *lifeView = (LifeCellView *)view;
      NSUInteger row = lifeView.frame.origin.y / kCellDimension;
      NSUInteger col = lifeView.frame.origin.x / kCellDimension;
      NSNumber *age = [self.model valueAtRow:row and:col];
      [lifeView setAge:age];
    }
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
  //[self initializeGrid];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
