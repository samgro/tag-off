//
//  WatchList.m
//  Tag Off
//
//  Singleton for keeping track of watched stations
//
//  Created by Samuel Grossberg on 8/29/12.
//  Copyright (c) 2012 Samuel Grossberg. All rights reserved.
//

#import "WatchList.h"
#import "Station.h"

@implementation WatchList
@synthesize stations = _stations;

+ (WatchList *)instance {
    static WatchList *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[WatchList alloc] init];
    });
    
    return __sharedInstance;
}

- (void)setStation:(Station *)station atIndex:(NSInteger)index
{
    [self.stations replaceObjectAtIndex:index withObject:station];
}

- (id)init
{
    self = [super init];
    if (self) {
        Station *emptyStation = [[Station alloc] init];
        self.stations = [NSMutableArray arrayWithObjects:emptyStation, emptyStation, nil];
    }
    return self;
}

@end
