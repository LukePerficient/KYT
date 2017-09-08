//
//  KYTTeamMemberModelTests.m
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/7/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KYTTeamMember.h"

@interface KYTTeamMemberModelTests : XCTestCase
{
    KYTTeamMember *member;
    NSMutableDictionary *expectedResults;
}

@property (strong,atomic) KYTTeamMember *member;
@property (strong,atomic) NSMutableDictionary *expectedResults;

@end

@implementation KYTTeamMemberModelTests

- (void)setUp {
    [super setUp];
    
    [self initalizeTestData];
}

- (void)tearDown {
    [super tearDown];
    self.member = nil;
    
}

- (void)testWithHappyPathMember {
    [self.expectedResults setValue:@"Dustin" forKey:@"FirstName"];
    [self.expectedResults setValue:@"Landry" forKey:@"LastName"];
    [self.expectedResults setValue:[UIImage imageNamed:@"PersonImage"] forKey:@"Photo"];
    
    KYTTeamMember *happyMember = [[KYTTeamMember alloc] initWithFirstName:@"Dustin" initWithLastName:@"Landry" initWithPhoto:[UIImage imageNamed:@"PersonImage"]];
    
    XCTAssert(self.expectedResults[@"FirstName"] == happyMember.firstName);
    XCTAssert(self.expectedResults[@"LastName"] == happyMember.lastName);
    XCTAssert([UIImagePNGRepresentation(self.expectedResults[@"Photo"]) isEqual: UIImagePNGRepresentation(happyMember.photo)]);
}

- (void)testWithEmptyMemberInfo {
    [self.expectedResults setValue:nil forKey:@"FirstName"];
    [self.expectedResults setValue:nil forKey:@"LastName"];
    [self.expectedResults setValue:nil forKey:@"Photo"];
    
    KYTTeamMember *happyMember = [[KYTTeamMember alloc] initWithFirstName:@"" initWithLastName:@"" initWithPhoto:nil];
    
    XCTAssert(self.expectedResults[@"FirstName"] == happyMember.firstName);
    XCTAssert(self.expectedResults[@"LastName"] == happyMember.lastName);
    XCTAssert(self.expectedResults[@"Photo"] == happyMember.photo);
}

- (void)testWithInvalidMemberInfo {
    [self.expectedResults setValue:nil forKey:@"FirstName"];
    [self.expectedResults setValue:nil forKey:@"LastName"];
    [self.expectedResults setValue:nil forKey:@"Photo"];
    
    KYTTeamMember *happyMember = [[KYTTeamMember alloc] initWithFirstName:@"4234#@$#@$]\[" initWithLastName:@"432][;',.2453)(*&^%$#@" initWithPhoto:nil];

    XCTAssert(self.expectedResults[@"FirstName"] == happyMember.firstName);
    XCTAssert(self.expectedResults[@"LastName"] == happyMember.lastName);
    XCTAssert(self.expectedResults[@"Photo"] == happyMember.photo);
}

// Mark: Private Methods
- (void)initalizeTestData {
    self.member = [[KYTTeamMember alloc] init];
    self.expectedResults = [[NSMutableDictionary alloc] init];
}


@end
