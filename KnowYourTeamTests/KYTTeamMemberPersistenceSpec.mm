#import <Cedar/Cedar.h>
#import "KYTTeamMemberPersistence.h"
#import "KYTTeamMember.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(KYTTeamMemberPersistenceSpec)

describe(@"KYTTeamMemberPersistence", ^{

    it(@"should read in persisted team member information from pList file", ^{
        NSMutableArray<KYTTeamMember *> *tempTeamMemberList = [KYTTeamMemberPersistence readFileToArray:@"TempTeamData"];
        
        tempTeamMemberList[0].firstName should equal(@"Dustin");
        tempTeamMemberList[0].lastName should equal(@"Landry");
        tempTeamMemberList[0].title should equal(@"Technical Consultant");
        
        tempTeamMemberList[1].firstName should equal(@"Dustin");
        tempTeamMemberList[1].lastName should equal(@"Landry");
        tempTeamMemberList[1].title should equal(@"Technical Consultant");
        
        tempTeamMemberList[2].firstName should equal(@"Dustin");
        tempTeamMemberList[2].lastName should equal(@"Landry");
        tempTeamMemberList[2].title should equal(@"Technical Consultant");
        
    });
    
    it(@"should write persisted team member information to pList file", ^{
        // Write empty information to file
        NSMutableArray<KYTTeamMember *> *tempTeamMemberList = [[NSMutableArray<KYTTeamMember *> alloc] init];
        
        [KYTTeamMemberPersistence writeArray:tempTeamMemberList toFilePath:@"TempTeamData"];
        
        [[KYTTeamMemberPersistence readFileToArray:@"TempTeamData"] count] should equal(0);
        
        // Write populated information to file
        [tempTeamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Dustin" withLastName:@"Landry" withTitle:@"Technical Consultant" withPhoto:[UIImage imageNamed:@"DustinLandry.jpeg"]]];
        [tempTeamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Dustin" withLastName:@"Landry" withTitle:@"Technical Consultant" withPhoto:[UIImage imageNamed:@"DustinLandry.jpeg"]]];
        [tempTeamMemberList addObject:[[KYTTeamMember alloc] initWithFirstName:@"Dustin" withLastName:@"Landry" withTitle:@"Technical Consultant" withPhoto:[UIImage imageNamed:@"DustinLandry.jpeg"]]];
        
        [KYTTeamMemberPersistence writeArray:tempTeamMemberList toFilePath:@"TempTeamData"];
        
        [[KYTTeamMemberPersistence readFileToArray:@"TempTeamData"] count] should_not equal(0);
        
    });
});

SPEC_END
