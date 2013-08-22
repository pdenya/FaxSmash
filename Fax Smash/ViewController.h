//
//  ViewController.h
//  Fax Smash
//
//  Created by Paul Denya on 9/26/12.
//  Copyright (c) 2012 NEXTMARVEL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SettingsView;

@interface ViewController : UIViewController {
	UIImageView *batView;
	CGRect batFrame;
	NSMutableArray *faxpics;
	UIImageView *faxView;
	UIImageView *nextImageView;
	int currentIndex;
	UIImage *nextImage;
	int nextImageIndex;
	BOOL isFinished;
	UIButton *restartButton;
	UIButton *settingsButton;
	UIImageView *bangView;
	CGAffineTransform batTransform;
	CGAffineTransform batTransformDefault;
	SettingsView *settings;
	BOOL switchImageThisTime;
}

@property (nonatomic, retain) NSMutableArray *faxpics;
@property (nonatomic, retain) UIImage *nextImage;
@property (nonatomic, retain) UIButton *restartButton;
@property (nonatomic, retain) UIImageView *bangView;
@property (nonatomic, retain) UIButton *settingsButton;
@property (nonatomic, retain) SettingsView *settings;
@property (readwrite) BOOL switchImageThisTime;

@end
