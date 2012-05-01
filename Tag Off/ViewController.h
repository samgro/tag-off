//
//  ViewController.h
//  Tag Off
//
//  Created by Samuel Grossberg on 4/26/12.
//  Copyright (c) 2012 Samuel Grossberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *ohHaiLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;

- (IBAction)startPressed:(id)sender;

@end
