//
//  KYTImageSelectorDelegate.m
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/14/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import "KYTImageSelectorDelegate.h"
#import "KYTMemberViewController.h"

@implementation KYTImageSelectorDelegate

- (id)initWithViewController:(KYTMemberViewController *)delegatingViewController
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"Hey Yoooooo");
    
    if ([self userSelectedImageIsNull:info]) {
        _viewController.memberImage.image = info[UIImagePickerControllerOriginalImage];
    }
    
    [_viewController dismissViewControllerAnimated:YES completion:nil];
    
}

//
- (BOOL)userSelectedImageIsNull:(NSDictionary<NSString *,id> *)info
{
    return info[UIImagePickerControllerOriginalImage] != nil;
}

@end
