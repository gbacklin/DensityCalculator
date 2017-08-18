//
//  RootViewController.m
//  PListStorage
//
//  Created by Gene Backlin on 7/11/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RootViewController.h"
#import "PersonAddViewController.h"
#import "PersonDetailViewController.h"
#import "Person.h"
#import "PropertyList.h"

@implementation RootViewController

@synthesize contacts;


#pragma mark -
#pragma mark View lifecycle

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setContacts:[PropertyList dictionaryFromPropertyList:@"Contacts"]];
	
	[self setTitle:@"Contacts"];
	
	[[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
	
    UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] 
						initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
						target:self 
						action:@selector(addPerson:)];
	[[self navigationItem] setRightBarButtonItem:addButtonItem];
}

#pragma mark -
#pragma mark Action methods

- (void)addPerson:(id)sender {
	PersonAddViewController *addController = 
	[[PersonAddViewController alloc] init];
	[addController setDelegate:self];
	
	UINavigationController *navigationController = 
	[[UINavigationController alloc] 
	 initWithRootViewController:addController];
    [self presentModalViewController:navigationController animated:YES];
	
}

#pragma mark -
#pragma mark Delegate Action methods

- (void)savePerson:(PersonAddViewController *)sender {
	NSMutableDictionary *aContacts = [contacts mutableCopy];
	
	Person *person = [[Person alloc] init];
	[person setFirstName:[[sender firstNameTextField] text]];
	[person setLastName:[[sender lastNameTextField] text]];
	[person setPhone:[[sender phoneTextField] text]];
	[aContacts setObject:person forKey:[person lastName]];
	[self setContacts:aContacts];
	[PropertyList writePropertyListFromDictionary:@"Contacts" 
									   dictionary:aContacts];
	
	
	[[self tableView] reloadData];
	[self dismissModalViewControllerAnimated:YES];
}

- (void)cancel {
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView 
                      numberOfRowsInSection:(NSInteger)section {
    if (contacts == nil) {
        [self setContacts:[NSDictionary dictionary]];
    }
    return [[self contacts] count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *cellText = nil;
	
	NSArray *keys = [[[self contacts] allKeys] 
					 sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
	cellText = [keys objectAtIndex:[indexPath row]];
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = 
	[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] 
				 initWithStyle:UITableViewCellStyleDefault
				 reuseIdentifier:CellIdentifier];
		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
	// Configure the cell.
	[[cell textLabel] setText:cellText];
	
    return cell;
}

#pragma mark -
#pragma mark Table view editing

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView 
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
		NSArray *keys = 
		[[[self contacts] allKeys] 
		 sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
		
		NSString *contact = [keys objectAtIndex:[indexPath row]];
		NSMutableDictionary *aContacts = [[self contacts] mutableCopy];
		[aContacts removeObjectForKey:contact];
		
		[self setContacts:aContacts];
		[PropertyList writePropertyListFromDictionary:@"Contacts" 
										   dictionary:aContacts];
		
		
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] 
						 withRowAnimation:UITableViewRowAnimationFade];
    }   
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView 
                       didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSArray *keys = 
	[[[self contacts] allKeys] 
	 sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
	
	NSString *contact = [keys objectAtIndex:[indexPath row]];
	Person *person = [[self contacts] objectForKey:contact];
	
	PersonDetailViewController *personDetailViewController = 
	[[PersonDetailViewController alloc] 
	 initWithStyle:UITableViewStyleGrouped];
	[personDetailViewController setContact:person];
	
	[[self navigationController] 
	 pushViewController:personDetailViewController 
	 animated:YES];
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	[self setContacts:nil];
}


@end

