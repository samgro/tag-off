//
//  AppDelegate.m
//  Tag Off
//
//  Created by Samuel Grossberg on 4/26/12.
//  Copyright (c) 2012 Samuel Grossberg. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // We could do something interesting here when the user launches the app from a notification.
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

@end
