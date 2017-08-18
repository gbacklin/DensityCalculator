//
//  SliderSettingsViewController.m
//  DensityCalculator
//
//  Created by Gene Backlin on 1/17/12.
//  Copyright (c) 2012 MariZack Consulting. All rights reserved.
//

#import "SliderSettingsViewController.h"
#import "Calculator.h"
@implementation SliderSettingsViewController

@synthesize calculator;
@synthesize slider;
@synthesize sliderMinimumValueTextField;
@synthesize sliderMaximumValueTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Slider Settings"];
    [[self sliderMinimumValueTextField] setText:[NSString stringWithFormat:@"%.2f", [[self slider] minimumValue]]];
    [[self sliderMaximumValueTextField] setText:[NSString stringWithFormat:@"%.2f", [[self slider] maximumValue]]];
}

- (void)viewDidUnload
{
    [self setSliderMinimumValueTextField:nil];
    [self setSliderMaximumValueTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)done:(id)sender {
    double minValue = [[[self sliderMinimumValueTextField] text] doubleValue];
    double maxValue = [[[self sliderMaximumValueTextField] text] doubleValue];
    
    [[self slider] setMinimumValue:minValue];
    [[self slider] setMaximumValue:maxValue];
    
    [[self calculator] setMinFrequency:[NSNumber numberWithDouble:minValue]];
    [[self calculator] setMaxFrequency:[NSNumber numberWithDouble:maxValue]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
