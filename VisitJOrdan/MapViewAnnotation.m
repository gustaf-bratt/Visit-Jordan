//
//  MapViewAnnotation.m
//  VistJOrdan New
//
//  Created by Faris on 11/26/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import "MapViewAnnotation.h"


@implementation MapViewAnnotation

@synthesize title, coordinate;

- (id)initWithTitle:(NSString *)ttl andCoordinate:(CLLocationCoordinate2D)c2d {
	title = ttl;
	coordinate = c2d;
	return self;
}

- (void)dealloc {
}

@end