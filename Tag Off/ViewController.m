//
//  ViewController.m
//  Tag Off
//
//  Created by Samuel Grossberg on 4/26/12.
//  Copyright (c) 2012 Samuel Grossberg. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (BOOL)registerRegionAtCenter:(CLLocationCoordinate2D)coordinate andIdentifier:(NSString *)identifier;
- (void)showNotification;

@end

@implementation ViewController
@synthesize locationManager = _locationManager;
@synthesize ohHaiLabel;
@synthesize startLabel;

- (IBAction)startPressed:(id)sender
{
    // Start monitoring for mission cliffs
    CLLocationCoordinate2D center;
    center.latitude = 37.59749;
    center.longitude = -122.14117;
    [self registerRegionAtCenter:center andIdentifier:@"Mission Cliffs"];
    self.startLabel.text = @"Started!";
}

- (IBAction)notifyPressed:(id)sender
{
    [self showNotification];
}

- (void)showNotification
{
    NSLog(@"Showing notification.");
    UILocalNotification* notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"Tag off!!!";
    notification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

// Register a region for watching
- (BOOL)registerRegionAtCenter:(CLLocationCoordinate2D)coordinate andIdentifier:(NSString *)identifier
{
    NSLog(@"Registering...");
    // Do not create regions if support is unavailable or disabled.
    if (![CLLocationManager regionMonitoringAvailable] ||
        ![CLLocationManager regionMonitoringEnabled]) {
        return NO;
    }
    
    // If the radius is too large, registration fails automatically,
    // so clamp the radius to the max value.
    CLLocationDistance radius = 200; // Meters
    if (radius > self.locationManager.maximumRegionMonitoringDistance) {
        radius = self.locationManager.maximumRegionMonitoringDistance;
    }
    
    // Create the region and start monitoring it.
    CLRegion* region = [[CLRegion alloc] initCircularRegionWithCenter:coordinate
                                                               radius:radius
                                                           identifier:identifier];
    [self.locationManager startMonitoringForRegion:region
                                   desiredAccuracy:kCLLocationAccuracyHundredMeters];

    NSLog(@"Monitoring started.");
    
    return YES;
}

#pragma mark - UIViewController lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Create the location manager instance
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
}

// Portrait only
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - CLLocationManagerDelegate methods
// Fire off a notification when we enter the watched region
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    self.ohHaiLabel.text = @"OH HAI";
    [self showNotification];
}

@end
