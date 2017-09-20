//
//  KYTTestMemberItemViewController.m
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/19/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import "KYTTestMemberItemViewController.h"

@interface KYTTestMemberItemViewController ()

@end

@implementation KYTTestMemberItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeMembers];
    
}
//Test
// MARK: Actions
- (IBAction)checkUserAnswer:(UIButton *)sender {
    if ([_member.firstName isEqualToString:_memberTestTextField.text]) {
        [self prepareAnswerTextFieldWithColor:[UIColor greenColor]];
        _answerTextField.text = @"Correct";
    } else {
        [self prepareAnswerTextFieldWithColor:[UIColor redColor]];
        _answerTextField.text = @"Incorrect";
    }
    
    //Add code to pause for 1 sec, then move onto next slide.
    //Add code to disallow user from going back
}

// MARK: Private Methods
- (void)initializeMembers
{
    if (_member) {
        _memberPhoto.image = _member.photo;
    }
}

- (void)prepareAnswerTextFieldWithColor:(UIColor *)color
{
    _answerTextField.textColor = color;
    _answerTextField.layer.borderColor = [color CGColor];
    _answerTextField.layer.borderWidth = 2.0f;
    _answerTextField.layer.cornerRadius = 5;
    _answerTextField.clipsToBounds = YES;
}

-(void)dealloc
{
    NSLog(@"TeamMemberItemViewController is being deallocated");
}

@end
