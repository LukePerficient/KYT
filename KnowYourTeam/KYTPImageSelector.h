//
//  KYTPImageSelector.h
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/20/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#ifndef KYTPImageSelector_h
#define KYTPImageSelector_h

@protocol ImageSelector <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *memberImage;

@end

#endif /* KYTPImageSelector_h */
