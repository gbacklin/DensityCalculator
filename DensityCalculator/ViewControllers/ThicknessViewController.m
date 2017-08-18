//
//  ThicknessViewController.m
//  DensityCalculator
//
//  Created by Gene Backlin on 1/18/12.
//  Copyright (c) 2012 MariZack Consulting. All rights reserved.
//

#import "ThicknessViewController.h"
#import "Calculator.h"

@implementation ThicknessViewController

@synthesize calculator;
@synthesize tableViewCell;
@synthesize topLeftTextField;
@synthesize topCenterTextField;
@synthesize topRightTextField;
@synthesize bottomLeftTextField;
@synthesize bottomCenterTextField;
@synthesize bottomRightTextField;
@synthesize centerLeftTextField;
@synthesize centerCenterTextField;
@synthesize centerRightTextField;

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
    [[self topLeftTextField] becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSArray *width = [[self calculator] thickness];
    if(width) {
        [[self topLeftTextField] setText:[[width objectAtIndex:0] stringValue]];
        [[self topCenterTextField] setText:[[width objectAtIndex:1] stringValue]];
        [[self topRightTextField] setText:[[width objectAtIndex:2] stringValue]];
        [[self bottomLeftTextField] setText:[[width objectAtIndex:3] stringValue]];
        [[self bottomCenterTextField] setText:[[width objectAtIndex:4] stringValue]];
        [[self bottomRightTextField] setText:[[width objectAtIndex:5] stringValue]];
        if([width count] > 6) {
            [[self centerLeftTextField] setText:[[width objectAtIndex:6] stringValue]];
        }
        if([width count] > 7) {
            [[self centerCenterTextField] setText:[[width objectAtIndex:7] stringValue]];
        }
        if([width count] > 8) {
            [[self centerRightTextField] setText:[[width objectAtIndex:8] stringValue]];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    [values addObject:[NSNumber numberWithDouble:[[[self topLeftTextField] text] doubleValue]]];
    [values addObject:[NSNumber numberWithDouble:[[[self topCenterTextField] text] doubleValue]]];
    [values addObject:[NSNumber numberWithDouble:[[[self topRightTextField] text] doubleValue]]];
    [values addObject:[NSNumber numberWithDouble:[[[self bottomLeftTextField] text] doubleValue]]];
    [values addObject:[NSNumber numberWithDouble:[[[self bottomCenterTextField] text] doubleValue]]];
    [values addObject:[NSNumber numberWithDouble:[[[self bottomRightTextField] text] doubleValue]]];
    
    if([[[self centerLeftTextField] text] doubleValue] > 0) {
        [values addObject:[NSNumber numberWithDouble:[[[self centerLeftTextField] text] doubleValue]]];
    }
    if([[[self centerCenterTextField] text] doubleValue] > 0) {
        [values addObject:[NSNumber numberWithDouble:[[[self centerCenterTextField] text] doubleValue]]];
    }
    if([[[self centerRightTextField] text] doubleValue] > 0) {
        [values addObject:[NSNumber numberWithDouble:[[[self centerRightTextField] text] doubleValue]]];
    }
    
    [[self calculator] setThickness:values];
    [[[self tableViewCell] detailTextLabel] setText:[NSString stringWithFormat:@"%.2f", [[self calculator] averageValue:[[self calculator] thickness]]/10]];
}

- (void)viewDidUnload
{
    [self setTopLeftTextField:nil];
    [self setTopCenterTextField:nil];
    [self setTopRightTextField:nil];
    [self setBottomLeftTextField:nil];
    [self setBottomCenterTextField:nil];
    [self setBottomRightTextField:nil];
    [self setCenterLeftTextField:nil];
    [self setCenterCenterTextField:nil];
    [self setCenterRightTextField:nil];
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
