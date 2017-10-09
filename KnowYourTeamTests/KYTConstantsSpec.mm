#import <Cedar/Cedar.h>
#import "KYTConstants.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(KYTConstantsSpec)

describe(@"KYTConstants", ^{
    
    it(@"should hold all correct static information", ^{
        
        ALERT_INVALID_INFORMATION should equal(@"Please enter valid information");
        CELL_IDENTIFIER should equal(@"TeamMemberTableViewCell");
        ITEM_CONTROLLER should equal(@"ItemController");
        PAGE_CONTROLLER should equal(@"PageController");
        SHOW_PAGE_VIEW_SEGUE should equal(@"ShowPageView");
        TEST_PAGE_IDENTIFIER should equal(@"TestPageController");
        TEST_ITEM_IDENTIFIER should equal(@"TestItemController");
        TEAM_MEMBER_FILE_NAME should equal(@"TeamMember.plist");
        DEFAULT_IMAGE_NAME should equal(@"PersonImage");
        IMAGE_VIEW_WIDTH should equal(250);
        IMAGE_VIEW_HEIGHT should equal(165);
        IMAGE_VIEW_X should equal(62);
        IMAGE_VIEW_Y should equal(251);
        TABLE_HEADER_NAME should equal(@"Members");
        
    });
});

SPEC_END
