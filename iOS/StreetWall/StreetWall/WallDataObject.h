//
//  WallDataObject.h
//  StreetWall
//
//  Created by Kamil Pyć on 6/13/15.
//  Copyright (c) 2015 Kamil Pyć. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface WallDataObject : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) CLLocationCoordinate2D location;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSNumber *height;
@property (nonatomic, strong) NSNumber *width;

- (void)sendToServer;

@end
