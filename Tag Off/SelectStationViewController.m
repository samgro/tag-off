//
//  SelectStationViewController.m
//  Tag Off
//
//  Created by Samuel Grossberg on 5/1/12.
//  Copyright (c) 2012 Samuel Grossberg. All rights reserved.
//

#import "SelectStationViewController.h"
#import "Station.h"
#import "WatchList.h"

@implementation SelectStationViewController

@synthesize stations = _stations;
@synthesize selection = _selection;
@synthesize delegate = _delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Load the stations list from disk when we create the view
    self.stations = [Station stationListFromPList:@"stations"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release strongly held pointers
    self.stations = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.stations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textLabel.text = [(Station *)[self.stations objectAtIndex:indexPath.row] name];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Update watch list with selected station
    NSInteger stationIndex = indexPath.row;
    NSIndexPath *selectionIndexPath = [self.selection objectForKey:@"indexPath"];
    NSInteger watchListIndex = selectionIndexPath.row;
    [[WatchList instance] setStation:[self.stations objectAtIndex:stationIndex]
                             atIndex:watchListIndex];
    
    // Return to root view
    [self.navigationController popViewControllerAnimated:YES];
}

@end
