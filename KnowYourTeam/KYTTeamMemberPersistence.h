//
//  KYTTeamMemberPersistence.h
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/7/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#ifndef KYTTeamMemberPersistence_h
#define KYTTeamMemberPersistence_h
#import <UIKit/UIKit.h>

@interface KYTTeamMemberPersistence : NSObject

+ (void)writeArray:(NSMutableArray *)newArray toFilePath:(NSString *)newFilePath;
+ (NSMutableArray*)readFileToArray:(NSString *)newFilePath;

@end

#endif /* KYTTeamMemberPersistence_h */
