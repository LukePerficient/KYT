#import <Cedar/Cedar.h>

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(KYTCedarPersistenceTestsSpec)

describe(@"KYTCedarPersistenceTests", ^{
    __block NSString *yo;

    beforeEach(^{
        yo = @"Hey";
    });
    
    it(@"should not be nil", ^{
        yo should_not be_nil;
    });
});

SPEC_END
