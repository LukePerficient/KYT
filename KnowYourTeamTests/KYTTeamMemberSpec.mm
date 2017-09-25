#import <Cedar/Cedar.h>
#import "KYTTeamMember.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(KYTTeamMemberSpec)

describe(@"KYTTeamMember", ^{
    __block KYTTeamMember *member;
    
    it(@"should save with happy path member", ^{
        member = [[KYTTeamMember alloc] initWithFirstName:@"Dustin" withLastName:@"Landry" withTitle:@"Tech" withPhoto:[UIImage imageNamed:@"PersonImage"]];
        
        member.firstName should equal(@"Dustin");
        member.lastName should equal(@"Landry");
        member.photo should equal([UIImage imageNamed:@"PersonImage"]);
    });
    
    it(@"should not save if user enters numbers or special characters", ^{
        member = [[KYTTeamMember alloc] initWithFirstName:@"123@$#$@#$" withLastName:@"#!@@3233123" withTitle:@"Tech" withPhoto:[UIImage imageNamed:@"PersonImage"]];
        
        member.firstName should be_nil;
        member.lastName should be_nil;
        member.photo should be_nil;
    });
    
    it(@"should not save if photo is nil", ^{
        member = [[KYTTeamMember alloc] initWithFirstName:nil withLastName:nil withTitle:@"Tech" withPhoto:nil];
        
        member.firstName should be_nil;
        member.lastName should be_nil;
        member.photo should be_nil;
    });
    
    it(@"should not save if user doesn't enter information", ^{
        member = [[KYTTeamMember alloc] initWithFirstName:@"" withLastName:@"" withTitle:@"Tech" withPhoto:nil];
        
        member.firstName should be_nil;
        member.lastName should be_nil;
        member.photo should be_nil;
    });
    
    afterEach(^{
        member = nil;
    });
});

SPEC_END
