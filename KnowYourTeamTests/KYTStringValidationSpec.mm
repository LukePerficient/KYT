#import <Cedar/Cedar.h>
#import "KYTStringValidation.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(KYTStringValidationSpec)

describe(@"KYTStringValidation", ^{

    it(@"should only contain letters (Happy Path)", ^{
        BOOL containsSpecialCharacters = [KYTStringValidation containsSpecialCharacters:@"Dustin Landry"];

        containsSpecialCharacters should be_falsy;
    });
    
    it(@"should not contain numbers", ^{
        BOOL containsSpecialCharacters = [KYTStringValidation containsSpecialCharacters:@"Dustin Landry 1"];

        containsSpecialCharacters should be_truthy;
    });
    
    it(@"should not contain special characters", ^{
        BOOL containsSpecialCharacters = [KYTStringValidation containsSpecialCharacters:@"Dustin Landry @#!@#"];

        containsSpecialCharacters should be_truthy;
    });
});

SPEC_END
