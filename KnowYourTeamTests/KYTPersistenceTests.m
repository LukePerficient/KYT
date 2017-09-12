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
    [teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Dustin" WithLastName:@"Landry" WithPhoto:[UIImage imageNamed:@"PersonImage"]]];
    
    [teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Taylor" WithLastName:@"Wood" WithPhoto:[UIImage imageNamed:@"PersonImage"]]];
    
    [teamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Cameron" WithLastName:@"Daigle" WithPhoto:[UIImage imageNamed:@"PersonImage"]]];
    
    // Write
    [KYTTeamMemberPersistence writeArray:teamMemberList ToFilePath:@"TeamMember.plist"];
    
    // Read
    NSMutableArray<KYTTeamMember *> *readArray = [KYTTeamMemberPersistence readFileToArray:@"TeamMember.plist"];

    XCTAssert([readArray[0].firstName isEqualToString:@"Dustin"] && [readArray[0].lastName isEqualToString:@"Landry"]);
    XCTAssert([readArray[1].firstName isEqualToString:@"Taylor"] && [readArray[1].lastName isEqualToString:@"Wood"]);
    XCTAssert([readArray[2].firstName isEqualToString:@"Cameron"] && [readArray[2].lastName isEqualToString:@"Daigle"]);
}

- (void)testReadDataFromFile {
    NSString *newFilePath = @"TeamMember.plist";
    NSString *docfilePath = [KYTTeamMemberPersistence getDocPath:newFilePath];
    
    NSMutableArray *linearArray = [[NSMutableArray alloc] initWithContentsOfFile:docfilePath];
    
    for (int i = 0; i < [linearArray count]; i++) {
        NSLog(@"%@",linearArray[i]);
    }
}

@end
