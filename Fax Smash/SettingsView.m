//
//  SettingsView.m
//  Fax Smash
//
//  Created by Paul Denya on 1/21/13.
//  Copyright (c) 2013 NEXTMARVEL. All rights reserved.
//

#import "SettingsView.h"
#import <QuartzCore/QuartzCore.h>

@implementation SettingsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		self.backgroundColor = [UIColor colorWithHex:0xCCCCCC];
		
		self.layer.shadowColor = [UIColor colorWithHex:0x333333].CGColor;
		self.layer.shadowOffset = CGSizeMake(0.0, 1.0);
		self.layer.shadowOpacity = 0.8f;
		self.layer.cornerRadius = 2.0f;
		self.alpha = 0.95f;
		
		UILabel *titleLabel = [[UILabel alloc] init];
		titleLabel.text = @"Settings";
		titleLabel.font = [UIFont boldSystemFontOfSize:30.0f];
		titleLabel.backgroundColor = [UIColor clearColor];
		[titleLabel sizeToFit];
		[self addSubview:titleLabel];
		[titleLabel setx:20];
		[titleLabel sety:20];
		titleLabel.textColor = [UIColor colorWithHex:0x1e1e1c];
		titleLabel.shadowColor = [UIColor colorWithHex:0xEEEEEE];
		titleLabel.shadowOffset = CGSizeMake(0,1);
		
		//padding
		UIEdgeInsets titleInsets = UIEdgeInsetsMake(0.0f, 4.0f, 0.0f, -4.0f);
		UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 10.0f);
		
		//extra width required for title centering
		contentInsets.right += (titleInsets.left - titleInsets.right);
		
		//restart button
		UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[cancelButton setBackgroundImage:[[UIImage imageNamed:@"button_grey.png"] stretchableImageWithLeftCapWidth:4 topCapHeight:30] forState:UIControlStateNormal];
		[cancelButton setTitle:@"×" forState:UIControlStateNormal];
		cancelButton.titleLabel.shadowColor = [UIColor colorWithHex:0x555555];
		cancelButton.titleLabel.shadowOffset = CGSizeMake(0,-1);
		cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:24.0f];
		[cancelButton setTitleEdgeInsets:titleInsets];
		[cancelButton setContentEdgeInsets:contentInsets];
		[self addSubview:cancelButton];
		[cancelButton sizeToFit];
		[cancelButton seth:40.0f];
		[cancelButton addTarget:self action:@selector(cancelSettings:) forControlEvents:UIControlEventTouchUpInside];
		[cancelButton sety:20];
		[cancelButton setx:[self w] - [cancelButton w] - 20];
		
		
		[self addVibrateSetting];
		[self addSoundSetting];
    }
    return self;
}

- (void)addVibrateSetting {
	UISwitch *vibrateSwitch = [[UISwitch alloc] init];
	[self addSubview:vibrateSwitch];
	[vibrateSwitch setx:20];
	[vibrateSwitch setyp:0.2f];
	vibrateSwitch.on = [self isVibrateOn];
	[vibrateSwitch addTarget:self action:@selector(saveVibrate:) forControlEvents:UIControlEventValueChanged];
	
	UILabel *vibrateLabel = [[UILabel alloc] init];
	[vibrateLabel setText:@"Vibrate"];
	vibrateLabel.textColor = [UIColor blackColor];
	vibrateLabel.font = [UIFont boldSystemFontOfSize:20.0f];
	vibrateLabel.backgroundColor = [UIColor clearColor];
	[self addSubview:vibrateLabel];
	[vibrateLabel sizeToFit];
	vibrateLabel.center = vibrateSwitch.center;
	[vibrateLabel setx:[vibrateSwitch rightEdge] + 20];
	vibrateLabel.textColor = [UIColor colorWithHex:0x1e1e1c];
	vibrateLabel.shadowColor = [UIColor colorWithHex:0xEEEEEE];
	vibrateLabel.shadowOffset = CGSizeMake(0,1);


	[vibrateLabel release];
	[vibrateSwitch release];
}

- (void)saveVibrate:(id)sender {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	UISwitch *vibrateSwitch = (UISwitch *)sender;
	if (vibrateSwitch.on) {
		[defaults setValue:@"YES" forKey:@"vibrate_on"];
	}
	else {
		[defaults removeObjectForKey:@"vibrate_on"];
	}
}

- (BOOL)isVibrateOn {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults valueForKey:@"vibrate_on"]) {
		return YES;
	}
	
	return NO;
}

- (void)addSoundSetting {
	UISwitch *soundSwitch = [[UISwitch alloc] init];
	[self addSubview:soundSwitch];
	[soundSwitch setx:20];
	[soundSwitch setyp:0.3f];
	soundSwitch.on = [self isVibrateOn];
	[soundSwitch addTarget:self action:@selector(saveSound:) forControlEvents:UIControlEventValueChanged];
	
	UILabel *soundLabel = [[UILabel alloc] init];
	[soundLabel setText:@"Sound"];
	soundLabel.textColor = [UIColor blackColor];
	soundLabel.font = [UIFont boldSystemFontOfSize:20.0f];
	soundLabel.backgroundColor = [UIColor clearColor];
	[self addSubview:soundLabel];
	[soundLabel sizeToFit];
	soundLabel.center = soundSwitch.center;
	[soundLabel setx:[soundSwitch rightEdge] + 20];
	soundLabel.textColor = [UIColor colorWithHex:0x1e1e1c];
	soundLabel.shadowColor = [UIColor colorWithHex:0xEEEEEE];
	soundLabel.shadowOffset = CGSizeMake(0,1);
	
	
	[soundLabel release];
	[soundSwitch release];
}

- (void)saveSound:(UISwitch *)sender {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	UISwitch *soundSwitch = (UISwitch *)sender;
	if (soundSwitch.on) {
		[defaults setValue:@"YES" forKey:@"sound_on"];
	}
	else {
		[defaults removeObjectForKey:@"sound_on"];
	}
}

- (BOOL)isSoundOn {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults valueForKey:@"sound_on"]) {
		return YES;
	}
	
	return NO;
}

//actions
- (void)saveSettings:(id)sender {
	
}

- (void)cancelSettings:(id)sender {
	[self removeFromSuperview];
}

@end
