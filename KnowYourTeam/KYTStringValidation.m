//
//  KYTStringValidation.m
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/7/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KYTStringValidation.h"

@implementation KYTStringValidation

+ (BOOL)containsSpecialCharacters:(NSString *)testString
{
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
    
    return [testString rangeOfCharacterFromSet:set].location != NSNotFound;
}

@end


