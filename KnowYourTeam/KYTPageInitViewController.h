//
//  KYTPageInitViewController.h
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/18/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KYTPageInitViewController : UIViewController <UIPageViewControllerDataSource>

@property (nonatomic, strong) NSArray *members;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic) NSInteger selectedRowIndex;

@end
