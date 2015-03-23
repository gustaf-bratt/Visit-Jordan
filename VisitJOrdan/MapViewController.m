//
//  MapViewController.m
//  VistJOrdan New
//
//  Created by Faris on 11/26/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import "MapViewController.h"
#import "MapViewAnnotation.h"

@implementation MapViewController

@synthesize mapView;
@synthesize x,y,locationName;
- (IBAction)zoomIn:(id)sender {
    MKCoordinateSpan span;
    span.latitudeDelta = mapView.region.span.latitudeDelta / 2;
    span.longitudeDelta = mapView.region.span.latitudeDelta / 2;
    MKCoordinateRegion region;
    region.span = span;
    region.center = mapView.region.center;
    [self.mapView setRegion:region animated:YES];
}
- (IBAction)zoomOut:(id)sender {
    
    MKCoordinateSpan span;
    span.latitudeDelta = mapView.region.span.latitudeDelta * 2;
    span.longitudeDelta = mapView.region.span.latitudeDelta * 2;
    MKCoordinateRegion region;
    region.span = span;
    region.center = mapView.region.center;
    
    [self.mapView setRegion:region animated:YES];
}

// When the view loads
- (void)viewDidLoad
{   //self.title=locationName;
	// Set some coordinates for our position (Buckingham Palace!)
	CLLocationCoordinate2D location;
	location.latitude = x;
	location.longitude = y;
    
	// Add the annotation to our map view
	MapViewAnnotation *newAnnotation = [[MapViewAnnotation alloc] initWithTitle:locationName andCoordinate:location];
	[mapView addAnnotation:newAnnotation];
    
    MKMapRect zoomRect = MKMapRectNull;
  
    MKMapPoint annotationPoint = MKMapPointForCoordinate(location);
    MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 800000, 000000);
    zoomRect = MKMapRectUnion(zoomRect, pointRect);
    
    
    [self.mapView setVisibleMapRect:zoomRect animated:YES];
    
    MKCoordinateSpan span;
    span.latitudeDelta = mapView.region.span.latitudeDelta * 2;
    span.longitudeDelta = mapView.region.span.latitudeDelta * 2;
    MKCoordinateRegion region;
    region.span = span;
    region.center = mapView.region.center;
    
    [self.mapView setRegion:region animated:YES];
    
    //[self.mapView setCenterCoordinate:myCoord zoomLevel:13 animated:YES];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 50000, 50000);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = userLocation.coordinate;
    point.title = @"Your Location?";
    point.subtitle = @"you are here";
    
    [self.mapView addAnnotation:point];

}

// When a map annotation point is added, zoom to it (1500 range)
- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{
    MKAnnotationView *annotationView = [views objectAtIndex:0];
    id <MKAnnotation> mp = [annotationView annotation];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate], 10000, 10000);
    [mv setRegion:region animated:YES];
    [mv selectAnnotation:mp animated:YES];
}


// Received memory warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// If the view unloads, release the map view
- (void)viewDidUnload {
	[super viewDidUnload];

	mapView = nil;
}


@end