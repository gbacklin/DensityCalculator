//
//  WeightViewController.m
//  DensityCalculator
//
//  Created by Gene Backlin on 1/20/12.
//  Copyright (c) 2012 MariZack Consulting. All rights reserved.
//

#import "WeightViewController.h"
#import "Calculator.h"

@implementation WeightViewController
@synthesize calculator;
@synthesize tableViewCell;
@synthesize weightTextField;

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
    [[self weightTextField] setText:[[calculator weight] stringValue]];
    [[self weightTextField] becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    double density = [[[self weightTextField] text] doubleValue] / [[[self calculator] volume] doubleValue];
    
    [[self calculator] setDensity:[NSNumber numberWithDouble:density]];
    [[self calculator] setWeight:[NSNumber numberWithDouble:[[[self weightTextField] text] doubleValue]]];
    [[[self tableViewCell] detailTextLabel] setText:[NSString stringWithFormat:@"%.2f", [[[self calculator] weight] doubleValue]]];
}


- (void)viewDidUnload
{
    [self setWeightTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
