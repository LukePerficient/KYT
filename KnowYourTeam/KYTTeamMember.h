//
//  KYTTeamMember.h
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/6/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#ifndef KYTTeamMember_h
#define KYTTeamMember_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KYTTeamMember : NSObject

@property (atomic,strong) NSString *firstName;
@property (atomic,strong) NSString *lastName;
@property (atomic,strong) UIImage *photo;

- (id) initWithFirstName:(NSString*)newFirstName
          withLastName:(NSString*)newLastName
          withPhoto:(UIImage*)newPhoto;

@end


#endif /* KYTTeamMember_h */
