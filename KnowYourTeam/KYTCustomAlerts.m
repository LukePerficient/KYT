//
//  KYTCustomAlerts.m
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/14/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import "KYTCustomAlerts.h"

@implementation KYTCustomAlerts

+ (void)alertUserWithInvalidInformationMessage:(UIView *)view
{
    NSValue *toastCenterPoint = [NSValue valueWithCGPoint:CGPointMake([[UIScreen mainScreen] bounds].size.width/2.0, [[UIScreen mainScreen] bounds].size.height/3.0)];
    [view makeToast:ALERT_INVALID_INFORMATION duration:1.0 position:toastCenterPoint];
}

@end
