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

@protocol ImageSelector <NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *memberImage;

@end

@interface KYTImageSelectorDelegate : NSObject <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

//@property (nonatomic, strong) UIViewController<ImageSelector> *viewController;
@property (nonatomic, weak) UIViewController<ImageSelector> *viewController;

- (id)initWithViewController:(UIViewController<ImageSelector> *)delegatingViewController;

@end

#endif /* KYTImageSelectorDelegate_h */
