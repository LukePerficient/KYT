//
//  ViewController.h
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/6/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KYTTeamMember;
@class KYTTeamMemberListTableViewDelegate;

@interface KYTTeamMemberListViewController : UIViewController <UITableViewDataSource>

@property (nonatomic) NSInteger selectedRowIndex;
@property (weak, nonatomic) IBOutlet UITableView *teamMemberTableView;
@property IBOutletCollection(KYTTeamMember) NSMutableArray *teamMemberList;
@property (strong, nonatomic) KYTTeamMemberListTableViewDelegate *tableViewDelegate;

@end

