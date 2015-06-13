//
//  ViewController.m
//  StreetWall
//
//  Created by Kamil Pyć on 6/13/15.
//  Copyright (c) 2015 Kamil Pyć. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <DXCustomCallout-ObjC/DXAnnotationView.h>
#import <DXCustomCallout-ObjC/DXAnnotationSettings.h>
#import "CallOutView.h"
@interface DXAnnotation : NSObject <MKAnnotation>

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;

@end

@implementation DXAnnotation


@end

@interface MapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mapView.delegate = self;
    [self addCallouts];
}

- (void)addCallouts {
    DXAnnotation *annotation1 = [DXAnnotation new];
    annotation1.coordinate = CLLocationCoordinate2DMake(12.9667, 77.5667);
    [self.mapView addAnnotation:annotation1];
    
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(annotation1.coordinate, 10000, 10000)];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[DXAnnotation class]]) {
        
        UIView *pinView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"glyphicons-12-camera"]];
        
        CallOutView *calloutView = [[[NSBundle mainBundle] loadNibNamed:@"CallOutView" owner:self options:nil] firstObject];
        [calloutView.showButton addTarget:self action:@selector(showDetails) forControlEvents:UIControlEventTouchUpInside];
        DXAnnotationView *annotationView = (DXAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:NSStringFromClass([DXAnnotationView class])];
        if (!annotationView) {
            annotationView = [[DXAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:NSStringFromClass([DXAnnotationView class])
                                                                  pinView:pinView
                                                              calloutView:calloutView
                                                                 settings:[DXAnnotationSettings defaultSettings]];
        }
        return annotationView;
    }
    return nil;
}

- (void)showDetails {
    [self performSegueWithIdentifier:@"ShowWall" sender:self];
}

@end
