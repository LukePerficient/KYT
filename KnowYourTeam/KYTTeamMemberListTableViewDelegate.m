//
//  KYTTeamMemberListTableViewDelegate.m
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/21/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import "KYTTeamMemberListTableViewDelegate.h"
#import "KYTTeamMemberListViewController.h"
#import "KYTConstants.h"

@implementation KYTTeamMemberListTableViewDelegate

- (id)initWithViewController:(UIViewController<KYTListViewController> *)vc
{
    self = [super init];
    
    if (self) {
        _viewController = vc;
    }
    
    return self;
}

// Mark: TableView Delegates
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _viewController.selectedRowIndex = indexPath.row;
    [_viewController performSegueWithIdentifier:SHOW_PAGE_VIEW_SEGUE sender:self];
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

@end
