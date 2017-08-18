//
//  DensityViewController.h
//  DensityCalculator
//
//  Created by Gene Backlin on 1/17/12.
//  Copyright (c) 2012 MariZack Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Calculator;

@interface DensityViewController : UITableViewController
@property (strong, nonatomic) Calculator *calculator;
@property (weak, nonatomic) IBOutlet UITableViewCell *weightTableViewCell;
@property (weak, nonatomic) UITableViewCell *tableViewCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *densityTableViewCell;

@end
