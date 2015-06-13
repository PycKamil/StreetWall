//
//  AddViewController.m
//  StreetWall
//
//  Created by Kamil Pyć on 6/13/15.
//  Copyright (c) 2015 Kamil Pyć. All rights reserved.
//

#import "AddViewController.h"
#import <DVGAssetPickerController/DVGAssetPickerViewController.h>
#import "WallDataObject.h"

@interface AddViewController ()<DVGAssetPickerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *wallPhoto;
@property(nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation AddViewController

- (IBAction)choosePhoto:(id)sender {
    [self pickImage];
}

- (IBAction)addTapped:(id)sender {
    WallDataObject *wall = [WallDataObject new];
    wall.image = self.wallPhoto.image;
    wall.location = self.locationManager.location.coordinate;
    [wall sendToServer];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pickImage {
    DVGAssetPickerViewController *picker = [[DVGAssetPickerViewController alloc] init];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)contentPickerViewController:(DVGAssetPickerViewController *)controller clickedMenuItem:(DVGAssetPickerMenuItem)menuItem {
    [controller dismissViewControllerAnimated:YES completion:nil];

}

-(void)contentPickerViewController:(DVGAssetPickerViewController *)controller didSelectAssets:(NSArray *)assets {
    [controller dismissViewControllerAnimated:YES completion:nil];
    ALAsset *asset = [assets firstObject];
    UIImage *image = [UIImage imageWithCGImage:asset.thumbnail];
    self.wallPhoto.image = image;
}

-(void)contentPickerViewControllerDidCancel:(DVGAssetPickerViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:nil];

}

@end
