//
//  VolumeViewController.h
//  DensityCalculator
//
//  Created by Gene Backlin on 1/18/12.
//  Copyright (c) 2012 MariZack Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Calculator;

@interface VolumeViewController : UITableViewController

@property (strong, nonatomic) Calculator *calculator;
@property (weak, nonatomic) UITableViewCell *tableViewCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *lengthTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *widthTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *thicknessTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *volumeTableViewCell;

@end
