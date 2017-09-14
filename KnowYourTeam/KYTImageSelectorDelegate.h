//
//  KYTImageSelectorDelegate.h
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/14/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class KYTMemberViewController;

#ifndef KYTImageSelectorDelegate_h
#define KYTImageSelectorDelegate_h

@interface KYTImageSelectorDelegate : NSObject <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) KYTMemberViewController *viewController;

- (id)initWithViewController:(KYTMemberViewController *)delegatingViewController;

//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;

@end

#endif /* KYTImageSelectorDelegate_h */
