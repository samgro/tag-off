//
//  SelectStationViewController.h
//  Tag Off
//
//  Created by Samuel Grossberg on 5/1/12.
//  Copyright (c) 2012 Samuel Grossberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface SelectStationViewController : UITableViewController

@property (strong, nonatomic) NSArray *stations;
@property (copy, nonatomic) NSDictionary *selection;
@property (weak, nonatomic) id delegate;

@end
