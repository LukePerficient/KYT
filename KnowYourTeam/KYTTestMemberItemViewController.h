//
//  KYTTestMemberItemViewController.h
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/19/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KYTTeamMember;

@interface KYTTestMemberItemViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *memberTestTextField;
@property (weak, nonatomic) IBOutlet UIImageView *memberPhoto;
@property (weak, nonatomic) IBOutlet UILabel *answerTextField;

@property (strong, atomic) KYTTeamMember *member;
@property (nonatomic) NSUInteger itemIndex;
@property (nonatomic) NSUInteger totalUsers;

@end
