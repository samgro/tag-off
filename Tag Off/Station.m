//
//  Station.m
//  Tag Off
//
//  Created by Samuel Grossberg on 5/3/12.
//  Copyright (c) 2012 Samuel Grossberg. All rights reserved.
//

#import "Station.h"

@implementation Station

@synthesize name = _name;
@synthesize coordinate = _coordinate;

+ (NSArray *)stationListFromPList:(NSString *)filename
{
    // Grab the stations from file
    NSString *path = [[NSBundle mainBundle] pathForResource:@"stations" ofType:@"plist"];
    NSDictionary *stationsFile = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSArray *stationDataList = [stationsFile objectForKey:@"stations"];
    NSMutableArray *stations = [[NSMutableArray alloc] initWithCapacity:stationDataList.count];
    for (NSDictionary *stationData in stationDataList) {
        // Get station attributes from PList
        NSString *name = [stationData objectForKey:@"name"];
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [[stationData objectForKey:@"latitude"] floatValue];
        coordinate.longitude = [[stationData objectForKey:@"longitude"] floatValue];
        
        // Create a Station object and add it to the list
        Station* station = [[Station alloc] initWithName:name
                                           andCoordinate:coordinate];
        [stations addObject:station];
    }
    
    return [NSArray arrayWithArray:stations];
}

- (Station *)initWithName:(NSString *)name andCoordinate:(CLLocationCoordinate2D)coordinate
{
    Station *station = [super init];
    
    if (station) {
        station.name = name;
        station.coordinate = coordinate;
    }
    
    return station;
}

@end
