//
//  KYTPersistenceTests.m
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/7/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KYTTeamMember.h"
#import "KYTTeamMemberPersistence.h"

@interface KYTPersistenceTests : XCTestCase
{
    NSMutableArray *teamMemberList;
}

@property IBOutletCollection(KYTTeamMember) NSMutableArray *teamMemberList;

@end

@implementation KYTPersistenceTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testReadWrite {
    self.teamMemberList = [[NSMutableArray alloc] init];
    
    // Add three members to team member list
    [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Dustin" initWithLastName:@"Landry" initWithPhoto:[UIImage imageNamed:@"PersonImage"]]];
    
    [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Taylor" initWithLastName:@"Wood" initWithPhoto:[UIImage imageNamed:@"PersonImage"]]];
    
    [self.teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Cameron" initWithLastName:@"Daigle" initWithPhoto:[UIImage imageNamed:@"PersonImage"]]];

    // Write
    [KYTTeamMemberPersistence writeArray:self.teamMemberList ToFilePath:@"TeamMember.plist"];
    
    // Read
    NSMutableArray<KYTTeamMember *> *readArray = [KYTTeamMemberPersistence readFileToArray:@"TeamMember.plist"];
    
    XCTAssert([readArray[0].firstName isEqualToString:@"Dustin"] && [readArray[0].lastName isEqualToString:@"Landry"]);
    XCTAssert([readArray[1].firstName isEqualToString:@"Taylor"] && [readArray[1].lastName isEqualToString:@"Wood"]);
    XCTAssert([readArray[2].firstName isEqualToString:@"Cameron"] && [readArray[2].lastName isEqualToString:@"Daigle"]);
}

- (void)testReadDataFromFile {
    
}

@end
