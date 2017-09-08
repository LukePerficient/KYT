//
//  KYTTeamMemberViewCell.h
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/6/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KYTTeamMemberViewCell : UITableViewCell
{
    UILabel *firstNameLabel;
    UILabel *lastNameLabel;
    UIImageView *imageView;
}
//Test
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
