//
//  NoteContentProtocol.h
//  ARIS
//
//  Created by Philip Dougherty on 2/6/12.
//  Copyright (c) 2012 UW Madison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Media.h"

@protocol NoteContentProtocol <NSObject>
@required
- (NSString *) getTitle;
- (NSString *) getText;
- (Media *) getMedia;
- (NSString *) getType;
- (NSString *) getUploadState; //uploadStateDONE, uploadStateUPLOADING, uploadStateQUEUED, uploadStateFAILED
- (int) getNoteId;
- (int) getContentId;
@end
