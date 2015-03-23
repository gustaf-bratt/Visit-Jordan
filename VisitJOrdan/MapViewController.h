//
//  MapViewController.h
//  VistJOrdan New
//
//  Created by Faris on 11/26/13.
//  Copyright (c) 2013 Faris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>{
    
	MKMapView *mapView;
    NSString *locationName;
    double x,y;
    
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSString  *locationName;
@property (nonatomic) double x;
@property (nonatomic) double y;

@end