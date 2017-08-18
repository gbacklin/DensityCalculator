//
//  VolumeViewController.m
//  DensityCalculator
//
//  Created by Gene Backlin on 1/18/12.
//  Copyright (c) 2012 MariZack Consulting. All rights reserved.
//

#import "VolumeViewController.h"
#import "LengthViewController.h"
#import "WidthViewController.h"
#import "ThicknessViewController.h"
#import "Calculator.h"
#import "PropertyList.h"

@implementation VolumeViewController

@synthesize calculator;
@synthesize tableViewCell;
@synthesize lengthTableViewCell;
@synthesize widthTableViewCell;
@synthesize thicknessTableViewCell;
@synthesize volumeTableViewCell;

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

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [[[self lengthTableViewCell] detailTextLabel] setText:[NSString stringWithFormat:@"%.2f", [[[self calculator] averageLength] doubleValue]]];
    [[[self widthTableViewCell] detailTextLabel] setText:[NSString stringWithFormat:@"%.2f", [[[self calculator] averageWidth] doubleValue]]];
    [[[self thicknessTableViewCell] detailTextLabel] setText:[NSString stringWithFormat:@"%.2f", [[[self calculator] averageThickness] doubleValue]/10]];
    NSNumber *volume = [[self calculator] calculateVolume];
    [[[self volumeTableViewCell] detailTextLabel] setText:[NSString stringWithFormat:@"%.2f", [volume doubleValue]*10]];

    [[self tableView] setBackgroundView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[self calculator] calculateVolume];
    [[[self volumeTableViewCell] detailTextLabel] setText:[NSString stringWithFormat:@"%.2f", [[[self calculator] volume] doubleValue]*10]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    double length = [[[self calculator] averageLength] doubleValue];
    double thickness = [[[self calculator] averageThickness] doubleValue]/10;
    double frequency = [[[self calculator] frequency] doubleValue];
    double density = [[[self calculator] density] doubleValue];
    
    double speedOfSound = 0;
    if(frequency > 1) {
        speedOfSound = ((.98 * frequency * (length*length))/thickness)/100;
        
        double radiationRatio = speedOfSound / (density * 1000);

        [[self calculator] setSpeedOfSoundValue:[NSNumber numberWithDouble:speedOfSound]];
        [[self calculator] setRadiationRatio:[NSNumber numberWithDouble:radiationRatio]];
    } else {
        [[self calculator] setSpeedOfSoundValue:[NSNumber numberWithDouble:0]];
        [[self calculator] setRadiationRatio:[NSNumber numberWithDouble:0]];
    }
    
    NSMutableDictionary *newCalc = [[NSMutableDictionary alloc] initWithCapacity:1];
    [newCalc setObject:[self calculator] forKey:@"calculator"];
    [PropertyList writePropertyListFromDictionary:@"Calculator" dictionary:newCalc];

    [[[self volumeTableViewCell] detailTextLabel] setText:[NSString stringWithFormat:@"%.2f", [[[self calculator] volume] doubleValue]*10]];
}


- (void)viewDidUnload
{
    [self setLengthTableViewCell:nil];
    [self setWidthTableViewCell:nil];
    [self setThicknessTableViewCell:nil];
    [self setVolumeTableViewCell:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    if ([[segue identifier] isEqualToString:@"LengthSegue"])
    {
        LengthViewController *controller = segue.destinationViewController;
        [controller setCalculator:[self calculator]];
        [controller setTableViewCell:[self lengthTableViewCell]];
    } else if([[segue identifier] isEqualToString:@"WidthSegue"]) {
        WidthViewController *controller = segue.destinationViewController;
        [controller setCalculator:[self calculator]];
        [controller setTableViewCell:[self widthTableViewCell]];
    } else if([[segue identifier] isEqualToString:@"ThicknessSegue"]) {
        ThicknessViewController *controller = segue.destinationViewController;
        [controller setCalculator:[self calculator]];
        [controller setTableViewCell:[self thicknessTableViewCell]];
    }
}

@end
