//
//  Quest.h
//  ARIS
//
//  Created by David J Gagnon on 9/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Quest : NSObject {
	int questId;
	NSString *name;
	NSString *description;
	NSString *mediaURL;
}

@property(readwrite, assign) int questId;
@property(copy, readwrite) NSString *name;
@property(copy, readwrite) NSString *description;
@property(copy, readwrite) NSString *mediaURL;


@end
