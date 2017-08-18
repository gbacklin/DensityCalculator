//
//  PropertyList.m
//  PListStorage
//
//  Created by Gene Backlin on 7/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PropertyList.h"


@implementation PropertyList

+ (NSDictionary *)dictionaryFromPropertyList:(NSString *)filename {
	NSDictionary *result = nil;
	
	NSString *fname = [NSString stringWithFormat:@"%@.plist", filename];
	NSString *rootPath = 
	            [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
							       NSUserDomainMask, YES) objectAtIndex:0];
	NSString *bundlePath = [rootPath stringByAppendingPathComponent:fname];
	
	NSData *aData = [NSData dataWithContentsOfFile:bundlePath];
	if(aData != nil) {
		result = [NSKeyedUnarchiver unarchiveObjectWithData:aData];
	}
	
	return result;
}

+ (BOOL)writePropertyListFromDictionary:(NSString *)filename 
							 dictionary:(NSDictionary *)plistDict {
	NSString *fname = [NSString stringWithFormat:@"%@.plist", filename];
	NSString *rootPath = 
				[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
								NSUserDomainMask, YES) objectAtIndex:0];
	NSString *bundlePath = [rootPath stringByAppendingPathComponent:fname];
	
	NSData *aData = [NSKeyedArchiver archivedDataWithRootObject:plistDict]; 
	
	return [aData writeToFile:bundlePath atomically:YES];
}

@end
