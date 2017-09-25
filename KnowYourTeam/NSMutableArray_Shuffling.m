//
//  NSMutableArray_Shuffling.m
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/25/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import "NSMutableArray_Shuffling.h"

@implementation NSMutableArray (Shuffling)

- (void)shuffle
{
    NSUInteger count = [self count];
    if (count <= 1) return;
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [self exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

@end
