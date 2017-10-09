#import <Cedar/Cedar.h>
#import "KYTCustomAlerts.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(KYTCustomAlertsSpec)

describe(@"KYTCustomAlerts", ^{
    
    beforeEach(^{

    });
    
    it(@"should alert user with invalid information response", ^{
        
        [KYTCustomAlerts alertUserWithInvalidInformationMessage:[[UIView alloc] init]];
        
        
    });
    
    it(@"should alert user with end score", ^{
        
        [KYTCustomAlerts notifyUserOfScore:12 viewType:[[UIView alloc] init]];
        
        
    });
});

SPEC_END
