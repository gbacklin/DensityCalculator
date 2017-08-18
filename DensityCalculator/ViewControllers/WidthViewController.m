//
//  WidthViewController.m
//  DensityCalculator
//
//  Created by Gene Backlin on 1/18/12.
//  Copyright (c) 2012 MariZack Consulting. All rights reserved.
//

#import "WidthViewController.h"
#import "Calculator.h"

@implementation WidthViewController

@synthesize calculator;
@synthesize tableViewCell;
@synthesize leftTextField;
@synthesize centerTextField;
@synthesize rightTextField;

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
    NSArray *width = [[self calculator] width];
    [[self leftTextField] setText:[[width objectAtIndex:0] stringValue]];
    [[self centerTextField] setText:[[width objectAtIndex:1] stringValue]];
    [[self rightTextField] setText:[[width objectAtIndex:2] stringValue]];
    [[self leftTextField] becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    [values addObject:[NSNumber numberWithDouble:[[[self leftTextField] text] doubleValue]]];
    [values addObject:[NSNumber numberWithDouble:[[[self centerTextField] text] doubleValue]]];
    [values addObject:[NSNumber numberWithDouble:[[[self rightTextField] text] doubleValue]]];
    
    [[self calculator] setWidth:values];
    [[[self tableViewCell] detailTextLabel] setText:[NSString stringWithFormat:@"%.2f", [[self calculator] averageValue:[[self calculator] width]]]];
}


- (void)viewDidUnload
{
    [self setLeftTextField:nil];
    [self setCenterTextField:nil];
    [self setRightTextField:nil];
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
