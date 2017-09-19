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
    NSMutableArray<KYTTeamMember *> *teamMemberList;
}

//@property IBOutletCollection(KYTTeamMember) NSMutableArray *teamMemberList;

@end

@implementation KYTPersistenceTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testReadWrite {
    teamMemberList = [[NSMutableArray alloc] init];
    
    // Add three members to team member list
    [teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Dustin" withLastName:@"Landry" withPhoto:[UIImage imageNamed:@"PersonImage"]]];
    
    [teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Taylor" withLastName:@"Wood" withPhoto:[UIImage imageNamed:@"PersonImage"]]];
    
    [teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Cameron" withLastName:@"Daigle" withPhoto:[UIImage imageNamed:@"PersonImage"]]];
    
    // Write
    [KYTTeamMemberPersistence writeArray:teamMemberList  toFilePath:@"TeamMember.plist"];
    
    // Read
    NSMutableArray<KYTTeamMember *> *readArray = [KYTTeamMemberPersistence readFileToArray:@"TeamMember.plist"];

    XCTAssert([readArray[0].firstName isEqualToString:@"Dustin"] && [readArray[0].lastName isEqualToString:@"Landry"]);
    XCTAssert([readArray[1].firstName isEqualToString:@"Taylor"] && [readArray[1].lastName isEqualToString:@"Wood"]);
    XCTAssert([readArray[2].firstName isEqualToString:@"Cameron"] && [readArray[2].lastName isEqualToString:@"Daigle"]);
}

@end
