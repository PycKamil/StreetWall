//
//  AddViewController.m
//  StreetWall
//
//  Created by Kamil Pyć on 6/13/15.
//  Copyright (c) 2015 Kamil Pyć. All rights reserved.
//

#import "AddViewController.h"
#import <DVGAssetPickerController/DVGAssetPickerViewController.h>

@interface AddViewController ()<DVGAssetPickerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *wallPhoto;

@end

@implementation AddViewController
- (IBAction)choosePhoto:(id)sender {
    [self pickImage];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self pickImage];
    // Do any additional setup after loading the view.
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

}

-(void)contentPickerViewControllerDidCancel:(DVGAssetPickerViewController *)controller {
    [controller dismissViewControllerAnimated:YES completion:nil];

}

@end
