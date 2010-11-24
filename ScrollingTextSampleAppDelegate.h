//
//  ScrollingTextSampleAppDelegate.h
//  ScrollingTextSample
//
//  Created by maicki on 24.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CustomTextScrollView;

@interface ScrollingTextSampleAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	IBOutlet CustomTextScrollView *scrollView;
	IBOutlet NSTextField *textField;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)changeText:(id)sender;

@end
