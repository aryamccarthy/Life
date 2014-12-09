//
//  LifeCollectionViewController.m
//  Life
//
//  Created by Arya McCarthy on 12/8/14.
//  Copyright (c) 2014 Arya McCarthy. All rights reserved.
//

#import "LifeCollectionViewController.h"
#import "LifeModel.h"
#import "BasicLifeModel.h"

@interface LifeCollectionViewController ()
@property (nonatomic, strong) LifeModel *model;
@end

@implementation LifeCollectionViewController
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return self.model.size.width * self.model.size.height;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
  UILabel *label = [[UILabel alloc] initWithFrame:cell.bounds];
  label.textAlignment = NSTextAlignmentCenter;
  label.text = [NSString stringWithFormat:@"%lu", indexPath.row];
  [cell.contentView addSubview:label];
  return cell;
}

@end
