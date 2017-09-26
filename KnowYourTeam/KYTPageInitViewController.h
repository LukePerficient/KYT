//
//  KYTPageInitViewController.h
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/18/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KSPromise;

@interface KYTPageInitViewController : UIViewController <UIPageViewControllerDataSource>

@property (nonatomic, strong) NSMutableArray *members;
@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic) NSInteger selectedRowIndex;
@property (nonatomic) NSInteger answerCount;

- (KSPromise *)verifyFinishedTest;
- (KSPromise *)notifyUserScore;
- (KSPromise *)verifyTestIsReset;

@end
