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

@property (strong,nonatomic) KYTTeamMember *member;
@property (strong,nonatomic) NSMutableDictionary *expectedPositiveResults;
@property (strong,nonatomic) NSMutableDictionary *expectedNegativeResults;

@end

@implementation KYTTeamMemberModelTests

- (void)setUp {
    [super setUp];
    
    [self initalizeElements];
    
    [self initializeTestData];
}

- (void)tearDown {
    [super tearDown];
    self.member = nil;
    self.expectedPositiveResults = nil;
    self.expectedNegativeResults = nil;
}

- (void)testWithHappyPathMember {
    KYTTeamMember *happyMember = [[KYTTeamMember alloc] initWithFirstName:@"Dustin" WithLastName:@"Landry" WithPhoto:[UIImage imageNamed:@"PersonImage"]];
    
    XCTAssertEqual(self.expectedPositiveResults[@"FirstName"], happyMember.firstName);
    XCTAssertEqual(self.expectedPositiveResults[@"LastName"], happyMember.lastName);
    XCTAssertTrue([UIImagePNGRepresentation(self.expectedPositiveResults[@"Photo"]) isEqual: UIImagePNGRepresentation(happyMember.photo)]);
}

- (void)testWithEmptyMemberInfo {
    KYTTeamMember *happyMember = [[KYTTeamMember alloc] initWithFirstName:@"" WithLastName:@"" WithPhoto:nil];
    
    XCTAssertEqual(self.expectedNegativeResults[@"FirstName"], happyMember.firstName);
    XCTAssertEqual(self.expectedNegativeResults[@"LastName"], happyMember.lastName);
    XCTAssertEqual(UIImagePNGRepresentation(self.expectedNegativeResults[@"Photo"]), UIImagePNGRepresentation(happyMember.photo));
}

- (void)testWithInvalidMemberInfo {
    KYTTeamMember *happyMember = [[KYTTeamMember alloc] initWithFirstName:@"4234#@$#@$]\[" WithLastName:@"432][;',.2453)(*&^%$#@" WithPhoto:nil];
    
    XCTAssertEqual(self.expectedNegativeResults[@"FirstName"], happyMember.firstName);
    XCTAssertEqual(self.expectedNegativeResults[@"LastName"], happyMember.lastName);
    XCTAssertEqual(UIImagePNGRepresentation(self.expectedNegativeResults[@"Photo"]), UIImagePNGRepresentation(happyMember.photo));
}

// Mark: Private Methods
- (void)initalizeElements {
    self.member = [[KYTTeamMember alloc] init];
    self.expectedPositiveResults = [[NSMutableDictionary alloc] init];
    self.expectedNegativeResults = [[NSMutableDictionary alloc] init];
}

- (void)initializeTestData
{
    [self.expectedPositiveResults setValue:@"Dustin" forKey:@"FirstName"];
    [self.expectedPositiveResults setValue:@"Landry" forKey:@"LastName"];
    [self.expectedPositiveResults setValue:[UIImage imageNamed:@"PersonImage"] forKey:@"Photo"];
    
    [self.expectedNegativeResults setValue:nil forKey:@"FirstName"];
    [self.expectedNegativeResults setValue:nil forKey:@"LastName"];
    [self.expectedNegativeResults setValue:nil forKey:@"Photo"];
}


@end
