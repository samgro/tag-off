//
//  Station.h
//  Tag Off
//
//  Model for a CalTrain station
//
//  Created by Samuel Grossberg on 5/3/12.
//  Copyright (c) 2012 Samuel Grossberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Station : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

+ (NSArray *)stationListFromPList:(NSString *)filename;
- (Station *)initWithName:(NSString *)name andCoordinate:(CLLocationCoordinate2D)coordinate;

@end
