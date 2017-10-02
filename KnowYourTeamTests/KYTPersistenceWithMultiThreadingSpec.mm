#import <Cedar/Cedar.h>
#import "KYTTeamMemberPersistence.h"
#import "KYTTeamMember.h"
#import "KYTConstants.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

@interface TestHelper : NSObject
@end

@implementation TestHelper

+ (void)saveMembers:(NSMutableArray<KYTTeamMember *> *)members
{
    [KYTTeamMemberPersistence writeArray:members toFilePath:@"TestData"];
}


@end

SPEC_BEGIN(KYTPersistenceWithMultiThreadingSpec)

describe(@"KYTPersistenceWithMultiThreading", ^{
    __block NSMutableArray<KYTTeamMember *> *membersActual;
    
    beforeEach(^{
        
    });
    
    it(@"should write information from file from background thread", ^{
        // Setup Test Data
        NSMutableArray<KYTTeamMember *> *membersExpected = [[NSMutableArray<KYTTeamMember *> alloc] init];
        
        [membersExpected addObject:[[KYTTeamMember alloc] initWithFirstName:@"Test" withLastName:@"Test" withTitle:@"Test" withPhoto:nil]];
        [membersExpected addObject:[[KYTTeamMember alloc] initWithFirstName:@"TestTwo" withLastName:@"TestTwo" withTitle:@"TestTwo" withPhoto:nil]];
        [membersExpected addObject:[[KYTTeamMember alloc] initWithFirstName:@"TestThree" withLastName:@"TestThree" withTitle:@"TestThree" withPhoto:nil]];
        
        // Write to test asynchronously
        [TestHelper performSelectorInBackground:@selector(saveMembers:) withObject:nil];
        
        membersActual = [KYTTeamMemberPersistence readFileToArray:@"TestData"];
        
        // Evaluate results
        for (int i = 0; i < [membersExpected count]; i++) {
            NSLog(@"Test Results: %@",membersExpected[i].firstName);
        }
        
        for (int i = 0; i < [membersActual count]; i++) {
            NSLog(@"Test Results: %@",membersActual[i].firstName);
        }
        /*
        for (int i = 0; i < [membersExpected count]; i++) {
            membersExpected[i].firstName should equal(membersActual[i].firstName);
            membersExpected[i].lastName should equal(membersActual[i].lastName);
            membersExpected[i].title should equal(membersActual[i].title);
        }
         */
    });
});

SPEC_END

