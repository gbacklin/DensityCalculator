//
//  LengthViewController.m
//  DensityCalculator
//
//  Created by Gene Backlin on 1/18/12.
//  Copyright (c) 2012 MariZack Consulting. All rights reserved.
//

#import "LengthViewController.h"
#import "Calculator.h"

@implementation LengthViewController

@synthesize topLength;
@synthesize bottomLength;
@synthesize tableViewCell;
@synthesize calculator;

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
    NSArray *length = [[self calculator] length];
    [[self topLength] setText:[[length objectAtIndex:0] stringValue]];
    [[self bottomLength] setText:[[length objectAtIndex:1] stringValue]];
    [[self topLength] becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    [values addObject:[NSNumber numberWithDouble:[[[self topLength] text] doubleValue]]];
    [values addObject:[NSNumber numberWithDouble:[[[self bottomLength] text] doubleValue]]];
    
    [[self calculator] setLength:values];
    [[[self tableViewCell] detailTextLabel] setText:[NSString stringWithFormat:@"%.2f", [[self calculator] averageValue:[[self calculator] length]]]];
}

- (void)viewDidUnload
{
    [self setTopLength:nil];
    [self setBottomLength:nil];
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
