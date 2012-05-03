//
//  RootViewController.h
//  Tag Off
//
//  Created by Samuel Grossberg on 5/1/12.
//  Copyright (c) 2012 Samuel Grossberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *watchedStations;
@property (copy, nonatomic) NSDictionary *selectedStation;

@end
