//
//  KYTPromisesTraining.m
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/25/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KSPromise.h"

@interface KYTPromisesTraining : XCTestCase

@end

@implementation KYTPromisesTraining

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    
    [super tearDown];
}

- (void)testCleaningRoomExample {
    KSPromise *step1 = [KSPromise promise:^(resolveType resolve, rejectType reject) {
        // cleaning the room
        
        BOOL isClean = YES;
        
        if (isClean) {
            resolve(@"Room is cleaned.");
        } else {
            NSError *error = [NSError errorWithDomain:@"com.yourcompany.appname" code:3456 userInfo:@{NSLocalizedDescriptionKey:@"Room is not clean."}];
            reject(error);
        }
    }];
    
    [step1 then:^id(id value) {
        NSLog(@"State: %@",value);
        
        return value;
    } error:^id (NSError *error) {
        NSLog(@"State: %@", error.localizedDescription);
        
        return error;
    }];
}

- (void)testChainingOfPromises
{
    [[[[self cleanRoom] then:^id(id value) {
        return [self removeGarbage];
    }] then:^id(id value) {
        return [self winIcecream];
    }] then:^id (id value) {
        NSLog(@"Finished.");
        return nil;
    }];
}

// MARK: Private methods
- (KSPromise *)cleanRoom
{
    return [KSPromise resolve:@"Cleaned the room."];
}

- (KSPromise *)removeGarbage
{
    return [KSPromise resolve:@"Remove Garbage."];
}

- (KSPromise *)winIcecream
{
    return [KSPromise resolve:@"Won Icecream."];
}


@end
