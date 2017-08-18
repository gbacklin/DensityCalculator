//
//  DensityViewController.m
//  DensityCalculator
//
//  Created by Gene Backlin on 1/17/12.
//  Copyright (c) 2012 MariZack Consulting. All rights reserved.
//

#import "DensityViewController.h"
#import "WeightViewController.h"
#import "Calculator.h"
#import "PropertyList.h"

@implementation DensityViewController
@synthesize calculator;
@synthesize weightTableViewCell;
@synthesize tableViewCell;
@synthesize densityTableViewCell;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[[self weightTableViewCell] detailTextLabel] setText:[NSString stringWithFormat:@"%.2f", [[[self calculator] weight] doubleValue]]];
    [[[self densityTableViewCell] detailTextLabel] setText:[NSString stringWithFormat:@"%.2f", [[[self calculator] density] doubleValue]]];

    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    [background setAutoresizingMask:UIViewAutoresizingNone];
    [[self tableView] setAutoresizingMask:UIViewAutoresizingNone];

    [[self tableView] setBackgroundView:background];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[[self weightTableViewCell] detailTextLabel] setText:[NSString stringWithFormat:@"%.2f", [[[self calculator] weight] doubleValue]]];
    [[[self densityTableViewCell] detailTextLabel] setText:[NSString stringWithFormat:@"%.4f", [[[self calculator] density] doubleValue]]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    double density = [[[self calculator] density] doubleValue];
    double speedOfSound = [[[self calculator] speedOfSoundValue] doubleValue];
    double radiationRatio = speedOfSound / (density * 1000);
    
    [[self calculator] setRadiationRatio:[NSNumber numberWithDouble:radiationRatio]];

    NSMutableDictionary *newCalc = [[NSMutableDictionary alloc] initWithCapacity:1];
    [newCalc setObject:[self calculator] forKey:@"calculator"];
    [PropertyList writePropertyListFromDictionary:@"Calculator" dictionary:newCalc];

    [[[self densityTableViewCell] detailTextLabel] setText:[NSString stringWithFormat:@"%.2f", [[[self calculator] density] doubleValue]]];
}

- (void)viewDidUnload
{
    [self setDensityTableViewCell:nil];
    [self setWeightTableViewCell:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"WeightSegue"])
    {
        WeightViewController *controller = segue.destinationViewController;
        [controller setCalculator:[self calculator]];
        [controller setTableViewCell:[self weightTableViewCell]];
    }
}

@end
