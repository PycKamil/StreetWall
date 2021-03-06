//
//  WallDataObject.m
//  StreetWall
//
//  Created by Kamil Pyć on 6/13/15.
//  Copyright (c) 2015 Kamil Pyć. All rights reserved.
//

#import "WallDataObject.h"
#import <AFNetworking/AFNetworking.h>

@implementation WallDataObject

-(void)sendToServerSuccess:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    NSString *serverURL = @"http://10.0.20.141:3000/walls";
    
    NSData *imageData = UIImageJPEGRepresentation(self.image, 0.5);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"comment": self.comment, @"width":self.width,  @"height":self.height, @"lat":@(self.location.latitude), @"lon":@(self.location.longitude)};
    [manager POST:serverURL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFormData:imageData name:@"image"];
    } success:success failure:failure];
    
}

@end
