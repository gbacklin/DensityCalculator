//
//  MasterViewController.h
//  DensityCalculator
//
//  Created by Gene Backlin on 1/17/12.
//  Copyright (c) 2012 MariZack Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Calculator;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) Calculator *calculator;
@property (weak, nonatomic) IBOutlet UITableViewCell *volumeTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *densityTableViewCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *radiationRatioTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *speedOfSoundTableViewCell;
@end
