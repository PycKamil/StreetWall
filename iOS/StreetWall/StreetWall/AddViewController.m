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
#import <RNActivityView/UIView+RNActivityView.h>

@interface AddViewController ()<DVGAssetPickerDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *wallPhoto;
@property(nonatomic, strong) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UIStepper *stepperWidth;
@property (weak, nonatomic) IBOutlet UIStepper *stepperHeight;
@property (weak, nonatomic) IBOutlet UILabel *widthLabel;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;

@end

@implementation AddViewController
- (IBAction)heightChanged:(id)sender {
    self.heightLabel.text = [NSString stringWithFormat:@"%ld m", (long)self.stepperHeight.value];
}

- (IBAction)choosePhoto:(id)sender {
    [self pickImage];
}
- (IBAction)widthChanged:(id)sender {
    self.widthLabel.text = [NSString stringWithFormat:@"%ld m", (long)self.stepperWidth.value];
}

- (IBAction)addTapped:(id)sender {
    WallDataObject *wall = [WallDataObject new];
    wall.image = self.wallPhoto.image;
    wall.width = @(self.stepperWidth.value);
    wall.height = @(self.stepperHeight.value);
    wall.comment = self.commentTextView.text;
    wall.location = self.locationManager.location.coordinate;
    [wall sendToServer];
    [self.view showActivityViewWithLabel:@"Loading"];
    [self.view hideActivityViewWithAfterDelay:1];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    self.wallPhoto.layer.borderColor = [UIColor redColor].CGColor;
    self.wallPhoto.layer.borderWidth = 2.0f;
}

- (BOOL) textView: (UITextView*) textView
shouldChangeTextInRange: (NSRange) range
  replacementText: (NSString*) text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
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
    UIImage *image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
    self.wallPhoto.image = image;
}

-(void)contentPickerViewControllerDidCancel:(DVGAssetPickerViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:nil];

}

@end
