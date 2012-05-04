//
//  AppDelegate.h
//  Tag Off
//
//  Created by Samuel Grossberg on 4/26/12.
//  Copyright (c) 2012 Samuel Grossberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end
