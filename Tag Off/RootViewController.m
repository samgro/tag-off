//
//  RootViewController.m
//  Tag Off
//
//  Created by Samuel Grossberg on 5/1/12.
//  Copyright (c) 2012 Samuel Grossberg. All rights reserved.
//

#import "RootViewController.h"

#define STATIONS_TO_WATCH 2

@implementation RootViewController

// Strong
@synthesize watchedStations = _watchedStations;

// Weak
@synthesize selectedStation = _selectedStation;

- (void)setSelectedStation:(NSDictionary *)selectedStation
{
    // Update the UI when we select a new station
    if (![selectedStation isEqualToDictionary:_selectedStation]) {
        _selectedStation = selectedStation;
        NSIndexPath *indexPath = [selectedStation objectForKey:@"indexPath"];
        id newStation = [selectedStation objectForKey:@"station"];
        [self.watchedStations replaceObjectAtIndex:indexPath.row withObject:newStation];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                              withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize an empty array of watched stations
    NSDictionary *emptyStation = [[NSDictionary alloc] init];
    self.watchedStations = [[NSMutableArray alloc] initWithObjects:emptyStation, emptyStation, nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release strongly held pointers
    self.watchedStations = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIViewController* childController = segue.destinationViewController;
    
    // Set this controller as the delegate for the child
    if ([childController respondsToSelector:@selector(setDelegate:)]) {
        [childController setValue:self forKey:@"delegate"];
    }
    // Set the selected station on the child
    if ([childController respondsToSelector:@selector(setSelection:)]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSDictionary *station = [self.watchedStations objectAtIndex:indexPath.row];
        NSDictionary *selection = [NSDictionary dictionaryWithObjectsAndKeys:
                                   indexPath, @"indexPath",
                                   station, @"station",
                                   nil];
        [childController setValue:selection forKey:@"selection"];
    }
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Only 1 section
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // A cell for each station to watch
    return STATIONS_TO_WATCH;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Grab the prototype cell
    static NSString *CellIdentifier = @"StationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Set its station appropriately - placeholder if empty
    NSDictionary *station = [self.watchedStations objectAtIndex:indexPath.row];
    NSString *stationName = [station objectForKey:@"name"];
    if (stationName) {
        cell.textLabel.text = stationName;
    }
    else {
        cell.textLabel.text = @"Select a station";
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // Section header for the only section
    return @"Remind me to tag at...";
}
@end
