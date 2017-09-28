//
//  KYTImageSelectorDelegate.m
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/14/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import "KYTImageSelectorDelegate.h"
#import "KYTMemberViewController.h"
#import "KYTConstants.h"

@implementation KYTImageSelectorDelegate

- (id)initWithViewController:(UIViewController<ImageSelector> *)delegatingViewController
{
    self = [super init];
    if (self) {
        _viewController = delegatingViewController;
    }
    return self;
}

// MARK: UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [_viewController dismissViewControllerAnimated:YES completion:nil];
}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info{
    if ([self userSelectedImageIsNull:info]) {
        UIImage *img = [info valueForKey:UIImagePickerControllerOriginalImage];
        
        _viewController.memberImage.image = img; //info[UIImagePickerControllerOriginalImage];
       // [_viewController.memberImage setTranslatesAutoresizingMaskIntoConstraints:YES];
    }
    
    [_viewController dismissViewControllerAnimated:YES completion:nil];
 }

// Private Methods
- (BOOL)userSelectedImageIsNull:(NSDictionary<NSString *,id> *)info
{
    return info[UIImagePickerControllerOriginalImage] != nil;
}

@end
