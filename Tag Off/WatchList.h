//
//  WatchList.h
//  Tag Off
//
//  Created by Samuel Grossberg on 8/29/12.
//  Copyright (c) 2012 Samuel Grossberg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Station.h"

@interface WatchList : NSObject

// Getter for singleton instance
+ (WatchList *)instance;

// Watch a new station
- (void)setStation:(Station *)station
           atIndex:(NSInteger)index;

@property (strong, nonatomic) NSMutableArray *stations;

@end
