//
//  RootViewController.m
//  Tag Off
//
//  Created by Samuel Grossberg on 5/1/12.
//  Copyright (c) 2012 Samuel Grossberg. All rights reserved.
//

#import "RootViewController.h"
#import "Station.h"

#define STATIONS_TO_WATCH 2

@interface RootViewController ()

// Private methods
- (void)startMonitoringStation:(Station *)station;
- (void)stopMonitoringStation:(Station *)station;

@end

@implementation RootViewController

@synthesize locationManager = _locationManager;
@synthesize watchedStations = _watchedStations;
@synthesize selection = _selection;

- (void)setSelection:(NSDictionary *)selection
{
    // Update the UI when we select a new station
    if (![selection isEqualToDictionary:_selection]) {
        if (_selection != nil) {
            [self stopMonitoringStation:[_selection objectForKey:@"station"]];
        }
        _selection = selection;
        NSIndexPath *indexPath = [selection objectForKey:@"indexPath"];
        id newStation = [selection objectForKey:@"station"];
        [self.watchedStations replaceObjectAtIndex:indexPath.row withObject:newStation];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                              withRowAnimation:UITableViewRowAnimationNone];
        [self startMonitoringStation:newStation];
    }
}

// Register a region for watching when we enter within 200 meters / accuracy 100 meters
#define REGION_RADIUS 200
#define REGION_ACCURACY kCLLocationAccuracyHundredMeters
- (void)startMonitoringStation:(Station *)station
{
    NSLog(@"Starting monitoring for station %@", station.name);
    
    // Do not create regions if support is unavailable or disabled.
    if (![CLLocationManager regionMonitoringAvailable] ||
        ![CLLocationManager regionMonitoringEnabled]) {
        NSLog(@"Region monitoring failed unavailable");
        return;
    }
    
    // If the radius is too large, registration fails automatically,
    // so clamp the radius to the max value.
    CLLocationDistance radius = REGION_RADIUS;
    if (radius > self.locationManager.maximumRegionMonitoringDistance) {
        radius = self.locationManager.maximumRegionMonitoringDistance;
    }
    
    // Create the region and start monitoring it.
    CLRegion* region = [[CLRegion alloc] initCircularRegionWithCenter:station.coordinate
                                                               radius:radius
                                                           identifier:station.name];
    [self.locationManager startMonitoringForRegion:region
                                   desiredAccuracy:REGION_ACCURACY];
    
    NSLog(@"Monitoring started for station %@", station.name);
}

- (void)stopMonitoringStation:(Station *)station
{
    NSLog(@"Stopping monitoring for station %@", station.name);
    CLRegion *region = [[CLRegion alloc] initCircularRegionWithCenter:station.coordinate
                                                               radius:REGION_RADIUS
                                                           identifier:station.name];
    [self.locationManager stopMonitoringForRegion:region];
    NSLog(@"Monitoring stopped for station %@", station.name);
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize location manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    // Initialize an empty array of watched stations
    Station *emptyStation = [[Station alloc] init];
    self.watchedStations = [[NSMutableArray alloc] initWithObjects:emptyStation, emptyStation, nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release strongly held pointers
    self.locationManager = nil;
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
        Station *station = [self.watchedStations objectAtIndex:indexPath.row];
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
    Station *station = [self.watchedStations objectAtIndex:indexPath.row];
    if (station.name) {
        cell.textLabel.text = station.name;
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
