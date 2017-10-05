//
//  KYTPageInitViewController.m
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/18/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import "KYTPageInitViewController.h"
#import "KYTTestMemberItemViewController.h"
#import "KYTTeamMemberListViewController.h"
#import "KYTTeamMemberPersistence.h"
#import "KYTMemberViewController.h"
#import "KYTTeamMember.h"
#import "KYTConstants.h"
#import "NSMutableArray_Shuffling.h"
#import "KSPromise.h"
#import "KYTCustomAlerts.h"

@interface KYTPageInitViewController ()

@end

@implementation KYTPageInitViewController

#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeMembers];
    [self createPageViewController];
    [self setupPageControl];
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.view = nil;
}

- (void)createPageViewController
{
    id previousViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 1];
    UIPageViewController *pageController;
    
    if ([previousViewController isKindOfClass:[KYTPageInitViewController class]]) {
        pageController = [self.storyboard instantiateViewControllerWithIdentifier:PAGE_CONTROLLER];
    } else {
        pageController = [self.storyboard instantiateViewControllerWithIdentifier:TEST_PAGE_IDENTIFIER];
    }
    
    pageController.dataSource = self;
    
    if([_members count])
    {
        NSArray *startingViewControllers = @[[self itemControllerForIndex:self.selectedRowIndex]]; //Member data in page view
        [pageController setViewControllers:startingViewControllers
                                 direction:UIPageViewControllerNavigationDirectionForward
                                  animated:NO
                                completion:nil];
    }
    
    self.pageViewController = pageController;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (void)setupPageControl
{
    [[UIPageControl appearance] setPageIndicatorTintColor:[UIColor grayColor]];
    [[UIPageControl appearance] setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
    [[UIPageControl appearance] setBackgroundColor:[UIColor darkGrayColor]];
}

// MARK: UIResponder abstract interface methods
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        [self shuffleAndResetTest];
    }
}

#pragma mark UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    KYTMemberViewController *itemController = (KYTMemberViewController *)viewController;
    
    //If view controller is TestView, don't allow user to scroll backwards
    if ([itemController.description rangeOfString:@"Test"].location != NSNotFound){
        return nil;
    }
    
    if (itemController.itemIndex > 0)
    {
        return [self itemControllerForIndex:itemController.itemIndex-1];
    }
    
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    KYTMemberViewController *itemController = (KYTMemberViewController *)viewController;
    
    if (itemController.itemIndex+1 < [_members count])
    {
        return [self itemControllerForIndex:itemController.itemIndex+1];
    }
    
    return nil;
}

- (UIViewController *)itemControllerForIndex:(NSUInteger)itemIndex
{
    if (itemIndex < [_members count])
    {
        id previousViewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 1];
        
        if ([previousViewController isKindOfClass:[KYTPageInitViewController class]]) {
            KYTMemberViewController *pageItemViewController = [self.storyboard instantiateViewControllerWithIdentifier:ITEM_CONTROLLER];
            pageItemViewController.itemIndex = itemIndex;
            pageItemViewController.member = _members[itemIndex];
            return pageItemViewController;
        } else {
            KYTTestMemberItemViewController *pageItemViewController = [self.storyboard instantiateViewControllerWithIdentifier:TEST_ITEM_IDENTIFIER];
            pageItemViewController.itemIndex = itemIndex;
            pageItemViewController.member = _members[itemIndex];
            pageItemViewController.totalUsers = _members.count;
            return pageItemViewController;
        }
    }
    
    return nil;
}

#pragma mark Page Indicator

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [_members count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return self.selectedRowIndex; //Sets page that is viewed from array
}

#pragma mark - Additions

- (NSUInteger)currentControllerIndex
{
    KYTMemberViewController *pageItemViewController = (KYTMemberViewController *) [self currentController];
    
    if (pageItemViewController)
    {
        return pageItemViewController.itemIndex;
    }
    
    return -1;
}

- (UIViewController *)currentController
{
    if ([self.pageViewController.viewControllers count])
    {
        return self.pageViewController.viewControllers[0];
    }
    
    return nil;
}
-(void)dealloc
{
    NSLog(@"PageViewController is being deallocated");
}

// Mark: Private Methods
- (void)initializeMembers
{
    _answerCount = 0;
    _members = [KYTTeamMemberPersistence readFileToArray:TEAM_MEMBER_FILE_NAME];
}

- (void)resetTest
{
    [self createPageViewController];
    [self setupPageControl];
}

- (void)shuffleAndResetTest 
{
    [_members shuffle];
    
    [self resetTest];
    
}

- (KSPromise *)verifyFinishedTest
{
    KSPromise *step1 = [KSPromise promise:^(resolveType resolve, rejectType reject) {
        
        KYTTestMemberItemViewController *pageTestViewController = (KYTTestMemberItemViewController *) [self currentController];

        BOOL isTestFinished = pageTestViewController.itemIndex+1 == [_members count];
        
        if (isTestFinished) {
            NSLog(@"Pass 1");
            
            resolve(@"Test Finished.");
        } else {
            NSLog(@"Pass 1");
            
            NSError *error = [NSError errorWithDomain:@"com.yourcompany.appname" code:3456 userInfo:@{NSLocalizedDescriptionKey:@"Test Incomplete."}];
            reject(error);
        }
    }];
    
    return step1;
}

- (KSPromise *)notifyUserScore
{
    KSPromise *step2 = [KSPromise promise:^(resolveType resolve, rejectType reject) {
        
        __block BOOL isUserNotified = NO;
        
        //[KYTCustomAlerts notifyUserOfScore:_answerCount viewType:self.view];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Test Complete" message:[NSString stringWithFormat:@"You scored %lu", _answerCount] preferredStyle:(UIAlertControllerStyleAlert)];
        
        NSString *answerString =@"";
        if (_answerCount < 10){
             answerString = @"I can do better";
        }
        else {
            answerString = @"I KNOW MY TEAM!";
        }
        
        UIAlertAction *yesButton = [UIAlertAction actionWithTitle:answerString
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action){
                                                              isUserNotified = YES;
                                                          }];
        
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
        
        if (!isUserNotified) {
            NSLog(@"Pass 2");
            resolve(@"User Notified.");
        } else {
            NSLog(@"Pass 2");
            
            NSError *error = [NSError errorWithDomain:@"com.yourcompany.appname" code:3456 userInfo:@{NSLocalizedDescriptionKey:@"Error notifing user."}];
            reject(error);
        }
    }];
    
    
    return step2;
}

- (KSPromise *)verifyTestIsReset
{
    KSPromise *step3 = [KSPromise promise:^(resolveType resolve, rejectType reject) {
        
        [self shuffleAndResetTest];
        
        //[self.pageViewController.view removeFromSuperview];
        //[self.pageViewController removeFromParentViewController];
        
        self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];

        BOOL isTestReset = [self.tabBarController.selectedViewController isKindOfClass:[UINavigationController class]];
        
        if (isTestReset) {
            NSLog(@"Pass 3");
            
            resolve(@"User Notified.");
        } else {
            NSLog(@"Fail 3");
            
            NSError *error = [NSError errorWithDomain:@"com.yourcompany.appname" code:3456 userInfo:@{NSLocalizedDescriptionKey:@"Error notifing user."}];
            reject(error);
        }
    }];
    
    
    return step3;
}

@end
