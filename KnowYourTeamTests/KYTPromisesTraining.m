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
        
        XCTAssertEqual(value, @"Room is cleaned.");
        
        return value;
    } error:^id (NSError *error) {
        NSLog(@"State: %@", error.localizedDescription);
        
        XCTAssertEqual(error.localizedDescription, @"Room is not clean.");
        
        return error.localizedDescription;
    }];

}

- (void)testChainingOfPromisess
{
    [[[[self cleanRoom] then:^id(id value) {
        return [self removeGarbage:value];
    }] then:^id(id value) {
        return [self winIcecream:value];
    }] then:^id (NSString *value) {
        NSLog(@"%@",value);
        NSLog(@"Cleaned the room. Remove Garbage. Won Icecream.");
        
        NSString *expectedResult = @"Cleaned the room. Remove Garbage. Won Icecream.";

        XCTAssert([@"Cleaned the room. Remove Garbage. Won Icecream." isEqualToString:expectedResult]);
        
        return value;
    }];
}

// MARK: Private methods
- (KSPromise *)cleanRoom
{
    return [KSPromise resolve:@"Cleaned the room."];
}

- (KSPromise *)removeGarbage:(id)message
{
    return [KSPromise resolve:[NSString stringWithFormat:@"%@ Remove Garbage.",message]];
}

- (KSPromise *)winIcecream:(id)message
{
    return [KSPromise resolve:[NSString stringWithFormat:@"%@ Won Icecream.",message]];
}


@end
