//
//  wistleDogAppDelegate.h
//  wistleDog
//
//  Created by Moises Swiczar on 2/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GANTracker.h"
#define TRAKERGOOGLE @"UA-19434553-1"

@interface wistleDogAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController * thenavigationMain;
	BOOL is_simulator;
	BOOL is_ipod;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic) BOOL is_ipod;
@property (nonatomic) BOOL is_simulator;
-(void) trackpage:(NSString*) thestr;


@end

