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

// MARK: Actions
- (IBAction)checkUserAnswer:(UIButton *)sender {
    if ([_member.firstName isEqualToString:_memberTestTextField.text]) {
        _answerTextField.textColor = [UIColor greenColor];
        _answerTextField.text = @"Correct";
        
        NSLog(@"Correct");
    } else {
        _answerTextField.textColor = [UIColor redColor];
        _answerTextField.text = @"Incorrect";
        NSLog(@"Incorrect");
    }
}

// MARK: Private Methods
- (void)initializeMembers
{
    if (_member) {
        _memberPhoto.image = _member.photo;
    }
}

@end
