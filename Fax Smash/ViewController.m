//
//  ViewController.m
//  Fax Smash
//
//  Created by Paul Denya on 9/26/12.
//  Copyright (c) 2012 NEXTMARVEL. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <AudioToolbox/AudioToolbox.h>
#import "SettingsView.h"
#import "SoundManager.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize faxpics, nextImage, restartButton, bangView, settingsButton, settings, switchImageThisTime;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	//get fax images
	// Got this to work by adding a build phase for copy files with a subdirectory.  Nothing to do with actual folder structure.
	self.faxpics = [NSMutableArray arrayWithArray:[[NSBundle mainBundle] pathsForResourcesOfType:@".jpg" inDirectory:@"faxpics"]];
	self.switchImageThisTime = NO;
	
	//default fax smash step
	currentIndex = 0;

	//add fax view
	faxView = [[UIImageView alloc] initWithFrame:self.view.bounds];
	faxView.contentMode = UIViewContentModeScaleAspectFill;
	[self loadNextImage];
	[self.view addSubview:faxView];
	
	//create bat, center and hide below bottom threshold
	batView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bat.png"]];
	CGRect frame = batView.frame;
	frame.origin.x = self.view.frame.size.width + 20;
	frame.origin.y = self.view.frame.size.height - 20;
	frame.size.width *= 1.2;
	frame.size.height *= 1.2;
	batView.frame = frame;
	batView.autoresizesSubviews = NO;
	batView.contentMode = UIViewContentModeCenter;
	[self.view addSubview:batView];

	//store original batframe
	batFrame = batView.frame;
	batView.transform = CGAffineTransformMakeRotation(5 * M_PI / 180.0);
	batTransformDefault = batView.transform;
	batTransform = CGAffineTransformMakeRotation(30 * M_PI / 180.0);
	
	self.bangView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bang.png"]];
	[self.bangView sizeToFit];
	[self.view addSubview:self.bangView];
	[self.bangView setwp:0.5f];
	[self.bangView seth:[self.bangView w]];
	[self.bangView setxp:0.5f];
	[self.bangView setyp:0.5f];
	self.bangView.alpha = 0.3f;
	self.bangView.hidden = YES;

	//make sure batview is on top
	[self.view bringSubviewToFront:batView];
	
	//smash tap handler
	UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(smash:)];
	singleTapGestureRecognizer.numberOfTapsRequired = 1;
	[self.view addGestureRecognizer:singleTapGestureRecognizer];
	[singleTapGestureRecognizer release];
	

	UIView *palleteView = [[UIView alloc] init];
	[self.view addSubview:palleteView];
	[palleteView setw:[self.view w]];
	[palleteView sethp:0.12f];
	[palleteView sety:0];
	[palleteView setx:0];
	[palleteView setBackgroundColor:[UIColor colorWithHex:0xCCCCCC]];
	palleteView.layer.shadowColor = [UIColor colorWithHex:0x333333].CGColor;
	palleteView.layer.shadowOffset = CGSizeMake(0.0, 1.0);
	palleteView.layer.shadowOpacity = 0.8f;
	palleteView.layer.cornerRadius = 2.0f;
	palleteView.alpha = 0.95f;
	[self.view bringSubviewToFront:palleteView];
	
	//restart button
	self.restartButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.restartButton setBackgroundImage:[[UIImage imageNamed:@"button_green.png"] stretchableImageWithLeftCapWidth:4 topCapHeight:30] forState:UIControlStateNormal];
	[self.restartButton setTitle:@"Reset" forState:UIControlStateNormal];
	self.restartButton.titleLabel.shadowColor = [UIColor colorWithHex:0x555555];
	self.restartButton.titleLabel.shadowOffset = CGSizeMake(0,-1);
	self.restartButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
	
	//padding
	UIEdgeInsets titleInsets = UIEdgeInsetsMake(0.0f, 4.0f, 0.0f, -4.0f);
	UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 5.0f);
	
	//extra width required for title centering
	contentInsets.right += (titleInsets.left - titleInsets.right);
	
	[self.restartButton setTitleEdgeInsets:titleInsets];
	[self.restartButton setContentEdgeInsets:contentInsets];
	[palleteView addSubview:self.restartButton];
	[self.restartButton sizeToFit];
	[self.restartButton sethp:0.6f];
	[self.restartButton addTarget:self action:@selector(startOver:) forControlEvents:UIControlEventTouchUpInside];
	[self.restartButton setyp:0.5f];
	[self.restartButton setx:[palleteView w] - [self.restartButton w] - 10];
	
	UIImageView *weaponview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bat_thumb.png"]];
	[palleteView addSubview:weaponview];
	[weaponview sethp:0.7f];
	[weaponview setwp:0.3f];
	[weaponview setx:7];
	[weaponview setyp:0.5f];
	weaponview.contentMode = UIViewContentModeScaleAspectFit;
	weaponview.backgroundColor = [UIColor colorWithHex:0x4486be];
	weaponview.layer.borderColor = [UIColor colorWithHex:0x4486be].CGColor;
	weaponview.layer.borderWidth = 2.0f;
	weaponview.layer.cornerRadius = 3.0f;
	
	self.settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.settingsButton setBackgroundImage:[[UIImage imageNamed:@"button_green.png"] stretchableImageWithLeftCapWidth:4 topCapHeight:30] forState:UIControlStateNormal];
	[self.settingsButton setTitle:@"Settings" forState:UIControlStateNormal];
	self.settingsButton.titleLabel.shadowColor = [UIColor colorWithHex:0x555555];
	self.settingsButton.titleLabel.shadowOffset = CGSizeMake(0,-1);
	self.settingsButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
	
	[self.settingsButton setTitleEdgeInsets:titleInsets];
	[self.settingsButton setContentEdgeInsets:contentInsets];
	[palleteView addSubview:self.settingsButton];
	[self.settingsButton sizeToFit];
	[self.settingsButton sethp:0.6f];
	[self.settingsButton addTarget:self action:@selector(showSettings:) forControlEvents:UIControlEventTouchUpInside];
	[self.settingsButton setyp:0.5f];
	[self.settingsButton setx:[self.restartButton x] - [self.settingsButton w] - 10];
	
	
	self.settings = [[SettingsView alloc] initWithFrame:self.view.bounds];
	
	[SoundManager sharedManager].allowsBackgroundMusic = YES;
	[[SoundManager sharedManager] prepareToPlay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
	return NO;
}

