//
//  CustomTextScrollView.m
//  ScrollingTextSample
//
//  Created by maicki on 23.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CustomTextScrollView.h"
#import <Quartz/Quartz.h>

@interface CustomTextScrollView(Color)
- (CGColorRef)black;
- (CGColorRef)white;
- (CGColorRef)blue;
- (CGColorRef)red;
- (CGColorRef)green;
@end

@interface CustomTextScrollView ()
@property (nonatomic, readwrite, retain) CAScrollLayer *scrollLayer;
@property (nonatomic, readwrite, retain) CATextLayer *textLayer;
@end

@implementation CustomTextScrollView {
	
	CAScrollLayer *scrollLayer;
	CATextLayer *textLayer;
	
	float fontSize;
	
}

@synthesize scrollLayer;
@synthesize textLayer;

- (id)initWithFrame:(NSRect)frame{
	if (self = [super initWithFrame:frame]) {
		fontSize = 14;
		
		// ScrollLayer
		self.scrollLayer = [CAScrollLayer layer];
		scrollLayer.frame = NSRectToCGRect([self bounds]);
		
		// TextLayer
		self.textLayer = [CATextLayer layer];
		textLayer.foregroundColor = [self black];
		textLayer.fontSize = fontSize;
		
		// Set textLayer as sublayer of the scrollLayer
		[scrollLayer addSublayer:textLayer];
		
		[self setLayer:scrollLayer];
		
	}
    return self;
}

- (void)setText:(NSString *)text {
	// This will cause the textLayer to be released!
	[textLayer removeFromSuperlayer];
	// If it is not retained by us, it will get deallocated and the next line can crash us.
	
	textLayer.string = text;
	
	//  Get the width of the text and set it as the new width of the textLayer
	NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[NSFont fontWithName:@"Helvetica" size:textLayer.fontSize], NSFontAttributeName, nil]; 
	float textWidth = [text sizeWithAttributes:attributes].width;
	NSRect textRect = NSMakeRect(0.0, 0.0, textWidth, scrollLayer.frame.size.height);
	textLayer.frame = NSRectToCGRect(textRect);
	
	// Animate only if text is longer than the view
	if (self.frame.size.width < textRect.size.width) {
		[self addAnimation];
	} else {
		// Place text in the middle of the textlayer
		float newX = ([self frame].size.width - textRect.size.width) / 2;
		NSRect newTextRect = NSMakeRect(newX, 0, textLayer.frame.size.width, textLayer.frame.size.height);
		textLayer.frame = NSRectToCGRect(newTextRect);
	}
	
	[scrollLayer addSublayer:textLayer];
}

- (void)addAnimation {
	// Prepare the animation from the current position to the new position
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
	animation.autoreverses = YES;
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	animation.duration = 2.5;
	animation.repeatCount = HUGE_VALF;
	
	NSPoint from = [textLayer position];
	from.x += 10;
	animation.fromValue = [NSValue valueWithPoint:from];
	
	NSPoint to = [scrollLayer position];
	to.x -= (textLayer.frame.size.width - textLayer.position.x - (self.frame.size.width/2) + 10);
	animation.toValue = [NSValue valueWithPoint:to];
	
	// Add the animation, overriding the implicit animation.
	[textLayer addAnimation:animation forKey:@"position"];
}

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
}

- (void)dealloc {
	self.scrollLayer = nil;
	self.textLayer = nil;
	
	[super dealloc];
}

@end

@implementation CustomTextScrollView(Color)

- (CGColorSpaceRef)genericRGBSpace {
	static CGColorSpaceRef space = NULL;
	if(NULL == space) {
		space = CGColorSpaceCreateWithName (kCGColorSpaceGenericRGB);
	}
	return space;
}

- (CGColorRef)black {
	static CGColorRef black = NULL;
	if(black == NULL) {
		CGFloat values[4] = {0.0, 0.0, 0.0, 1.0};
		black = CGColorCreate([self genericRGBSpace], values);
	}
	return black;
}

- (CGColorRef)white{
	static CGColorRef white = NULL;
	if(white == NULL) {
		CGFloat values[4] = {1.0, 1.0, 1.0, 1.0};
		white = CGColorCreate([self genericRGBSpace], values);
	}
	return white;
}

- (CGColorRef)blue {
	static CGColorRef blue = NULL;
	if(blue == NULL) {
		CGFloat values[4] = {0.0, 0.0, 1.0, 1.0};
		blue = CGColorCreate([self genericRGBSpace], values);
	}
	return blue;
}

- (CGColorRef)red {
	static CGColorRef red = NULL;
	if(red == NULL) {
		CGFloat values[4] = {1.0, 0.0, 0.0, 1.0};
		red = CGColorCreate([self genericRGBSpace], values);
	}
	return red;
}

- (CGColorRef)green {
	static CGColorRef green = NULL;
	if(green == NULL) {
		CGFloat values[4] = {0.0, 1.0, 0.0, 1.0};
		green = CGColorCreate([self genericRGBSpace], values);
	}
	return green;
}

@end


