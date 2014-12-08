//
//  ViewController.m
//  Life
//
//  Created by Arya McCarthy on 12/8/14.
//  Copyright (c) 2014 Arya McCarthy. All rights reserved.
//

#import "ViewController.h"
#import "LifeModel.h"
#import "BasicLifeModel.h"

@interface ViewController ()
@property (nonatomic, strong) LifeModel *model;
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
