//
//  MasterViewController.m
//  DensityCalculator
//
//  Created by Gene Backlin on 1/17/12.
//  Copyright (c) 2012 MariZack Consulting. All rights reserved.
//

#import "MasterViewController.h"
#import "DensityViewController.h"
#import "VolumeViewController.h"
#import "SpeedOfSoundViewController.h"

#import "Calculator.h"
#import "PropertyList.h"

@implementation MasterViewController

@synthesize calculator = _calculator;
@synthesize volumeTableViewCell = _volumeTableViewCell;
@synthesize densityTableViewCell = _densityTableViewCell;
@synthesize radiationRatioTableViewCell = _radiationRatioTableViewCell;
@synthesize speedOfSoundTableViewCell = _speedOfSoundTableViewCell;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [[self tableView] setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]]];
}

- (void)viewDidUnload
{
    [self setVolumeTableViewCell:nil];
    [self setDensityTableViewCell:nil];
    [self setRadiationRatioTableViewCell:nil];
    [self setSpeedOfSoundTableViewCell:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSDictionary *calc = [PropertyList dictionaryFromPropertyList:@"Calculator"];
    Calculator *calculate = [calc objectForKey:@"calculator"];
    if(!calculate) {
        calculate = [[Calculator alloc] init];
        NSMutableDictionary *newCalc = [[NSMutableDictionary alloc] initWithCapacity:1];
        [newCalc setObject:calculate forKey:@"calculator"];
        [PropertyList writePropertyListFromDictionary:@"Calculator" dictionary:newCalc];
    }
    
    [self setCalculator:calculate];

    [[[self volumeTableViewCell] detailTextLabel] setText:[NSString stringWithFormat:@"%.2f", [[[self calculator] volume] doubleValue]*10]];
    [[[self densityTableViewCell] detailTextLabel] setText:[NSString stringWithFormat:@"%.4f", [[[self calculator] density] doubleValue]]];
    [[[self speedOfSoundTableViewCell] detailTextLabel] setText:[NSString stringWithFormat:@"%.0f", [[[self calculator] speedOfSoundValue] doubleValue]]];
    [[[self radiationRatioTableViewCell] detailTextLabel] setText:[NSString stringWithFormat:@"%.2f", [[[self calculator] radiationRatio] doubleValue]]];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];

    NSMutableDictionary *newCalc = [[NSMutableDictionary alloc] initWithCapacity:1];
    [newCalc setObject:[self calculator] forKey:@"calculator"];
    [PropertyList writePropertyListFromDictionary:@"Calculator" dictionary:newCalc];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"VolumeSegue"])
    {
        VolumeViewController *controller = segue.destinationViewController;
        [controller setTableViewCell:[self volumeTableViewCell]];
        [controller setCalculator:[self calculator]];
    } else if([[segue identifier] isEqualToString:@"DensitySegue"]) {        
        DensityViewController *controller = segue.destinationViewController;
        [controller setTableViewCell:[self densityTableViewCell]];
        [controller setCalculator:[self calculator]];
    } else if([[segue identifier] isEqualToString:@"SpeedOfSoundSegue"]) {
        SpeedOfSoundViewController *controller = segue.destinationViewController;
        [controller setTableViewCell:[self speedOfSoundTableViewCell]];
        [controller setCalculator:[self calculator]];
    }
}

@end
