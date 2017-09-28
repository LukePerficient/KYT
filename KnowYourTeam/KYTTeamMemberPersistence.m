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

+ (void)writeArray:(NSMutableArray<KYTTeamMember*> *)newArray toFilePath:(NSString *)newFilePath;
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
        [writeArray addObject:teamMemberArray[i].title];
        //[writeArray addObject:UIImagePNGRepresentation(teamMemberArray[i].photo)];
        [writeArray addObject:[KYTTeamMemberPersistence encodeToBase64String:(teamMemberArray[i].photo)]];
    }
    
    return writeArray;
}

+ (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
+ (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

+ (NSMutableArray<KYTTeamMember*>*)convertLinearArrayToTeamMemberArray:(NSMutableArray*)linearArray
{
    NSMutableArray<KYTTeamMember*> *readArray = [[NSMutableArray alloc] init];
    
    // Convert linear array to object array
    for (int i = 0; i < [linearArray count]; i = i + 4) {
        KYTTeamMember *member = [[KYTTeamMember alloc] init];
        
        member.firstName = linearArray[i];
        member.lastName = linearArray[i+1];
        member.title = linearArray[i+2];
        //member.photo = [UIImage imageWithData:linearArray[i+3]];
        member.photo = [KYTTeamMemberPersistence decodeBase64ToImage:linearArray[i+3]];
        
        [readArray addObject:member];
    }

    return readArray;
}

@end
