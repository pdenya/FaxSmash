//
//  UIView+PD.m
//  Inspect
//
//  Created by Paul Denya on 11/21/12.
//
//

#import "UIView+PD.h"
#import <QuartzCore/QuartzCore.h>
@implementation UIView (PD)

//getter shortcuts
-(CGFloat)rightEdge {
	return self.frame.origin.x + self.frame.size.width;
}

-(CGFloat)bottomEdge {
	return self.frame.origin.y + self.frame.size.height;
}

-(CGFloat)y {
	return self.frame.origin.y;
}

-(CGFloat)x {
	return self.frame.origin.x;
}

-(CGFloat)h {
	return self.frame.size.height;
}

-(CGFloat)w {
	return self.frame.size.width;
}

//styling
-(void)addBlueBackground {
	self.backgroundColor = [UIColor blackColor];
 	
	UIImageView *bgview = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"bg_blue.png"] stretchableImageWithLeftCapWidth:8 topCapHeight:240]];
	bgview.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
	if (![self respondsToSelector:@selector(setBackgroundView:)]) {
		[self addSubview:bgview];
		[self sendSubviewToBack:bgview];
	}
	else {
		[self performSelector:@selector(setBackgroundView:) withObject:bgview];
	}
	
	[bgview release];
}

-(void)addBlueTableCellBackground {
	self.backgroundColor = [UIColor clearColor];
 	
	UIImageView *bgview = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"bg_tablecell.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:28]];
	bgview.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
	[self addSubview:bgview];
	[self sendSubviewToBack:bgview];
	[bgview release];
}

-(void)addRedBorder {
	self.layer.borderColor = [UIColor redColor].CGColor;
	self.layer.borderWidth = 2.0f;
}

//relative positioning
-(void)setyp:(CGFloat)percent {
	if (self.superview) {
		CGRect frame = CGRectIntegral(self.frame);
		frame.origin.y = round((self.superview.frame.size.height * percent) - (frame.size.height / 2));
		self.frame = frame;
	}
	else {
		NSLog(@"ERROR: UIView+PD sety called but superview is nil");
	}
}

-(void)setxp:(CGFloat)percent {
	if (self.superview) {
		CGRect frame = CGRectIntegral(self.frame);
		frame.origin.x = round((self.superview.frame.size.width * percent) - (frame.size.width / 2));
		self.frame = frame;
	}
	else {
		NSLog(@"ERROR: UIView+PD sety called but superview is nil");
	}
}

-(void)setwp:(CGFloat)percent {
	if (self.superview) {
		CGRect frame = CGRectIntegral(self.frame);
		frame.size.width = round(self.superview.frame.size.width * percent);
		self.frame = frame;
	}
	else {
		NSLog(@"ERROR: UIView+PD setwp called but superview is nil");
	}
}

-(void)sethp:(CGFloat)percent {
	if (self.superview) {
		CGRect frame = CGRectIntegral(self.frame);
		frame.size.height = round(self.superview.frame.size.height * percent);
		self.frame = frame;
	}
	else {
		NSLog(@"ERROR: UIView+PD sethp called but superview is nil");
	}
}

- (void)addGreyBackground { 	
	UIImageView *bgview = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:30]];
	bgview.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
	if (![self respondsToSelector:@selector(setBackgroundView:)]) {
		[self addSubview:bgview];
		[self sendSubviewToBack:bgview];
	}
	else {
		[self performSelector:@selector(setBackgroundView:) withObject:bgview];
	}
	
	[bgview release];
}


//positioning
- (void)sety:(int)y {
	CGRect frame = CGRectIntegral(self.frame);
	frame.origin.y = y;
	self.frame = frame;
}

- (void)setx:(int)x {
	CGRect frame = CGRectIntegral(self.frame);
	frame.origin.x = x;
	self.frame = frame;
}


- (void)setw:(int)width {
	CGRect frame = CGRectIntegral(self.frame);
	frame.size.width = width;
	self.frame = frame;
}

- (void)seth:(int)height {
	CGRect frame = CGRectIntegral(self.frame);
	frame.size.height = height;
	self.frame = frame;
}

+ (UIImageView *) horizontalRule {
	UIImageView *hr = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_hr.png"]];
	[hr sizeToFit];
	[hr setw:200];
	hr.layer.opacity = 0.7f;
	
	return hr;
}

@end
