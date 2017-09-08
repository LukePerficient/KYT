//
//  KYTTeamMemberPersistence.m
//  KnowYourTeam
//
//  Created by DDC.Mac2 on 9/7/17.
//  Copyright © 2017 DDC.Mac2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KYTTeamMemberPersistence.h"
#import "KYTTeamMember.h"

@implementation KYTTeamMemberPersistence

+ (void)writeArray:(NSMutableArray<KYTTeamMember*> *)newArray ToFilePath:(NSString *)newFilePath;
{
    NSString *docfilePath = [KYTTeamMemberPersistence getDocPath:newFilePath];
    
    NSMutableArray *writeArray = [KYTTeamMemberPersistence convertTeamMemberArrayToLinearArray:newArray];
    
    [writeArray writeToFile:docfilePath atomically:YES];
}

+ (NSMutableArray<KYTTeamMember*>*)readFileToArray:(NSString *)newFilePath {
    NSString *docfilePath = [KYTTeamMemberPersistence getDocPath:newFilePath];
    
    NSMutableArray *linearArray = [[NSMutableArray alloc] initWithContentsOfFile:docfilePath];
    
    NSMutableArray<KYTTeamMember*> *readArray = [KYTTeamMemberPersistence convertLinearArrayToTeamMemberArray:linearArray];
    
    return readArray;
}

// Mark: Private Methods
+ (NSString*)getDocPath:(NSString *)newFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString *docfilePath = [basePath stringByAppendingPathComponent:newFilePath];
    
    return docfilePath;
}

+ (NSMutableArray*)convertTeamMemberArrayToLinearArray:(NSMutableArray<KYTTeamMember*>*)teamMemberArray
{
    NSMutableArray *writeArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [teamMemberArray count]; i++) {
        [writeArray addObject:teamMemberArray[i].firstName];
        [writeArray addObject:teamMemberArray[i].lastName];
    }
    
    return writeArray;
}

+ (NSMutableArray<KYTTeamMember*>*)convertLinearArrayToTeamMemberArray:(NSMutableArray*)linearArray
{
    NSMutableArray<KYTTeamMember*> *readArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [linearArray count]; i = i + 2) {
        KYTTeamMember *member = [[KYTTeamMember alloc] init];
        
        member.firstName = linearArray[i];
        member.lastName = linearArray[i+1];
        member.photo = [UIImage imageNamed:@"PersonImage"];
        
        [readArray addObject:member];
    }
    
    return readArray;
}

@end
