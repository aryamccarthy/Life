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
@property (strong, nonatomic) NSMutableArray *cells; // of UIView
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
  for (int i = 0; i < self.model.size.height; ++i) {
    for (int j = 0; j < self.model.size.width; ++j) {
      UIView *cell = [[UIView alloc] initWithFrame:CGRectMake(8 * j, 8 * i, 8, 8)];
      cell.backgroundColor = [UIColor colorWithRed:13/255.0 green:112/255.0 blue:0/255.0 alpha:1.0];
      //cell.opaque = NO;
      cell.alpha = [[self.model valueAtRow:i and:j] doubleValue]/kMaxAge;
      [self.container addSubview:cell];
    }
  }
  NSTimer* timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(update) userInfo:nil repeats:YES];
  [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
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
