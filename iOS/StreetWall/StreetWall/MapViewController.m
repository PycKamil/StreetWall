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
#import <AFNetworking/AFNetworking.h>

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
    self.mapView = (MKMapView *)self.view;
    self.mapView.delegate = self;
    
  
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    NSString *serverURL = @"http://10.0.20.141:3000/walls.json";
    NSURL *URL = [NSURL URLWithString:serverURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self addLocations:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
    
}

- (void)addLocations: (NSArray *)locations {
    for (NSDictionary *callOutDict in locations) {
        [self addCallout:callOutDict];
    }
}

- (void)addCallout:(NSDictionary *)calloutDict {
    DXAnnotation *annotation1 = [DXAnnotation new];
    annotation1.coordinate = CLLocationCoordinate2DMake([calloutDict[@"latitude"] floatValue], [calloutDict[@"longitude"] floatValue]);
    [self.mapView addAnnotation:annotation1];
    
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(annotation1.coordinate, 10000, 10000)];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[DXAnnotation class]]) {
        
        UIView *pinView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"glyphicons-243-google-maps"]];
        
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
