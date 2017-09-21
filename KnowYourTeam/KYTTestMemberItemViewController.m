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
        
        [self incrementAnswerCount];
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

// Private Methods:
- (void)incrementAnswerCount
{
    KYTPageInitViewController *parent = (KYTPageInitViewController *)self.parentViewController.parentViewController;
    parent.answerCount += 1;
    
    NSLog(@"Correct Answer Count = %lu", parent.answerCount);
}

@end
