//
//  KYTCollectionViewController.h
//  KnowYourTeam
//
//  Created by DDC.Mac1 on 10/2/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KYTTeamMember;

@interface KYTCollectionViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *members;

@end