- (void)smash:(id)sender {
	self.switchImageThisTime = (int)arc4random() % 3 == 0;
	
	if ([settings isSoundOn]) {
		[[SoundManager sharedManager] stopAllSounds];
		NSString *soundname;
		
		if (self.switchImageThisTime) {
			soundname = [NSString stringWithFormat:@"smashchange%i", (arc4random() % 4) + 1];
		} else {
			soundname = @"smashdefault";
		}
		
		NSLog(@"soundname: %@", soundname);
		[[SoundManager sharedManager] playSound:soundname];
	}
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationBeginsFromCurrentState:NO];
	[UIView setAnimationDuration:0.1];
	[UIView setAnimationDelay:0.0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDidStopSelector:@selector(smashAnimationFinished:)];
	[UIView setAnimationDelegate:self];
	
	CGRect frame = batFrame;
	frame.size.width *= .7;
	frame.size.height *= .7;
	
	int jitter = (int)arc4random() % (int)(self.view.frame.size.height / 16);
	frame.origin.y = self.view.frame.size.height / 2 - 50 + jitter;
	
	jitter = (int)arc4random() % (int)(self.view.frame.size.width / 4);
	frame.origin.x = (self.view.frame.size.width / 2 - frame.size.width / 2) + jitter;
	
	batView.frame = frame;
	batView.transform = batTransformDefault;
	
	self.bangView.center = batView.center;
	[self.bangView sety:batView.frame.origin.y - ([self.bangView h] / 3)];
	
	[UIView commitAnimations];
	
	//vibrate
	if ([settings isVibrateOn]) {
		[self performSelectorInBackground:@selector(vibrate) withObject:nil];
	}
}

- (void)smashAnimationFinished:(id)sender {
	self.bangView.hidden = NO;
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.1f];
	[UIView setAnimationDelay:0.0f];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	
	//slide view back down
	batView.frame = batFrame;
	batView.transform = batTransform;
	
	[UIView commitAnimations];
	
	currentIndex++;
	if (currentIndex >= [faxpics count] - 1) {
		[self performSelectorOnMainThread:@selector(finishedDestroyingFax) withObject:nil waitUntilDone:NO];
	}
	else {
		if (self.switchImageThisTime) {
			self.switchImageThisTime = NO;
			[self loadNextImage];
		}
	}
	
	[self performSelector:@selector(hideBang) withObject:nil afterDelay:0.05f];
}

- (void)finishedDestroyingFax {
	NSLog(@"finishedDestroyingFax");
}

- (void)loadNextImage {
	if (self.nextImage && currentIndex == nextImageIndex) {
		faxView.image = self.nextImage;
		self.nextImage = nil;
		[self performSelectorInBackground:@selector(preloadImage) withObject:nil];
	}
	else {
		faxView.image = [UIImage imageWithContentsOfFile:self.faxpics[currentIndex]];
	}
}

- (void)preloadImage {
	nextImageIndex = currentIndex + 1;
	self.nextImage = [UIImage imageWithContentsOfFile:self.faxpics[nextImageIndex]];
}

- (void)startOver:(id)sender {
	NSLog(@"start over");
	currentIndex = 0;
	[self loadNextImage];
}

- (void)showSettings:(id)sender {
	[self.view addSubview:settings];
	[self.view bringSubviewToFront:settings];
}

- (void)vibrate {
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}


-(void)hideBang {
	self.bangView.hidden = YES;
}
@end
