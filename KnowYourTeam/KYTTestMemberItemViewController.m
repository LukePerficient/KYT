//
//  KYTTestMemberItemViewController.m
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/19/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import "KYTTestMemberItemViewController.h"
#import "KYTTeamMember.h"
#import "KYTCustomAlerts.h"
#import "KYTTeamMemberListViewController.h"
#import "KYTPageInitViewController.h"


@interface KYTTestMemberItemViewController ()
@property (weak, nonatomic) IBOutlet UILabel *testNumber;
@property (weak, nonatomic) IBOutlet UIButton *checkAnswerButton;

@end

@implementation KYTTestMemberItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeMembers];
    _testNumber.text = [NSString stringWithFormat:@"%lu of %lu", _itemIndex+1, (unsigned long)_totalUsers];
}
//Test
// MARK: Actions
- (IBAction)checkUserAnswer:(UIButton *)sender {
    if ([_member.firstName isEqualToString:_memberTestTextField.text]) {
        [self prepareAnswerTextFieldWithColor:[UIColor greenColor]];
        _answerTextField.text = @"Correct";
        KYTPageInitViewController *parent = (KYTPageInitViewController *)self.parentViewController.parentViewController;
        parent.answerCount += 1;
        NSLog(@"Correct Answer Count = %lu", parent.answerCount);
    } else {
        [self prepareAnswerTextFieldWithColor:[UIColor redColor]];
        _answerTextField.text = @"Incorrect";
    }
    //Don't allow user to enter answer again
    _memberTestTextField.enabled = NO;
    _checkAnswerButton.enabled = NO;
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
