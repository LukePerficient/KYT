//
//  KYTMemberViewController.m
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/7/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import "KYTMemberViewController.h"
#import "KYTImageSelectorDelegate.h"

@interface KYTMemberViewController ()

- (IBAction)scaleImage:(UIPinchGestureRecognizer *)recognizer;

@end

@implementation KYTMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeMembers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// MARK: Navigation
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    self.member = [[KYTTeamMember alloc] initWithFirstName:self.firstNameTxt.text WithLastName:self.lastNameText.text WithPhoto:self.memberImage.image];
    
    if (self.member != nil) {
        return YES;
    } else {
        [KYTCustomAlerts alertUserWithInvalidInformationMessage:self.view];
        
        return NO;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.member = [[KYTTeamMember alloc] initWithFirstName:self.firstNameTxt.text WithLastName:self.lastNameText.text WithPhoto:self.memberImage.image];
}

// MARK: Actions
- (IBAction)selectImageFromLibrary:(UITapGestureRecognizer *)sender {
    [self removeKeyboard];
    
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}

- (IBAction)scaleImage:(UIPinchGestureRecognizer *)recognizer {
    CGRect prevFrame = _memberImage.frame;
    CGPoint prevCenter = _memberImage.center;
    

    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
    //_memberImage.transform = CGAffineTransformIdentity;
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"LETGO::");
        _memberImage.frame = prevFrame;
        _memberImage.center = prevCenter;

        //recognizer.scale = 1;
    }
    
}

- (IBAction)cancelAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// MARK: Private methods
- (BOOL)userSelectedImageIsNull:(NSDictionary<NSString *,id> *)info
{
    return info[UIImagePickerControllerOriginalImage] != nil;
}
     
- (void)initializeMembers
{
    _imageSelectorDelegate = [[KYTImageSelectorDelegate alloc] initWithViewController:self];
    
    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.delegate = _imageSelectorDelegate;
    
    if (_member) {
        _firstNameTxt.text = _member.firstName;
        _lastNameText.text = _member.lastName;
        _memberImage.image = _member.photo;
    }
}



- (void)removeKeyboard
{
    [self.firstNameTxt resignFirstResponder];
    [self.lastNameText resignFirstResponder];
}

@end
