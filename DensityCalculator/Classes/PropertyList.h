//
//  PropertyList.h
//  PListStorage
//
//  Created by Gene Backlin on 7/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PropertyList : NSObject {
	
}

+ (NSDictionary *)dictionaryFromPropertyList:(NSString *)filename;
+ (BOOL)writePropertyListFromDictionary:(NSString *)filename 
                             dictionary:(NSDictionary *)plistDict;

@end
