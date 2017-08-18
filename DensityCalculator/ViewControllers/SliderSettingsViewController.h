//
//  SliderSettingsViewController.h
//  DensityCalculator
//
//  Created by Gene Backlin on 1/17/12.
//  Copyright (c) 2012 MariZack Consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Calculator;

@interface SliderSettingsViewController : UIViewController

@property (strong, nonatomic) Calculator *calculator;
@property (strong, nonatomic) UISlider *slider;
@property (weak, nonatomic) IBOutlet UITextField *sliderMinimumValueTextField;
@property (weak, nonatomic) IBOutlet UITextField *sliderMaximumValueTextField;

- (IBAction)done:(id)sender;
@end
