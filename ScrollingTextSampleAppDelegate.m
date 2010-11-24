//
//  ScrollingTextSampleAppDelegate.m
//  ScrollingTextSample
//
//  Created by maicki on 24.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ScrollingTextSampleAppDelegate.h"
#import "CustomTextScrollView.h"

@implementation ScrollingTextSampleAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
}

- (IBAction)changeText:(id)sender {
	NSString *txt = [textField stringValue];
	[scrollView setText:txt];
}

@end
