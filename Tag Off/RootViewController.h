//
//  RootViewController.h
//  Tag Off
//
//  Created by Samuel Grossberg on 5/1/12.
//  Copyright (c) 2012 Samuel Grossberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface RootViewController : UITableViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) NSMutableArray *watchedStations;
@property (weak, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) NSDictionary *selection;

@end
