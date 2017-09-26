//
//  KYTCustomAlerts.h
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/14/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+Toast.h"

#ifndef KYTCustomAlerts_h
#define KYTCustomAlerts_h

@interface KYTCustomAlerts : NSObject

+ (void)alertUserWithInvalidInformationMessage:(UIView *)view;
+ (void)notifyUserOfScore:(NSInteger)score viewType:(UIView *)view;

@end

#endif /* KYTCustomAlerts_h */
