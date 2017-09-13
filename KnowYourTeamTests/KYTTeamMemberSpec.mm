#import <Cedar/Cedar.h>
#import "KYTTeamMember.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(KYTTeamMemberSpec)

describe(@"KYTTeamMember", ^{
    __block KYTTeamMember *member;

    beforeEach(^{
        member = [[KYTTeamMember alloc] init];
    });
    
    it(@"should save with happy path member", ^{
        member = [[KYTTeamMember alloc] initWithFirstName:@"Dustin" WithLastName:@"Landry" WithPhoto:[UIImage imageNamed:@"PersonImage"]];
        
        member.firstName should equal(@"Dustin");
        member.lastName should equal(@"Landry");
        member.photo should equal([UIImage imageNamed:@"PersonImage"]);
    });
    
    it(@"should not save if user enters numbers or special characters", ^{
        member = [[KYTTeamMember alloc] initWithFirstName:@"123@$#$@#$" WithLastName:@"#!@@3233123" WithPhoto:[UIImage imageNamed:@"PersonImage"]];
        
        member.firstName should be_nil;
        member.lastName should be_nil;
        member.photo should be_nil;
    });
    
    it(@"should not save if photo is nil", ^{
        member = [[KYTTeamMember alloc] initWithFirstName:nil WithLastName:nil WithPhoto:nil];
        
        member.firstName should be_nil;
        member.lastName should be_nil;
        member.photo should be_nil;
    });
    
    it(@"should not save if user doesn't enter information", ^{
        member = [[KYTTeamMember alloc] initWithFirstName:@"" WithLastName:@"" WithPhoto:nil];
        
        member.firstName should be_nil;
        member.lastName should be_nil;
        member.photo should be_nil;
    });
    
    afterEach(^{
        member = nil;
    });
});

SPEC_END
