//
//  KYTTeamMemberListTableViewDelegate.h
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/21/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol KYTListViewController <NSObject,UITableViewDelegate>

@property (nonatomic) NSInteger selectedRowIndex;

@end

@class KYTTeamMemberListViewController;

@interface KYTTeamMemberListTableViewDelegate : NSObject <UITableViewDelegate>

@property (weak,nonatomic) UIViewController<KYTListViewController> *viewController;

- (id)initWithViewController:(UIViewController<KYTListViewController> *)vc;

@end
