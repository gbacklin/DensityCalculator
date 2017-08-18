//
//  ThicknessViewController.h
//  DensityCalculator
//
//  Created by Gene Backlin on 1/18/12.
//  Copyright (c) 2012 MariZack Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Calculator;

@interface ThicknessViewController : UIViewController

@property (strong, nonatomic) Calculator *calculator;
@property (weak, nonatomic) UITableViewCell *tableViewCell;
@property (weak, nonatomic) IBOutlet UITextField *topLeftTextField;
@property (weak, nonatomic) IBOutlet UITextField *topCenterTextField;
@property (weak, nonatomic) IBOutlet UITextField *topRightTextField;
@property (weak, nonatomic) IBOutlet UITextField *bottomLeftTextField;
@property (weak, nonatomic) IBOutlet UITextField *bottomCenterTextField;
@property (weak, nonatomic) IBOutlet UITextField *bottomRightTextField;
@property (weak, nonatomic) IBOutlet UITextField *centerLeftTextField;
@property (weak, nonatomic) IBOutlet UITextField *centerCenterTextField;
@property (weak, nonatomic) IBOutlet UITextField *centerRightTextField;

@end
