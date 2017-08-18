//
//  LengthViewController.h
//  DensityCalculator
//
//  Created by Gene Backlin on 1/18/12.
//  Copyright (c) 2012 MariZack Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Calculator;

@interface LengthViewController : UIViewController

@property (strong, nonatomic) Calculator *calculator;
@property (weak, nonatomic) UITableViewCell *tableViewCell;;

@property (weak, nonatomic) IBOutlet UITextField *topLength;
@property (weak, nonatomic) IBOutlet UITextField *bottomLength;

@end
