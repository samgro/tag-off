//
//  AppDelegate.m
//  Tag Off
//
//  Created by Samuel Grossberg on 4/26/12.
//  Copyright (c) 2012 Samuel Grossberg. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

- (void)showNotification;

@end

@implementation AppDelegate

@synthesize window = _window;
@synthesize locationManager = _locationManager;

- (void)showNotification
{
    NSLog(@"Showing notification.");
    UILocalNotification* notification = [[UILocalNotification alloc] init];
    notification.alertBody = @"Tag off!!!";
    notification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    return YES;
}

// Display an alert when the notification is received while the app is open
- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Tag Off!!!"
                                                        message:@"You're here."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark - CLLocationManagerDelegate methods
// Fire off a notification when we enter the watched region
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    NSLog(@"Notifying at %g, %g", region.center.latitude, region.center.longitude);
    [self showNotification];
}
- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    NSLog(@"Monitoring region failed with error: %@.", error);
}


@end
