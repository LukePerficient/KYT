#import <Cedar/Cedar.h>
#import "NSMutableArray_Shuffling.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(NSMutableArray_ShufflingSpec)

describe(@"NSMutableArray_Shuffling", ^{
    __block NSMutableArray *initialArray;
    __block NSMutableArray *shuffledArray;

    beforeEach(^{
        initialArray = [[NSMutableArray alloc] init];
        
        [initialArray addObject:@"Hey"];
        [initialArray addObject:@"Man"];
        [initialArray addObject:@"Whatsup"];
        
        shuffledArray = [[NSMutableArray alloc] initWithArray:initialArray copyItems:YES];
    });
    
    it(@"should shuffle array when NSMutableArray shuffle method is called", ^{
        [shuffledArray shuffle];
        
        initialArray should_not equal(shuffledArray);
    });
});

SPEC_END
