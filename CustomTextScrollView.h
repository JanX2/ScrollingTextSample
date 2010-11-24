//
//  CustomTextScrollView.h
//  ScrollingTextSample
//
//  Created by maicki on 23.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CATextLayer;
@class CAScrollLayer;

@interface CustomTextScrollView : NSView {
	
	CAScrollLayer *scrollLayer;
	CATextLayer *textLayer;
	
	float fontSize;

}

- (void)setText:(NSString *)text;
- (void)addAnimation;

@end
