//
//  ViewController.h
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/6/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KYTTeamMember.h"
#import "KYTTeamMemberViewCell.h"
#import "KYTMemberViewController.h"
#import "KYTTeamMemberPersistence.h"

@interface KYTTeamMemberListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSInteger selectedRowIndex;
@property (weak, nonatomic) IBOutlet UITableView *teamMemberTableView;
@property IBOutletCollection(KYTTeamMember) NSMutableArray *teamMemberList;

@end

